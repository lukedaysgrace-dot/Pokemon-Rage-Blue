#!/usr/bin/env python3
"""Static integrity checks for trainer, move, species, and encounter data."""

from __future__ import annotations

import argparse
import re
from dataclasses import dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PARTY_LENGTH = 6
TOGGLEABLE_OBJECTS_PER_MAP = 16
SPRITE_SET_LENGTH = 11
WALKING_SPRITES_PER_SET = 9
POKEDEX_CATEGORY_WIDTH = 10
POKEDEX_TEXT_WIDTH = 18


@dataclass(frozen=True)
class Mon:
    level: int
    species: str


def constants(path: Path, prefix: str = "const") -> list[str]:
    result: list[str] = []
    pattern = re.compile(rf"^\s*{re.escape(prefix)}\s+([A-Z][A-Z0-9_]*)\b")
    for raw in path.read_text(encoding="utf-8").splitlines():
        match = pattern.match(raw.split(";", 1)[0])
        if match:
            result.append(match.group(1))
    return result


def source_lines(path: Path) -> list[tuple[int, str]]:
    """Return non-empty assembly source lines with comments removed."""
    return [
        (number, line)
        for number, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1)
        if (line := raw.split(";", 1)[0].strip())
    ]


def parse_parties(path: Path, species: set[str]) -> tuple[dict[str, list[list[Mon]]], list[str]]:
    parties: dict[str, list[list[Mon]]] = {}
    errors: list[str] = []
    current: str | None = None
    for number, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        line = raw.split(";", 1)[0].strip()
        label = re.match(r"^([A-Za-z_][A-Za-z0-9_]*Data):$", line)
        if label:
            current = label.group(1)
            parties.setdefault(current, [])
            continue
        if current is None or not line.startswith("db "):
            continue
        tokens = [token.strip() for token in line[3:].split(",")]
        if not tokens or tokens[-1] != "0":
            errors.append(f"{path.name}:{number}: trainer party is not 0-terminated")
            continue
        tokens.pop()
        mons: list[Mon] = []
        try:
            if tokens and tokens[0].upper() == "$FF":
                fields = tokens[1:]
                if len(fields) % 2:
                    raise ValueError("variable-level party has an unmatched level/species field")
                mons = [
                    Mon(int(fields[index], 0), fields[index + 1])
                    for index in range(0, len(fields), 2)
                ]
            elif tokens:
                level = int(tokens[0], 0)
                mons = [Mon(level, token) for token in tokens[1:]]
        except (ValueError, IndexError) as exc:
            errors.append(f"{path.name}:{number}: {exc}")
            continue
        if not mons:
            errors.append(f"{path.name}:{number}: empty trainer party")
        if len(mons) > PARTY_LENGTH:
            errors.append(f"{path.name}:{number}: party has {len(mons)} Pokémon (maximum {PARTY_LENGTH})")
        for mon in mons:
            if not 1 <= mon.level <= 100:
                errors.append(f"{path.name}:{number}: invalid level {mon.level}")
            if mon.species not in species:
                errors.append(f"{path.name}:{number}: unknown species {mon.species}")
        parties[current].append(mons)
    return parties, errors


def trainer_pointer_map(version: str) -> dict[str, str]:
    trainer_names = [
        name
        for name in constants(ROOT / "constants/trainer_constants.asm", "trainer_const")
        if name != "NOBODY" and (version == "blue" or name != "EXILE_BRUNO")
    ]
    text = (ROOT / "data/trainers/parties.asm").read_text(encoding="utf-8")
    block = text.split("TrainerDataPointers:", 1)[1].split("assert_table_length", 1)[0]
    pointers: list[str] = []
    active = True
    for raw in block.splitlines():
        line = raw.split(";", 1)[0].strip()
        if line == "IF DEF(_BLUE)":
            active = version == "blue"
            continue
        if line == "ENDC":
            active = True
            continue
        match = re.match(r"dw\s+([A-Za-z_][A-Za-z0-9_]*)", line)
        if active and match:
            pointers.append(match.group(1))
    if len(trainer_names) != len(pointers):
        raise ValueError(
            f"{version}: {len(trainer_names)} trainer constants but {len(pointers)} party pointers"
        )
    result = dict(zip(trainer_names, pointers))
    result["KAREN"] = result["BRUNO"]
    result["UNUSED_JUGGLER"] = result["ARIANA"]
    return result


def validate_custom_moves(
    version: str,
    parties: dict[str, list[list[Mon]]],
    pointers: dict[str, str],
    moves: set[str],
) -> list[str]:
    path = ROOT / f"data/trainers/custom_trainer_moves_table_{version}.asm"
    errors: list[str] = []
    seen: set[tuple[str, int, int]] = set()
    entry = re.compile(
        r"^db\s+([A-Z][A-Z0-9_]*),\s*(\d+),\s*(\d+),\s*"
        r"([A-Z][A-Z0-9_]*),\s*([A-Z][A-Z0-9_]*),\s*"
        r"([A-Z][A-Z0-9_]*),\s*([A-Z][A-Z0-9_]*)\s*$"
    )
    for number, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        line = raw.split(";", 1)[0].strip()
        if not line.startswith("db ") or line == "db $ff":
            continue
        match = entry.match(line)
        if not match:
            errors.append(f"{path.name}:{number}: malformed custom-move record")
            continue
        trainer, party_no_text, slot_text, *record_moves = match.groups()
        party_no, slot = int(party_no_text), int(slot_text)
        key = trainer, party_no, slot
        if key in seen:
            errors.append(f"{path.name}:{number}: duplicate custom-move record {key}")
        seen.add(key)
        pointer = pointers.get(trainer)
        if pointer is None:
            errors.append(f"{path.name}:{number}: unknown trainer class {trainer}")
            continue
        trainer_parties = parties.get(pointer, [])
        if party_no and party_no > len(trainer_parties):
            errors.append(
                f"{path.name}:{number}: {trainer} party {party_no} does not exist "
                f"(only {len(trainer_parties)})"
            )
            continue
        if party_no:
            party = trainer_parties[party_no - 1]
            if not 1 <= slot <= len(party):
                errors.append(
                    f"{path.name}:{number}: slot {slot} outside {trainer} party {party_no} "
                    f"(size {len(party)})"
                )
        elif not 1 <= slot <= PARTY_LENGTH:
            errors.append(f"{path.name}:{number}: wildcard party has invalid slot {slot}")
        for move in record_moves:
            if move not in moves:
                errors.append(f"{path.name}:{number}: unknown move {move}")
    return errors


