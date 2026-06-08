#!/usr/bin/env python3
"""Calculate trainer EXP and derive level targets for late-game progression."""

from __future__ import annotations

import re
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PARTIES_RED = ROOT / "data/trainers/parties_red.asm"
PARTIES_BLUE = ROOT / "data/trainers/parties_blue.asm"
BASE_STATS = ROOT / "data/pokemon/base_stats"


def exp_for_level(level: int) -> int:
    """Medium Slow: (6/5)*n^3 - 15*n^2 + 100*n - 140 (from growth_rates.asm)."""
    n = level
    return (6 * n**3) // 5 - 15 * n**2 + 100 * n - 140


def level_from_exp(exp: int) -> int:
    for lv in range(1, 100):
        if exp_for_level(lv + 1) > exp:
            return lv
    return 100


def trainer_mon_exp(base_exp: int, level: int) -> int:
    """Gen 1 trainer battle EXP for one mon (1.5x boost, /7)."""
    q = (base_exp * level) // 7
    return q + (q // 2)


@dataclass
class Encounter:
    section: str
    data_label: str
    party_index: int  # 1-based
    boss: bool = False
    name: str = ""


ENCOUNTERS: list[Encounter] = [
    Encounter("silph_co", "PetrelData", 2, boss=True, name="Petrel 1F"),
    Encounter("silph_co", "ScientistData", 2),
    Encounter("silph_co", "ScientistData", 3),
    Encounter("silph_co", "RocketData", 23),
    Encounter("silph_co", "RocketData", 24),
    Encounter("silph_co", "TamerData", 6),
    Encounter("silph_co", "JugglerData", 7),
    Encounter("silph_co", "ProtonData", 2, boss=True, name="Proton 2F"),
    Encounter("silph_co", "RocketData", 25),
    Encounter("silph_co", "ScientistData", 4),
    Encounter("silph_co", "TamerData", 7),
    Encounter("silph_co", "JugglerData", 8),
    Encounter("silph_co", "RocketData", 26),
    Encounter("silph_co", "ScientistData", 5),
    Encounter("silph_co", "RocketData", 27),
    Encounter("silph_co", "RocketData", 28),
    Encounter("silph_co", "ScientistData", 6),
    Encounter("silph_co", "JugglerData", 1),
    Encounter("silph_co", "RocketData", 29),
    Encounter("silph_co", "RocketData", 30),
    Encounter("silph_co", "ScientistData", 7),
    Encounter("silph_co", "RocketData", 31),
    Encounter("silph_co", "TamerData", 8),
    Encounter("silph_co", "ScientistData", 8),
    Encounter("silph_co", "RocketData", 32),
    Encounter("silph_co", "RocketData", 33),
    Encounter("silph_co", "RocketData", 34),
    Encounter("silph_co", "Rival2Data", 7, boss=True, name="Rival Silph"),
    Encounter("silph_co", "RocketData", 35),
    Encounter("silph_co", "ScientistData", 9),
    Encounter("silph_co", "RocketData", 36),
    Encounter("silph_co", "RocketData", 37),
    Encounter("silph_co", "ScientistData", 10),
    Encounter("silph_co", "RocketData", 38),
    Encounter("silph_co", "RocketData", 39),
    Encounter("silph_co", "ScientistData", 11),
    Encounter("silph_co", "GiovanniData", 2, boss=True, name="Giovanni Silph"),
    Encounter("silph_co", "ArianaData", 1, boss=True, name="Ariana"),
    Encounter("silph_co", "ArcherData", 1, boss=True, name="Archer"),
    Encounter("sabrina_gym", "ChannelerData", 22),
    Encounter("sabrina_gym", "PsychicData", 1),
    Encounter("sabrina_gym", "ChannelerData", 23),
    Encounter("sabrina_gym", "PsychicData", 2),
    Encounter("sabrina_gym", "ChannelerData", 24),
    Encounter("sabrina_gym", "PsychicData", 3),
    Encounter("sabrina_gym", "PsychicData", 4),
    Encounter("sabrina_gym", "SabrinaData", 1, boss=True, name="Sabrina"),
    Encounter("route_20_21", "SwimmerData", 9),
    Encounter("route_20_21", "SwimmerFData", 4),
    Encounter("route_20_21", "SwimmerFData", 5),
    Encounter("route_20_21", "SwimmerFData", 6),
    Encounter("route_20_21", "SwimmerData", 10),
    Encounter("route_20_21", "SwimmerData", 11),
    Encounter("route_20_21", "BirdKeeperData", 11),
    Encounter("route_20_21", "SwimmerFData", 7),
    Encounter("route_20_21", "SwimmerFData", 8),
    Encounter("route_20_21", "SwimmerFData", 9),
    Encounter("route_20_21", "FisherData", 7),
    Encounter("route_20_21", "FisherData", 9),
    Encounter("route_20_21", "SwimmerData", 12),
    Encounter("route_20_21", "SwimmerData", 16),
    Encounter("route_20_21", "SwimmerData", 13),
    Encounter("route_20_21", "SwimmerData", 14),
    Encounter("route_20_21", "SwimmerData", 15),
    Encounter("route_20_21", "FisherData", 8),
    Encounter("route_20_21", "FisherData", 10),
    Encounter("mansion", "ScientistData", 4),
    Encounter("mansion", "BurglarData", 7),
    Encounter("mansion", "BurglarData", 8),
    Encounter("mansion", "ScientistData", 12),
    Encounter("mansion", "BurglarData", 9),
    Encounter("mansion", "ScientistData", 13),
    Encounter("mansion", "GreenData", 7, boss=True, name="Green Mansion"),
    Encounter("blaine_gym", "SuperNerdData", 9),
    Encounter("blaine_gym", "BurglarData", 4),
    Encounter("blaine_gym", "SuperNerdData", 10),
    Encounter("blaine_gym", "BurglarData", 5),
    Encounter("blaine_gym", "SuperNerdData", 11),
    Encounter("blaine_gym", "BurglarData", 6),
    Encounter("blaine_gym", "SuperNerdData", 12),
    Encounter("blaine_gym", "BlaineData", 1, boss=True, name="Blaine"),
    Encounter("viridian_gym", "CooltrainerMData", 1),
    Encounter("viridian_gym", "BlackbeltData", 6),
    Encounter("viridian_gym", "TamerData", 3),
    Encounter("viridian_gym", "BlackbeltData", 7),
    Encounter("viridian_gym", "CooltrainerMData", 10),
    Encounter("viridian_gym", "BlackbeltData", 8),
    Encounter("viridian_gym", "TamerData", 4),
    Encounter("viridian_gym", "CooltrainerMData", 9),
    Encounter("viridian_gym", "GiovanniData", 3, boss=True, name="Giovanni Viridian"),
    Encounter("victory_road", "CooltrainerFData", 4),
    Encounter("victory_road", "CooltrainerMData", 5),
    Encounter("victory_road", "BlackbeltData", 8),
    Encounter("victory_road", "JugglerData", 2),
    Encounter("victory_road", "TamerData", 5),
    Encounter("victory_road", "PokemaniacData", 6),
    Encounter("victory_road", "JugglerData", 5),
    Encounter("victory_road", "CooltrainerMData", 2),
    Encounter("victory_road", "CooltrainerFData", 2),
    Encounter("victory_road", "CooltrainerMData", 3),
    Encounter("victory_road", "CooltrainerFData", 3),
    Encounter("elite_four", "LoreleiData", 1, boss=True, name="Lorelei"),
    Encounter("elite_four", "BrunoKarenData", 1, boss=True, name="Bruno/Karen"),
    Encounter("elite_four", "AgathaData", 1, boss=True, name="Agatha"),
    Encounter("elite_four", "LanceData", 1, boss=True, name="Lance"),
    Encounter("elite_four", "Rival3Data", 1, boss=True, name="Champion"),
    Encounter("gym_rematch", "BrockData", 2, boss=True, name="Brock rematch"),
    Encounter("gym_rematch", "MistyData", 2, boss=True, name="Misty rematch"),
    Encounter("gym_rematch", "LtSurgeData", 2, boss=True, name="Surge rematch"),
    Encounter("gym_rematch", "ErikaData", 2, boss=True, name="Erika rematch"),
    Encounter("gym_rematch", "KogaData", 2, boss=True, name="Koga rematch"),
    Encounter("gym_rematch", "SabrinaData", 2, boss=True, name="Sabrina rematch"),
    Encounter("gym_rematch", "BlaineData", 2, boss=True, name="Blaine rematch"),
    Encounter("gym_rematch", "GiovanniData", 4, boss=True, name="Giovanni rematch"),
    Encounter("e4_rematch", "LoreleiData", 2, boss=True, name="Lorelei rematch"),
    Encounter("e4_rematch", "BrunoKarenData", 2, boss=True, name="Bruno/Karen rematch"),
    Encounter("e4_rematch", "AgathaData", 2, boss=True, name="Agatha rematch"),
    Encounter("e4_rematch", "LanceData", 2, boss=True, name="Lance rematch"),
    Encounter("e4_rematch", "Rival3Data", 4, boss=True, name="Champion rematch"),
]

SECTION_ORDER = [
    "silph_co",
    "sabrina_gym",
    "route_20_21",
    "mansion",
    "blaine_gym",
    "viridian_gym",
    "victory_road",
    "elite_four",
    "gym_rematch",
    "e4_rematch",
]

# Starter-variant rows mirror the first row's levels.
STARTER_VARIANT_GROUPS = [
    ("Rival2Data", 7, 3),
    ("Rival3Data", 1, 3),
    ("Rival3Data", 4, 3),
    ("GreenData", 7, 3),
]

REGULAR_OFFSET = -3
BOSS_OFFSET = +2
PARTICIPANTS = 4  # avg party members sharing EXP per fight


def load_base_exp() -> dict[str, int]:
    out: dict[str, int] = {}
    for path in BASE_STATS.glob("*.asm"):
        m = re.search(r"db\s+(\d+)\s*;\s*base exp", path.read_text())
        if m:
            out[path.stem.lower()] = int(m.group(1))
    return out


def lookup_base_exp(species: str, base_exp: dict[str, int]) -> int:
    return base_exp.get(species.lower(), 150)


def parse_parties(text: str) -> dict[str, list[list[tuple[str, int]]]]:
    labels: dict[str, list] = {}
    current_label: str | None = None
    current_parties: list = []

    for line in text.splitlines():
        stripped = line.strip()
        if not stripped or stripped.startswith(";"):
            continue
        m = re.match(r"^(\w+Data):", stripped)
        if m:
            if current_label and current_parties:
                labels[current_label] = current_parties
            current_label = m.group(1)
            current_parties = []
            continue
        if not stripped.startswith("db ") or current_label is None:
            continue
        tokens = [t.strip().rstrip(",") for t in stripped[3:].split(",")]
        if tokens[-1] != "0":
            continue
        tokens = tokens[:-1]
        if not tokens:
            continue
        if tokens[0] == "$FF":
            party = []
            i = 1
            while i < len(tokens):
                party.append((tokens[i + 1], int(tokens[i], 0)))
                i += 2
            current_parties.append(party)
        else:
            level = int(tokens[0], 0)
            current_parties.append([(s, level) for s in tokens[1:]])

    if current_label and current_parties:
        labels[current_label] = current_parties
    return labels


def get_party(parties: dict, label: str, index: int) -> list[tuple[str, int]]:
    plist = parties[label]
    if index < 1 or index > len(plist):
        raise KeyError(f"{label}[{index}] out of range (have {len(plist)})")
    return list(plist[index - 1])


def assign_party_levels(party: list[tuple[str, int]], anchor: int, boss: bool) -> list[int]:
    n = len(party)
    if n == 1:
        return [anchor]
    if boss:
        return [anchor - 1] * (n - 1) + [anchor + 1]
    if n == 2:
        return [anchor - 1, anchor]
    return [anchor - 1, anchor, anchor, anchor + 1][:n]


def fight_exp(party: list[tuple[str, int]], levels: list[int], base_exp: dict[str, int]) -> int:
    total = 0
    for (species, _), lv in zip(party, levels):
        be = max(1, lookup_base_exp(species, base_exp) // PARTICIPANTS)
        total += trainer_mon_exp(be, lv)
    return total


@dataclass
class LevelAssignment:
    label: str
    party_index: int
    levels: list[int]
    species: list[str]
    boss: bool
    section: str


def propagate_starter_variants(
    assignments: dict[tuple[str, int], LevelAssignment],
    parties: dict,
) -> None:
    for label, start_idx, count in STARTER_VARIANT_GROUPS:
        key = (label, start_idx)
        if key not in assignments:
            continue
        base = assignments[key]
        for offset in range(1, count):
            idx = start_idx + offset
            party = get_party(parties, label, idx)
            species = [s for s, _ in party]
            if len(species) != len(base.levels):
                continue
            assignments[(label, idx)] = LevelAssignment(
                label, idx, list(base.levels), species, base.boss, base.section
            )


def main() -> None:
    base_exp = load_base_exp()
    parties_red = parse_parties(PARTIES_RED.read_text())
    assignments: dict[tuple[str, int], LevelAssignment] = {}

    player_exp = exp_for_level(38)
    player_level = 38

    print("=== EXP-based progression (Medium Slow, 4 mons sharing EXP) ===\n")
    print(f"Start: L{player_level} ({player_exp} exp)\n")

    for section in SECTION_ORDER:
        section_encounters = [e for e in ENCOUNTERS if e.section == section]
        section_start = player_level
        section_exp = 0

        for enc in section_encounters:
            party = get_party(parties_red, enc.data_label, enc.party_index)
            anchor = player_level + (BOSS_OFFSET if enc.boss else REGULAR_OFFSET)
            anchor = max(2, min(100, anchor))
            levels = assign_party_levels(party, anchor, enc.boss)
            exp = fight_exp(party, levels, base_exp)
            section_exp += exp
            player_exp += exp
            player_level = level_from_exp(player_exp)

            key = (enc.data_label, enc.party_index)
            # Shared party slots (e.g. Scientist 3F + Mansion 1F) keep the first level set.
            if key not in assignments:
                assignments[key] = LevelAssignment(
                    enc.data_label,
                    enc.party_index,
                    levels,
                    [s for s, _ in party],
                    enc.boss,
                    enc.section,
                )

        print(
            f"{section}: start L{section_start} -> end L{player_level} "
            f"(+{section_exp} exp, {len(section_encounters)} fights)"
        )

    propagate_starter_variants(assignments, parties_red)
    print(f"\nFinal level after all fights: L{player_level}\n")

    for path in (PARTIES_RED, PARTIES_BLUE):
        apply_assignments(path, assignments)
        print(f"Updated {path.name}")

    print("\nBoss / milestone levels:")
    for enc in ENCOUNTERS:
        if enc.boss and enc.name:
            a = assignments[(enc.data_label, enc.party_index)]
            print(f"  {enc.name}: ace L{a.levels[-1]}")


def apply_assignments(path: Path, assignments: dict[tuple[str, int], LevelAssignment]) -> None:
    text = path.read_text()
    lines = text.splitlines()
    out: list[str] = []
    current_label: str | None = None
    party_idx = 0

    for line in lines:
        stripped = line.strip()
        m = re.match(r"^(\w+Data):", stripped)
        if m:
            current_label = m.group(1)
            party_idx = 0
            out.append(line)
            continue

        if stripped.startswith("db ") and current_label:
            party_idx += 1
            key = (current_label, party_idx)
            if key in assignments:
                a = assignments[key]
                indent = line[: len(line) - len(line.lstrip())]
                if len(a.levels) == 1:
                    out.append(f"{indent}db {a.levels[0]}, {a.species[0]}, 0")
                elif all(l == a.levels[0] for l in a.levels):
                    out.append(f"{indent}db {a.levels[0]}, {', '.join(a.species)}, 0")
                else:
                    parts = [f"{lv}, {sp}" for sp, lv in zip(a.species, a.levels)]
                    out.append(f"{indent}db $FF, {', '.join(parts)}, 0")
                continue

        out.append(line)

    path.write_text("\n".join(out) + "\n")


if __name__ == "__main__":
    import sys

    log_path = ROOT / "tools/exp_progression_output.txt"
    with open(log_path, "w", encoding="utf-8") as log:
        sys.stdout = log
        try:
            main()
        except Exception:
            import traceback

            traceback.print_exc()
            raise
