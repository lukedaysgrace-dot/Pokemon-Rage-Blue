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


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--progression", action="store_true", help="print the story-area level curve")
    args = parser.parse_args()
    species = set(constants(ROOT / "constants/pokemon_constants.asm"))
    species -= {"NO_MON"}
    moves = set(constants(ROOT / "constants/move_constants.asm"))
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