def validate_map_trainers(
    version: str, parties: dict[str, list[list[Mon]]], pointers: dict[str, str]
) -> list[str]:
    errors: list[str] = []
    reference = re.compile(r"\bOPP_([A-Z][A-Z0-9_]*),\s*(\d+)\s*(?:,|$)")
    for path in sorted((ROOT / "data/maps/objects").glob("*.asm")):
        for number, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
            for trainer, party_no_text in reference.findall(raw.split(";", 1)[0]):
                if trainer == "EXILE_BRUNO" and version == "red":
                    continue
                pointer = pointers.get(trainer)
                if pointer is None:
                    errors.append(f"{path.relative_to(ROOT)}:{number}: unknown trainer {trainer}")
                    continue
                party_no = int(party_no_text)
                available = len(parties.get(pointer, []))
                if not 1 <= party_no <= available:
                    errors.append(
                        f"{path.relative_to(ROOT)}:{number}: {trainer} party {party_no} "
                        f"does not exist (only {available})"
                    )
    return errors


def validate_version_parity(
    red: dict[str, list[list[Mon]]], blue: dict[str, list[list[Mon]]]
) -> list[str]:
    """Keep version-exclusive species from accidentally changing party shape or levels."""
    errors: list[str] = []
    allowed_blue_only = {"ExileBrunoData"}
    allowed_shape_differences = {("SuperNerdData", 10)}
    red_only = set(red) - set(blue)
    blue_only = set(blue) - set(red) - allowed_blue_only
    for label in sorted(red_only):
        errors.append(f"trainer table exists only in Red: {label}")
    for label in sorted(blue_only):
        errors.append(f"trainer table exists only in Blue: {label}")
    for label in sorted(set(red) & set(blue)):
        if len(red[label]) != len(blue[label]):
            errors.append(
                f"{label}: Red has {len(red[label])} parties but Blue has {len(blue[label])}"
            )
            continue
        for party_no, (red_party, blue_party) in enumerate(
            zip(red[label], blue[label]), 1
        ):
            if (label, party_no) in allowed_shape_differences:
                continue
            red_levels = [mon.level for mon in red_party]
            blue_levels = [mon.level for mon in blue_party]
            if red_levels != blue_levels:
                errors.append(
                    f"{label} party {party_no}: level layout differs by version "
                    f"(Red {red_levels}, Blue {blue_levels})"
                )
            if len(red_party) != len(blue_party):
                errors.append(
                    f"{label} party {party_no}: party size differs by version "
                    f"(Red {len(red_party)}, Blue {len(blue_party)})"
                )

    # These Blue rosters were historically overwritten by a level-generation
    # tool that copied Red species into both versions. Keep their version
    # identity explicit so a future progression pass cannot silently erase it.
    expected_blue_parties = {
        ("BirdKeeperData", 11): ("FEAROW", "MURKROW", "PIDGEOTTO"),
        ("BlackbeltData", 8): ("MACHAMP", "ANNIHILAPE", "HITMONCHAN"),
        ("BrunoKarenData", 1): ("UMBREON", "HONCHKROW", "BISHARP", "TYRANITAR", "HOUNDOOM", "WEAVILE"),
        ("BrunoKarenData", 2): ("UMBREON", "HONCHKROW", "WEAVILE", "TYRANITAR", "BISHARP", "HOUNDOOM"),
        ("BurglarData", 7): ("HOUNDOOM", "NINETALES"),
        ("BurglarData", 8): ("MAGMORTAR", "RAPIDASH"),
        ("CooltrainerFData", 3): ("PARASECT", "DEWGONG", "BLISSEY"),
        ("CooltrainerMData", 9): ("RHYPERIOR", "DONPHAN"),
        ("CooltrainerMData", 10): ("NIDOQUEEN", "GOLURK", "RHYPERIOR"),
        ("FisherData", 9): ("KINGLER", "LANTURN", "KINGLER", "KINGLER", "GYARADOS"),
        ("GiovanniData", 3): ("DUGTRIO", "NIDOQUEEN", "NIDOKING", "RHYPERIOR", "DONPHAN", "MAROWAK"),
        ("JugglerData", 2): ("HYPNO", "ELECTIVIRE", "MESMERIA", "ALAKAZAM"),
        ("LoreleiData", 1): ("DEWGONG", "CLOYSTER", "SLOWBRO", "MESMERIA", "GLACEON", "LAPRAS"),
        ("PokemaniacData", 6): ("PUPITAR", "LAPRAS", "TAUROS"),
        ("RocketData", 23): ("GOLBAT", "SNEASEL", "RATICATE"),
        ("RocketData", 24): ("RATICATE", "HOUNDOOM", "RATICATE"),
        ("ScientistData", 5): ("PORYGONZ",),
        ("ScientistData", 6): ("MAGNETON", "PORYGON2", "WEEZING", "MAGNETON"),
        ("ScientistData", 12): ("MAGNEZONE", "MAGNEZONE", "PORYGON2"),
        ("ScientistData", 13): ("MAGNEZONE", "ELECTRODE"),
        ("SuperNerdData", 10): ("HOUNDOOM", "MAGMORTAR"),
        ("SuperNerdData", 11): ("MAGMAR", "NINETALES"),
        ("SuperNerdData", 12): ("MAGMORTAR", "RAPIDASH", "HOUNDOOM"),
        ("SwimmerData", 14): ("STARMIE", "SEADRA"),
        ("SwimmerFData", 9): ("SEADRA", "LANTURN", "SEAKING"),
        ("TamerData", 3): ("RHYPERIOR",),
    }
    for (label, party_no), expected in expected_blue_parties.items():
        actual = tuple(mon.species for mon in blue[label][party_no - 1])
        if actual != expected:
            errors.append(
                f"{label} party {party_no}: Blue roster regression "
                f"(expected {expected}, found {actual})"
            )
    return errors


MAIN_BOSSES: list[tuple[str, str, int]] = [
    ("Brock", "BrockData", 1),
    ("Misty", "MistyData", 1),
    ("Lt. Surge", "LtSurgeData", 1),
    ("Erika", "ErikaData", 1),
    ("Koga", "KogaData", 1),
    ("Sabrina", "SabrinaData", 1),
    ("Blaine", "BlaineData", 1),
    ("Giovanni", "GiovanniData", 3),
    ("Green (Indigo)", "GreenData", 10),
    ("Lorelei", "LoreleiData", 1),
    ("Bruno/Karen", "BrunoKarenData", 1),
    ("Agatha", "AgathaData", 1),
    ("Lance", "LanceData", 1),
    ("Champion", "Rival3Data", 1),
]

GYM_REMATCHES: list[tuple[str, str, int]] = [
    ("Brock", "BrockData", 2),
    ("Misty", "MistyData", 2),
    ("Lt. Surge", "LtSurgeData", 2),
    ("Erika", "ErikaData", 2),
    ("Koga", "KogaData", 2),
    ("Sabrina", "SabrinaData", 2),
    ("Blaine", "BlaineData", 2),
    ("Giovanni", "GiovanniData", 4),
]

ELITE_FOUR_REMATCHES: list[tuple[str, str, int]] = [
    ("Lorelei", "LoreleiData", 2),
    ("Bruno/Karen", "BrunoKarenData", 2),
    ("Agatha", "AgathaData", 2),
    ("Lance", "LanceData", 2),
    ("Champion", "Rival3Data", 4),
]

POSTGAME_FINALE: list[tuple[str, str, int]] = [
    ("Green finale", "GreenData", 13),
    ("Professor Oak", "ProfOakData", 1),
    ("Blue Cloak", "BlueCloakData", 1),
]


def party_ace(parties: dict[str, list[list[Mon]]], label: str, party_no: int) -> int:
    return max(mon.level for mon in parties[label][party_no - 1])


def validate_curve_sequence(
    parties: dict[str, list[list[Mon]]],
    title: str,
    sequence: list[tuple[str, str, int]],
) -> list[str]:
    errors: list[str] = []
    previous_name: str | None = None
    previous_ace: int | None = None
    for name, label, party_no in sequence:
        if label not in parties or not 1 <= party_no <= len(parties[label]):
            errors.append(f"{title}: missing {name} ({label} party {party_no})")
            continue
        ace = party_ace(parties, label, party_no)
        if previous_ace is not None and ace < previous_ace:
            errors.append(
                f"{title}: {name}'s ace L{ace} falls below {previous_name}'s L{previous_ace}"
            )
        previous_name, previous_ace = name, ace
    return errors


def validate_level_curve(parties: dict[str, list[list[Mon]]]) -> list[str]:
    errors = validate_curve_sequence(parties, "main boss curve", MAIN_BOSSES)
    errors.extend(validate_curve_sequence(parties, "gym rematch curve", GYM_REMATCHES))
    errors.extend(
        validate_curve_sequence(parties, "Elite Four rematch curve", ELITE_FOUR_REMATCHES)
    )
    errors.extend(validate_curve_sequence(parties, "postgame finale curve", POSTGAME_FINALE))

    # The Indigo Plateau blocks the Elite Four rematch until all eight gym
    # rematches are complete, so Lorelei must start above the gym-rematch band.
    highest_gym_ace = max(
        party_ace(parties, label, party_no)
        for _, label, party_no in GYM_REMATCHES
    )
    first_e4_ace = party_ace(parties, ELITE_FOUR_REMATCHES[0][1], ELITE_FOUR_REMATCHES[0][2])
    if first_e4_ace <= highest_gym_ace:
        errors.append(
            f"Elite Four rematch starts at L{first_e4_ace}, not above the "
            f"gym-rematch ceiling L{highest_gym_ace}"
        )

    # Each column represents the same starter choice through that rival's story fights.
    rival_routes = [
        ("Rival 1", "Rival1Data", (1, 4, 7)),
        ("Rival 2", "Rival2Data", (1, 4, 7, 10)),
        ("Green", "GreenData", (1, 4, 7, 10, 13)),
    ]
    for name, label, starts in rival_routes:
        for variant in range(3):
            sequence = [
                (f"fight {fight + 1}", label, start + variant)
                for fight, start in enumerate(starts)
            ]
            errors.extend(
                validate_curve_sequence(
                    parties, f"{name} starter variant {variant + 1}", sequence
                )
            )

    # Every named rematch should be stronger than that trainer's first party.
    for name, label, rematch_no in GYM_REMATCHES + ELITE_FOUR_REMATCHES:
        first_ace = party_ace(parties, label, 1)
        rematch_ace = party_ace(parties, label, rematch_no)
        if rematch_ace <= first_ace:
            errors.append(
                f"{name} rematch ace L{rematch_ace} is not above the first fight's L{first_ace}"
            )

    for name, label, start, count in (
        ("Champion", "Rival3Data", 1, 3),
        ("Champion rematch", "Rival3Data", 4, 3),
        ("Blue Cloak", "BlueCloakData", 1, 3),
    ):
        expected = [mon.level for mon in parties[label][start - 1]]
        for party_no in range(start + 1, start + count):
            actual = [mon.level for mon in parties[label][party_no - 1]]
            if actual != expected:
                errors.append(
                    f"{name} starter variant {party_no - start + 1} has level "
                    f"layout {actual}, expected {expected}"
                )
    return errors


def validate_finale_gates() -> list[str]:
    """Verify the enforced Pokédex -> Green -> Oak -> Blue Cloak ending chain."""
    errors: list[str] = []
    pallet = (ROOT / "scripts/PalletTown.asm").read_text(encoding="utf-8")
    green_gate = pallet.split("PalletTownShouldShowGreen:", 1)[1].split(
        "PalletTownDexCompleteForGreen:", 1
    )[0]
    if "PalletTownDexCompleteForGreen" not in green_gate:
        errors.append("Pallet Green finale gate no longer requires the complete 150 dex")

    route1 = (ROOT / "scripts/Route1.asm").read_text(encoding="utf-8")
    oak_gate = route1.split("Route1UpdateOakVisibility:", 1)[1].split(
        "Route1DexComplete151:", 1
    )[0]
    if "Route1DexComplete151" not in oak_gate:
        errors.append("Professor Oak finale gate no longer requires the complete 151 dex")

    cinnabar = (ROOT / "scripts/CinnabarIsland.asm").read_text(encoding="utf-8")
    blue_cloak_gate = cinnabar.split("CinnabarIslandMaybeShowBlueCloak:", 1)[1].split(
        "CinnabarIsland_ScriptPointers:", 1
    )[0]
    if "EVENT_BEAT_ROUTE1_OAK" not in blue_cloak_gate:
        errors.append("Blue Cloak finale gate no longer requires defeating Professor Oak")
    ending = cinnabar.split("CinnabarIslandBlueCloakAfterBattleScript:", 1)[1].split(
        "CinnabarIslandDefaultScript:", 1
    )[0]
    if "CreditsRollOnly" not in ending:
        errors.append("Blue Cloak victory no longer reaches the ending credits")
    return errors


def boss_progression_report(parties: dict[str, list[list[Mon]]]) -> list[str]:
    output = ["main boss ace progression:"]
    for name, label, party_no in MAIN_BOSSES:
        output.append(f"  {name:20} L{party_ace(parties, label, party_no):02d}")
    output.append("postgame ace progression:")
    output.append(
        "  Gyms: "
        + " -> ".join(
            f"{name} L{party_ace(parties, label, party_no)}"
            for name, label, party_no in GYM_REMATCHES
        )
    )
    output.append(
        "  Elite Four: "
        + " -> ".join(
            f"{name} L{party_ace(parties, label, party_no)}"
            for name, label, party_no in ELITE_FOUR_REMATCHES
        )
    )
    output.append(
        "  Finale: "
        + " -> ".join(
            f"{name} L{party_ace(parties, label, party_no)}"
            for name, label, party_no in POSTGAME_FINALE
        )
    )
    return output


def validate_toggleable_objects() -> list[str]:
    """The WRAM list has room for at most 16 toggleable sprites for one map."""
    path = ROOT / "data/maps/toggleable_objects.asm"
    errors: list[str] = []
    current: str | None = None
    count = 0
    for number, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        line = raw.split(";", 1)[0].strip()
        match = re.match(r"toggleable_objects_for\s+([A-Z][A-Z0-9_]*)", line)
        if match:
            current, count = match.group(1), 0
            continue
        if current and line.startswith("toggle_object_state "):
            count += 1
            if count == TOGGLEABLE_OBJECTS_PER_MAP + 1:
                errors.append(
                    f"{path.relative_to(ROOT)}:{number}: {current} has more than "
                    f"{TOGGLEABLE_OBJECTS_PER_MAP} toggleable objects"
                )
    return errors


STORY_AREAS: list[tuple[str, tuple[str, ...]]] = [
    ("Viridian Forest", ("ViridianForest",)),
    ("Pewter Gym", ("PewterGym",)),
    ("Route 3 / Mt. Moon", ("Route3", "MtMoon1F", "MtMoonB2F")),
    ("Cerulean routes", ("Route24", "Route25")),
    ("Cerulean Gym", ("CeruleanGym",)),
    ("Routes 5-6", ("Route5", "Route6")),
    ("S.S. Anne", ("SSAnne1FRooms", "SSAnne2FRooms", "SSAnneB1FRooms")),
    ("Vermilion Gym", ("VermilionGym",)),
    ("Route 11", ("Route11",)),
    ("Routes 9-10 / Rock Tunnel", ("Route9", "Route10", "RockTunnel1F", "RockTunnelB1F")),
    ("Pokémon Tower", ("PokemonTower3F", "PokemonTower4F", "PokemonTower5F", "PokemonTower6F", "PokemonTower7F")),
    ("Celadon Gym", ("CeladonGym",)),
    ("Rocket Hideout", ("GameCorner", "RocketHideoutB1F", "RocketHideoutB2F", "RocketHideoutB3F", "RocketHideoutB4F")),
    ("Fighting Dojo", ("FightingDojo",)),
    ("Routes 12-18", ("Route12", "Route13", "Route14", "Route15", "Route16", "Route17", "Route18")),
    ("Fuchsia Gym", ("FuchsiaGym",)),
    ("Silph Co.", tuple(f"SilphCo{floor}F" for floor in range(1, 12))),
    ("Saffron Gym", ("SaffronGym",)),
    ("Sea routes", ("Route19", "Route20", "Route21")),
    ("Pokémon Mansion", ("PokemonMansion1F", "PokemonMansion2F", "PokemonMansion3F", "PokemonMansionB1F")),
    ("Cinnabar Gym", ("CinnabarGym",)),
    ("Viridian Gym", ("ViridianGym",)),
    ("Victory Road", ("VictoryRoad1F", "VictoryRoad2F", "VictoryRoad3F")),
]


def progression_report(
    parties: dict[str, list[list[Mon]]], pointers: dict[str, str]
) -> list[str]:
    reference = re.compile(r"\bOPP_([A-Z][A-Z0-9_]*),\s*(\d+)\s*(?:,|$)")
    by_map: dict[str, list[int]] = {}
    for path in (ROOT / "data/maps/objects").glob("*.asm"):
        levels: list[int] = []
        for raw in path.read_text(encoding="utf-8").splitlines():
            for trainer, party_no_text in reference.findall(raw.split(";", 1)[0]):
                pointer = pointers.get(trainer)
                party_no = int(party_no_text)
                if pointer and 1 <= party_no <= len(parties.get(pointer, [])):
                    levels.extend(mon.level for mon in parties[pointer][party_no - 1])
        by_map[path.stem] = levels

    output = ["story-area trainer levels (Red object trainers):"]
    for name, maps in STORY_AREAS:
        levels = [level for map_name in maps for level in by_map.get(map_name, [])]
        if not levels:
            continue
        mean = sum(levels) / len(levels)
        output.append(f"  {name:29} L{min(levels):02d}-L{max(levels):02d}  mean L{mean:04.1f}")
    return output


def validate_wild_data(species: set[str]) -> list[str]:
    errors: list[str] = []
    pair = re.compile(r"^\s*db\s+([0-9]+),\s*([A-Z][A-Z0-9_]*)\s*(?:;.*)?$")
    paths = list((ROOT / "data/wild/maps").glob("*.asm"))
    paths += [
        ROOT / "data/wild/old_rod.asm",
        ROOT / "data/wild/good_rod.asm",
        ROOT / "data/wild/super_rod.asm",
    ]
    for path in paths:
        for number, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
            match = pair.match(raw)
            if not match:
                continue
            level, mon = int(match.group(1)), match.group(2)
            if not 1 <= level <= 100:
                errors.append(f"{path.relative_to(ROOT)}:{number}: invalid wild level {level}")
            if mon not in species:
                errors.append(f"{path.relative_to(ROOT)}:{number}: unknown wild species {mon}")
    return errors


def pokedex_display_width(text: str) -> int:
    """Return the number of tiles a literal occupies on the Pokédex screen."""
    # The # control character expands to the four-tile string "POKé" at runtime.
    return len(text) + 3 * text.count("#")


def validate_pokedex_text() -> list[str]:
    """Keep Pokédex categories and description lines inside their screen fields."""
    errors: list[str] = []

    category_path = ROOT / "data/pokemon/dex_entries.asm"
    current: str | None = None
    for number, line in source_lines(category_path):
        label = re.match(r"^([A-Za-z0-9]+DexEntry):$", line)
        if label:
            current = label.group(1)
            continue
        category = re.match(r'^db\s+"([^"]*)@"$', line)
        if current and category:
            text = category.group(1)
            width = pokedex_display_width(text)
            if width > POKEDEX_CATEGORY_WIDTH:
                errors.append(
                    f"{category_path.relative_to(ROOT)}:{number}: {current} category "
                    f'"{text}" is {width} tiles (maximum {POKEDEX_CATEGORY_WIDTH})'
                )
            current = None

    text_path = ROOT / "data/pokemon/dex_text.asm"
    current = None
    page = 1
    page_lines = 0
    last_line: tuple[int, str, int] | None = None
    command = re.compile(r'^(text|next|page)\s+"([^"]*)"$')
    for number, line in source_lines(text_path):
        label = re.match(r"^_([A-Za-z0-9]+DexEntry)::$", line)
        if label:
            current = label.group(1)
            page = 1
            page_lines = 0
            last_line = None
            continue
        if current is None:
            continue
        match = command.match(line)
        if match:
            kind, text = match.groups()
            if kind == "page":
                if page_lines > 3:
                    errors.append(
                        f"{text_path.relative_to(ROOT)}:{number}: {current} page {page} "
                        f"has {page_lines} lines (maximum 3)"
                    )
                page += 1
                page_lines = 1
            else:
                page_lines += 1
            width = pokedex_display_width(text)
            if width > POKEDEX_TEXT_WIDTH:
                errors.append(
                    f"{text_path.relative_to(ROOT)}:{number}: {current} line "
                    f'"{text}" is {width} tiles (maximum {POKEDEX_TEXT_WIDTH})'
                )
            last_line = number, text, width
            continue
        if line != "dex":
            continue
        if page_lines > 3:
            errors.append(
                f"{text_path.relative_to(ROOT)}:{number}: {current} page {page} "
                f"has {page_lines} lines (maximum 3)"
            )
        if last_line is None:
            errors.append(f"{text_path.relative_to(ROOT)}:{number}: {current} has no text")
        else:
            last_number, text, width = last_line
            # The dex command appends a period after the final literal.
            if width + 1 > POKEDEX_TEXT_WIDTH:
                errors.append(
                    f"{text_path.relative_to(ROOT)}:{last_number}: {current} final line "
                    f'"{text}" uses {width + 1} tiles with its automatic period '
                    f"(maximum {POKEDEX_TEXT_WIDTH})"
                )
            if text.endswith((".", "!", "?")):
                errors.append(
                    f"{text_path.relative_to(ROOT)}:{last_number}: {current} final line "
                    "already has punctuation before the automatic Pokédex period"
                )
        current = None
    return errors


def validate_move_data(moves: list[str]) -> list[str]:
    """Check move rows and every move reference in species data."""
    errors: list[str] = []
    path = ROOT / "data/moves/moves.asm"
    effects = set(constants(ROOT / "constants/move_effect_constants.asm"))
    types = set(constants(ROOT / "constants/type_constants.asm"))
    row = re.compile(
        r"^move\s+([A-Z][A-Z0-9_]*),\s*([A-Z][A-Z0-9_]*),\s*"
        r"(\d+),\s*([A-Z][A-Z0-9_]*),\s*(\d+),\s*(\d+)\s*$"
    )
    parsed: list[str] = []
    for number, line in source_lines(path):
        if not line.startswith("move "):
            continue
        match = row.match(line)
        if not match:
            errors.append(f"{path.relative_to(ROOT)}:{number}: malformed move row")
            continue
        name, effect, power_text, move_type, accuracy_text, pp_text = match.groups()
        power, accuracy, pp = int(power_text), int(accuracy_text), int(pp_text)
        parsed.append(name)
        if effect not in effects:
            errors.append(f"{path.relative_to(ROOT)}:{number}: unknown effect {effect}")
        if move_type not in types:
            errors.append(f"{path.relative_to(ROOT)}:{number}: unknown type {move_type}")
        if not 0 <= power <= 255:
            errors.append(f"{path.relative_to(ROOT)}:{number}: power {power} is not a byte")
        if not 1 <= accuracy <= 100:
            errors.append(f"{path.relative_to(ROOT)}:{number}: invalid accuracy {accuracy}")
        if not 1 <= pp <= 40:
            errors.append(f"{path.relative_to(ROOT)}:{number}: invalid PP {pp}")
    expected = moves[1 : moves.index("STRUGGLE") + 1]
    if parsed != expected:
        for index, (actual, wanted) in enumerate(zip(parsed, expected), 1):
            if actual != wanted:
                errors.append(
                    f"{path.relative_to(ROOT)}: move row {index} is {actual}, expected {wanted}"
                )
                break
        if len(parsed) != len(expected):
            errors.append(
                f"{path.relative_to(ROOT)}: has {len(parsed)} move rows, expected {len(expected)}"
            )

    move_set = set(moves)
    for stats_path in sorted((ROOT / "data/pokemon/base_stats").glob("*.asm")):
        raw_lines = stats_path.read_text(encoding="utf-8").splitlines()
        for number, line in source_lines(stats_path):
            if line.startswith("tmhm "):
                referenced = re.findall(r"[A-Z][A-Z0-9_]*", line[5:])
            elif "level 1 learnset" in raw_lines[number - 1]:
                referenced = re.findall(r"[A-Z][A-Z0-9_]*", line[3:])
            else:
                continue
            for move in referenced:
                if move not in move_set:
                    errors.append(
                        f"{stats_path.relative_to(ROOT)}:{number}: unknown move {move}"
                    )
    return errors


def validate_pokemon_data(species: set[str], moves: set[str]) -> list[str]:
    """Validate National-Dex base rows and internal-ID evolution/learnset data."""
    errors: list[str] = []
    types = set(constants(ROOT / "constants/type_constants.asm"))
    growth_rates = set(constants(ROOT / "constants/pokemon_data_constants.asm"))
    dex_constants = constants(ROOT / "constants/pokedex_constants.asm")
    dex_set = set(dex_constants)
    include_path = ROOT / "data/pokemon/base_stats.asm"
    includes = [
        ROOT / match.group(1)
        for _, line in source_lines(include_path)
        if (match := re.match(r'^INCLUDE\s+"([^"]+)"$', line))
    ]
    if len(includes) != len(dex_constants):
        errors.append(
            f"{include_path.relative_to(ROOT)}: {len(includes)} base-stat includes, "
            f"expected {len(dex_constants)}"
        )
    seen_dex: list[str] = []
    first_stats = re.compile(r"^db\s+(\d+),\s*(\d+),\s*(\d+),\s*(\d+),\s*(\d+)\s*$")
    two_types = re.compile(r"^db\s+([A-Z][A-Z0-9_]*),\s*([A-Z][A-Z0-9_]*)\s*$")
    for stats_path in includes:
        if not stats_path.is_file():
            errors.append(f"{include_path.relative_to(ROOT)}: missing {stats_path.relative_to(ROOT)}")
            continue
        lines = source_lines(stats_path)
        dex_rows = [(n, m.group(1)) for n, line in lines if (m := re.match(r"^db\s+(DEX_[A-Z0-9_]+)$", line))]
        if len(dex_rows) != 1:
            errors.append(
                f"{stats_path.relative_to(ROOT)}: expected one Pokédex ID row, found {len(dex_rows)}"
            )
        else:
            number, dex_name = dex_rows[0]
            seen_dex.append(dex_name)
            if dex_name not in dex_set:
                errors.append(f"{stats_path.relative_to(ROOT)}:{number}: unknown {dex_name}")
        stat_rows = [(n, m) for n, line in lines if (m := first_stats.match(line))]
        if len(stat_rows) != 1:
            errors.append(
                f"{stats_path.relative_to(ROOT)}: expected one five-stat row, found {len(stat_rows)}"
            )
        else:
            number, match = stat_rows[0]
            for value in map(int, match.groups()):
                if not 1 <= value <= 255:
                    errors.append(f"{stats_path.relative_to(ROOT)}:{number}: invalid base stat {value}")
        type_rows = [(n, m) for n, line in lines if (m := two_types.match(line))]
        if not 1 <= len(type_rows) <= 2:
            errors.append(
                f"{stats_path.relative_to(ROOT)}: expected one type row per version, "
                f"found {len(type_rows)}"
            )
        else:
            for number, match in type_rows:
                for mon_type in match.groups():
                    if mon_type not in types:
                        errors.append(f"{stats_path.relative_to(ROOT)}:{number}: unknown type {mon_type}")
        growth_rows = [
            (n, m.group(1))
            for n, line in lines
            if (m := re.match(r"^db\s+(GROWTH_[A-Z0-9_]+)$", line))
        ]
        if len(growth_rows) != 1 or growth_rows[0][1] not in growth_rates:
            errors.append(f"{stats_path.relative_to(ROOT)}: missing or unknown growth rate")
        pic_rows = [
            (n, ROOT / m.group(1))
            for n, line in lines
            if (m := re.match(r'^INCBIN\s+"([^"]+\.pic)",\s*0,\s*1$', line))
        ]
        if len(pic_rows) != 1 or not pic_rows[0][1].is_file():
            errors.append(f"{stats_path.relative_to(ROOT)}: missing generated front-picture header")
        else:
            number, pic_path = pic_rows[0]
            dimensions = pic_path.read_bytes()[0]
            height, width = dimensions >> 4, dimensions & 0x0F
            if not 1 <= height <= 7 or not 1 <= width <= 7:
                errors.append(
                    f"{stats_path.relative_to(ROOT)}:{number}: invalid sprite dimensions "
                    f"{height}x{width} in {pic_path.relative_to(ROOT)}"
                )
    if seen_dex != dex_constants:
        errors.append(
            f"{include_path.relative_to(ROOT)}: base-stat include order does not match National Dex order"
        )

    # PokedexOrder bridges internal IDs to the National-Dex-ordered BaseStats table.
    order_path = ROOT / "data/pokemon/dex_order.asm"
    order = [
        match.group(1)
        for _, line in source_lines(order_path)
        if (match := re.match(r"^db\s+(DEX_[A-Z0-9_]+|0)$", line))
    ]
    nonzero = [entry for entry in order if entry != "0"]
    if len(nonzero) != len(set(nonzero)):
        errors.append(f"{order_path.relative_to(ROOT)}: duplicate nonzero Pokédex IDs")
    missing = dex_set - set(nonzero)
    extra = set(nonzero) - dex_set
    if missing or extra:
        errors.append(
            f"{order_path.relative_to(ROOT)}: Pokédex mapping mismatch "
            f"(missing {sorted(missing)}, extra {sorted(extra)})"
        )

    evos_path = ROOT / "data/pokemon/evos_moves.asm"
    current: str | None = None
    in_learnset = False
    previous_level = 0
    for number, line in source_lines(evos_path):
        label = re.match(r"^([A-Za-z][A-Za-z0-9_]*EvosMoves):$", line)
        if label:
            current = label.group(1)
            in_learnset = False
            previous_level = 0
            continue
        if current is None:
            continue
        if line == "db 0":
            if not in_learnset:
                in_learnset = True
            else:
                current = None
            continue
        if not line.startswith("db "):
            continue
        fields = [field.strip() for field in line[3:].split(",")]
        if not in_learnset:
            method = fields[0]
            try:
                if method == "EVOLVE_LEVEL" and len(fields) == 3:
                    level, target = int(fields[1], 0), fields[2]
                elif method == "EVOLVE_ITEM" and len(fields) == 4:
                    level, target = int(fields[2], 0), fields[3]
                elif method == "EVOLVE_TRADE" and len(fields) == 3:
                    level, target = int(fields[1], 0), fields[2]
                else:
                    continue
            except ValueError:
                errors.append(f"{evos_path.relative_to(ROOT)}:{number}: malformed evolution")
                continue
            if not 1 <= level <= 100:
                errors.append(f"{evos_path.relative_to(ROOT)}:{number}: invalid evolution level {level}")
            if target not in species:
                errors.append(f"{evos_path.relative_to(ROOT)}:{number}: unknown evolution {target}")
        elif len(fields) == 2:
            try:
                level = int(fields[0], 0)
            except ValueError:
                continue
            move = fields[1]
            if not 1 <= level <= 100:
                errors.append(f"{evos_path.relative_to(ROOT)}:{number}: invalid learn level {level}")
            if level < previous_level:
                errors.append(
                    f"{evos_path.relative_to(ROOT)}:{number}: learnset level {level} "
                    f"follows level {previous_level} in {current}"
                )
            previous_level = level
            if move not in moves:
                errors.append(f"{evos_path.relative_to(ROOT)}:{number}: unknown move {move}")
    return errors


def validate_sprite_sets() -> list[str]:
    """Protect the unbounded outdoor sprite lookup and fixed VRAM slot layout."""
    errors: list[str] = []
    pointer_path = ROOT / "data/sprites/sprites.asm"
    sprite_tiles: dict[str, int] = {}
    sprite_labels: dict[str, str] = {}
    pointer_row = re.compile(
        r"^overworld_sprite\s+([A-Za-z][A-Za-z0-9_]*),\s*(\d+)\s*$"
    )
    for number, raw in enumerate(pointer_path.read_text(encoding="utf-8").splitlines(), 1):
        line, _, comment = raw.partition(";")
        match = pointer_row.match(line.strip())
        sprite = re.search(r"\b(SPRITE_[A-Z0-9_]+)\b", comment)
        if match and sprite:
            label, tiles = match.groups()
            sprite_tiles[sprite.group(1)] = int(tiles)
            sprite_labels[sprite.group(1)] = label
    if not sprite_tiles:
        errors.append(f"{pointer_path.relative_to(ROOT)}: could not parse sprite pointer table")

    gfx_path = ROOT / "gfx/sprites.asm"
    gfx_rows: dict[str, Path] = {}
    for asm_path in sorted((ROOT / "gfx").rglob("*.asm")):
        for _, line in source_lines(asm_path):
            match = re.match(
                r'^([A-Za-z][A-Za-z0-9_]*):{1,2}\s+INCBIN\s+"([^"]+\.2bpp)"$',
                line,
            )
            if match:
                gfx_rows[match.group(1)] = ROOT / match.group(2)
    for sprite, label in sprite_labels.items():
        binary = gfx_rows.get(label)
        if binary is None or not binary.is_file():
            errors.append(f"{gfx_path.relative_to(ROOT)}: no generated graphics for {sprite} ({label})")
            continue
        tiles = sprite_tiles[sprite]
        # The first block must always be present. Some 12-tile sheets belong to
        # stationary NPCs and intentionally omit the optional walking block;
        # some 4-tile PNGs harmlessly contain a second pose.
        required_bytes = tiles * 16
        if binary.stat().st_size < required_bytes:
            errors.append(
                f"{binary.relative_to(ROOT)}: {binary.stat().st_size} bytes for {sprite}, "
                f"requires at least {required_bytes}"
            )

    set_path = ROOT / "data/maps/sprite_sets.asm"
    raw_lines = set_path.read_text(encoding="utf-8").splitlines()
    sprite_sets: dict[str, list[tuple[int, str]]] = {}
    in_sets = False
    current: str | None = None
    for number, raw in enumerate(raw_lines, 1):
        stripped = raw.strip()
        if stripped == "SpriteSets:":
            in_sets = True
            continue
        if not in_sets:
            continue
        label = re.match(r";\s*(SPRITESET_[A-Z0-9_]+)\s*$", stripped)
        if label:
            current = label.group(1)
            sprite_sets[current] = []
            continue
        match = re.match(r"db\s+(SPRITE_[A-Z0-9_]+)\s*(?:;.*)?$", stripped)
        if match and current:
            sprite_sets[current].append((number, match.group(1)))
    for set_name, entries in sprite_sets.items():
        if len(entries) != SPRITE_SET_LENGTH:
            errors.append(f"{set_path.relative_to(ROOT)}: {set_name} has {len(entries)} entries")
            continue
        names = [name for _, name in entries]
        if len(names) != len(set(names)):
            errors.append(f"{set_path.relative_to(ROOT)}: {set_name} contains duplicate sprite IDs")
        for index, (number, sprite) in enumerate(entries):
            wanted = 12 if index < WALKING_SPRITES_PER_SET else 4
            actual = sprite_tiles.get(sprite)
            if actual is None:
                errors.append(f"{set_path.relative_to(ROOT)}:{number}: unknown {sprite}")
            elif actual != wanted:
                errors.append(
                    f"{set_path.relative_to(ROOT)}:{number}: {sprite} uses {actual} tiles "
                    f"in a {wanted}-tile slot of {set_name}"
                )

    map_sets: dict[str, list[str]] = {}
    split_sets: dict[str, list[str]] = {}
    section = ""
    for raw in raw_lines:
        stripped = raw.strip()
        if stripped == "MapSpriteSets:":
            section = "map"
            continue
        if stripped == "SplitMapSpriteSets:":
            section = "split"
            continue
        if stripped == "SpriteSets:":
            break
        if section == "map":
            match = re.match(r"db\s+([A-Z0-9_]+)\s*;\s*([A-Z0-9_]+)", stripped)
            if match:
                set_name, map_name = match.groups()
                map_sets[re.sub(r"[^A-Z0-9]", "", map_name)] = [set_name]
        elif section == "split":
            match = re.match(
                r"db\s+[A-Z_]+,\s*\d+,\s*(SPRITESET_[A-Z0-9_]+),\s*"
                r"(SPRITESET_[A-Z0-9_]+)\s*;\s*(SPLITSET_[A-Z0-9_]+)",
                stripped,
            )
            if match:
                west, east, split_name = match.groups()
                split_sets[split_name] = list(dict.fromkeys((west, east)))
    for map_name, assigned in list(map_sets.items()):
        if assigned[0].startswith("SPLITSET_"):
            map_sets[map_name] = split_sets.get(assigned[0], [])

    object_row = re.compile(
        r"^object_event\s+[^,]+,\s*[^,]+,\s*(SPRITE_[A-Z0-9_]+)\s*,"
    )
    for object_path in sorted((ROOT / "data/maps/objects").glob("*.asm")):
        normalized = re.sub(r"[^A-Z0-9]", "", object_path.stem.upper())
        assigned = map_sets.get(normalized)
        if assigned is None:
            continue
        for number, line in source_lines(object_path):
            match = object_row.match(line)
            if not match:
                continue
            sprite = match.group(1)
            for set_name in assigned:
                members = {name for _, name in sprite_sets.get(set_name, [])}
                if sprite not in members:
                    errors.append(
                        f"{object_path.relative_to(ROOT)}:{number}: {sprite} is absent from "
                        f"active {set_name}; engine lookup would run past wSpriteSet"
                    )
    return errors


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--progression", action="store_true", help="print the story-area level curve")
    args = parser.parse_args()
    species_list = constants(ROOT / "constants/pokemon_constants.asm")
    species = set(species_list)
    species -= {"NO_MON"}
    moves_list = constants(ROOT / "constants/move_constants.asm")
    moves = set(moves_list)
    errors: list[str] = []
    summaries: list[str] = []
    red_progression: tuple[dict[str, list[list[Mon]]], dict[str, str]] | None = None
    version_parties: dict[str, dict[str, list[list[Mon]]]] = {}

    for version in ("red", "blue"):
        parties, party_errors = parse_parties(
            ROOT / f"data/trainers/parties_{version}.asm", species
        )
        version_parties[version] = parties
        errors.extend(party_errors)
        try:
            pointers = trainer_pointer_map(version)
        except ValueError as exc:
            errors.append(str(exc))
            continue
        for trainer, pointer in pointers.items():
            if pointer not in parties:
                errors.append(f"{version}: {trainer} points to missing {pointer}")
        errors.extend(validate_custom_moves(version, parties, pointers, moves))
        errors.extend(validate_map_trainers(version, parties, pointers))
        errors.extend(validate_level_curve(parties))
        if version == "red":
            red_progression = parties, pointers
        party_count = sum(len(items) for items in parties.values())
        mon_count = sum(len(party) for items in parties.values() for party in items)
        summaries.append(
            f"{version}: {len(parties)} party tables, {party_count} parties, {mon_count} Pokémon"
        )

    if "red" in version_parties and "blue" in version_parties:
        errors.extend(validate_version_parity(version_parties["red"], version_parties["blue"]))
    errors.extend(validate_wild_data(species))
    errors.extend(validate_pokedex_text())
    errors.extend(validate_move_data(moves_list))
    errors.extend(validate_pokemon_data(species, moves))
    errors.extend(validate_sprite_sets())
    errors.extend(validate_toggleable_objects())
    errors.extend(validate_finale_gates())
    for summary in summaries:
        print(summary)
    if args.progression and red_progression:
        for line in progression_report(*red_progression):
            print(line)
        for line in boss_progression_report(red_progression[0]):
            print(line)
    print(f"errors: {len(errors)}")
    for error in errors:
        print(f"  {error}")
    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
