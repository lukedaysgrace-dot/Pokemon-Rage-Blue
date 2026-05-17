#!/usr/bin/env python3
"""Generate custom_trainer_moves.asm from base_stats + evos_moves (Gen 1 WriteMonMoves logic)."""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BASE_STATS = ROOT / "data/pokemon/base_stats"
EVOS = ROOT / "data/pokemon/evos_moves.asm"

SPECIAL_NAMES = {
    "mr_mime": "MrMime",
    "mrmime": "MrMime",
    "nidoran_m": "NidoranM",
    "nidoran_f": "NidoranF",
    "farfetchd": "Farfetchd",
}


def file_to_label(stem: str) -> str:
    if stem in SPECIAL_NAMES:
        return SPECIAL_NAMES[stem]
    return stem.replace("_", " ").title().replace(" ", "")


def load_base_moves() -> dict[str, list[str]]:
    out: dict[str, list[str]] = {}
    for p in BASE_STATS.glob("*.asm"):
        text = p.read_text(encoding="utf-8")
        m = re.search(
            r"db\s+(\w+)\s*,\s*(\w+)\s*,\s*(\w+)\s*,\s*(\w+)\s*;\s*level 1 learnset",
            text,
        )
        if not m:
            m = re.search(
                r"dw\s+\w+PicFront\s*,\s*\w+PicBack\s*\n\s*\n?\s*"
                r"db\s+(\w+)\s*,\s*(\w+)\s*,\s*(\w+)\s*,\s*(\w+)",
                text,
            )
        if not m:
            continue
        label = file_to_label(p.stem)
        out[label] = [m.group(i) for i in range(1, 5)]
    return out


def load_learnsets() -> dict[str, list[tuple[int, str]]]:
    text = EVOS.read_text(encoding="utf-8")
    out: dict[str, list[tuple[int, str]]] = {}
    for m in re.finditer(r"^([A-Za-z0-9_]+)EvosMoves:\s*\n", text, re.M):
        name = m.group(1)
        start = m.end()
        chunk = text[start : start + 8000]
        lm = re.search(r";\s*Learnset\s*\n((?:\s*db\s+[^\n]+\n)+)", chunk)
        if not lm:
            continue
        pairs: list[tuple[int, str]] = []
        for line in lm.group(1).splitlines():
            line = line.split(";")[0].strip()
            if not line.startswith("db"):
                continue
            rest = line[2:].strip()
            if rest == "0":
                break
            parts = [x.strip() for x in rest.split(",")]
            if len(parts) >= 2 and parts[0].isdigit():
                pairs.append((int(parts[0]), parts[1]))
        out[name] = pairs
    return out


def moves_at_level(label: str, level: int, base_moves: dict, learnsets: dict) -> list[str]:
    base = base_moves.get(label)
    if not base:
        raise KeyError(f"No base_stats for label {label}")
    learn = learnsets.get(label, [])

    def empty(x: str) -> bool:
        return x in ("NO_MOVE", "0", "")

    slots: list[str | None] = []
    for m in base[:4]:
        slots.append(None if empty(m) else m)
    while len(slots) < 4:
        slots.append(None)

    for lv, mv in learn:
        if lv > level:
            break
        if mv in slots:
            continue
        try:
            i = slots.index(None)
            slots[i] = mv
        except ValueError:
            slots = slots[1:] + [mv]

    return [(s if s else "NO_MOVE") for s in slots]


def species_to_label(species: str) -> str:
    s = species.lower()
    if s == "mr_mime":
        s = "mrmime"
    return file_to_label(s)


def add_entries(out: list, cls: str, tno: int, mons: list[tuple[str, int]], note: str):
    for i, (sp, lv) in enumerate(mons, start=1):
        out.append((f"{note} | {cls} #{tno} slot{i} {sp} L{lv}", cls, tno, i, sp, lv))


def main() -> int:
    base_moves = load_base_moves()
    learnsets = load_learnsets()
    rows: list[tuple[str, str, int, int, str, int]] = []

    # Gym leaders — must match data/trainers/parties.asm (BrockData, MistyData, …)
    add_entries(rows, "BROCK", 1, [("GEODUDE", 12), ("KABUTO", 13), ("ONIX", 15)], "Brock")
    add_entries(rows, "MISTY", 1, [("STARYU", 18), ("HORSEA", 19), ("STARMIE", 22)], "Misty")
    add_entries(
        rows, "LT_SURGE", 1, [("VOLTORB", 18), ("ELECTABUZZ", 21), ("RAICHU", 25)], "Lt.Surge"
    )
    add_entries(
        rows,
        "ERIKA",
        1,
        [("TANGELA", 29), ("PARASECT", 31), ("VICTREEBEL", 33), ("VILEPLUME", 33)],
        "Erika",
    )
    add_entries(
        rows,
        "KOGA",
        1,
        [("ARBOK", 37), ("MUK", 39), ("VENOMOTH", 38), ("WEEZING", 43), ("TENTACRUEL", 41)],
        "Koga",
    )
    add_entries(
        rows,
        "BLAINE",
        1,
        [
            ("NINETALES", 40),
            ("MAGMORTAR", 43),
            ("RAPIDASH", 43),
            ("ARCANINE", 47),
            ("FLAREON", 45),
        ],
        "Blaine",
    )
    add_entries(
        rows,
        "SABRINA",
        1,
        [("MR_MIME", 37), ("HYPNO", 38), ("GOLDUCK", 38), ("JYNX", 38), ("ALAKAZAM", 43)],
        "Sabrina",
    )

    add_entries(
        rows,
        "GIOVANNI",
        1,
        [("CUBONE", 25), ("RHYHORN", 24), ("KABUTO", 28), ("KANGASKHAN", 29)],
        "Giovanni Rocket Hideout",
    )
    add_entries(
        rows,
        "GIOVANNI",
        2,
        [("NIDOKING", 37), ("KANGASKHAN", 37), ("RHYHORN", 37), ("KABUTOPS", 40), ("NIDOQUEEN", 41)],
        "Giovanni Silph Co.",
    )
    add_entries(
        rows,
        "GIOVANNI",
        3,
        [
            ("KANGASKHAN", 41),
            ("MAROWAK", 42),
            ("NIDOQUEEN", 45),
            ("NIDOKING", 43),
            ("RHYDON", 42),
            ("KABUTOPS", 42),
        ],
        "Giovanni Viridian Gym",
    )

    # Elite Four — LoreleiData order/levels
    add_entries(
        rows,
        "LORELEI",
        1,
        [
            ("DEWGONG", 45),
            ("CLOYSTER", 46),
            ("SLOWBRO", 46),
            ("MESMERIA", 47),
            ("LAPRAS", 47),
            ("VAPOREON", 46),
        ],
        "Lorelei",
    )
    add_entries(
        rows,
        "KAREN",
        1,
        [
            ("UMBREON", 46),
            ("MURKROW", 47),
            ("SNEASEL", 47),
            ("TYRANITAR", 47),
            ("HONCHKROW", 50),
            ("WEAVILE", 48),
        ],
        "Karen",
    )
    add_entries(
        rows,
        "AGATHA",
        1,
        [
            ("GENGAR", 48),
            ("TENTACRUEL", 47),
            ("GOLBAT", 46),
            ("ARBOK", 48),
            ("GENGAR", 52),
            ("WEEZING", 47),
        ],
        "Agatha",
    )
    add_entries(
        rows,
        "LANCE",
        1,
        [
            ("GYARADOS", 52),
            ("DRAGONITE", 54),
            ("DRAGONITE", 54),
            ("AERODACTYL", 52),
            ("DRAGONITE", 55),
            ("KINGDRA", 54),
        ],
        "Lance",
    )

    # RIVAL1 — parties.asm order
    add_entries(rows, "RIVAL1", 1, [("SQUIRTLE", 5)], "Oak lab (rival: Squirtle)")
    add_entries(rows, "RIVAL1", 2, [("BULBASAUR", 5)], "Oak lab (rival: Bulbasaur)")
    add_entries(rows, "RIVAL1", 3, [("CHARMANDER", 5)], "Oak lab (rival: Charmander)")
    add_entries(rows, "RIVAL1", 4, [("PIDGEY", 9), ("SQUIRTLE", 8)], "Route 22 1st")
    add_entries(rows, "RIVAL1", 5, [("PIDGEY", 9), ("BULBASAUR", 8)], "Route 22 1st")
    add_entries(rows, "RIVAL1", 6, [("PIDGEY", 9), ("CHARMANDER", 8)], "Route 22 1st")
    add_entries(
        rows,
        "RIVAL1",
        7,
        [("PIDGEOTTO", 18), ("ABRA", 15), ("RATTATA", 15), ("SQUIRTLE", 17)],
        "Cerulean",
    )
    add_entries(
        rows,
        "RIVAL1",
        8,
        [("PIDGEOTTO", 18), ("ABRA", 15), ("RATTATA", 15), ("BULBASAUR", 17)],
        "Cerulean",
    )
    add_entries(
        rows,
        "RIVAL1",
        9,
        [("PIDGEOTTO", 18), ("ABRA", 15), ("RATTATA", 15), ("CHARMANDER", 17)],
        "Cerulean",
    )

    # RIVAL2
    add_entries(
        rows,
        "RIVAL2",
        1,
        [("PIDGEOTTO", 19), ("RATICATE", 16), ("KADABRA", 18), ("WARTORTLE", 20)],
        "S.S. Anne",
    )
    add_entries(
        rows,
        "RIVAL2",
        2,
        [("PIDGEOTTO", 19), ("RATICATE", 16), ("KADABRA", 18), ("IVYSAUR", 20)],
        "S.S. Anne",
    )
    add_entries(
        rows,
        "RIVAL2",
        3,
        [("PIDGEOTTO", 19), ("RATICATE", 16), ("KADABRA", 18), ("CHARMELEON", 20)],
        "S.S. Anne",
    )
    add_entries(
        rows,
        "RIVAL2",
        4,
        [("PIDGEOTTO", 25), ("GROWLITHE", 23), ("EXEGGCUTE", 22), ("KADABRA", 20), ("WARTORTLE", 25)],
        "Pokemon Tower",
    )
    add_entries(
        rows,
        "RIVAL2",
        5,
        [("PIDGEOTTO", 25), ("GYARADOS", 23), ("GROWLITHE", 22), ("KADABRA", 20), ("IVYSAUR", 25)],
        "Pokemon Tower",
    )
    add_entries(
        rows,
        "RIVAL2",
        6,
        [("PIDGEOTTO", 25), ("EXEGGCUTE", 23), ("GYARADOS", 22), ("KADABRA", 20), ("CHARMELEON", 25)],
        "Pokemon Tower",
    )
    add_entries(
        rows,
        "RIVAL2",
        7,
        [
            ("PIDGEOT", 37),
            ("GROWLITHE", 38),
            ("EXEGGCUTE", 35),
            ("ALAKAZAM", 35),
            ("BLASTOISE", 40),
        ],
        "Silph Co.",
    )
    add_entries(
        rows,
        "RIVAL2",
        8,
        [
            ("PIDGEOT", 37),
            ("GYARADOS", 38),
            ("GROWLITHE", 35),
            ("ALAKAZAM", 35),
            ("VENUSAUR", 40),
        ],
        "Silph Co.",
    )
    add_entries(
        rows,
        "RIVAL2",
        9,
        [
            ("PIDGEOT", 37),
            ("EXEGGCUTE", 38),
            ("GYARADOS", 35),
            ("ALAKAZAM", 35),
            ("CHARIZARD", 40),
        ],
        "Silph Co.",
    )
    add_entries(
        rows,
        "RIVAL2",
        10,
        [
            ("PIDGEOT", 47),
            ("RHYHORN", 45),
            ("GROWLITHE", 45),
            ("EXEGGCUTE", 47),
            ("ALAKAZAM", 50),
            ("BLASTOISE", 53),
        ],
        "Route 22 2nd",
    )
    add_entries(
        rows,
        "RIVAL2",
        11,
        [
            ("PIDGEOT", 47),
            ("RHYHORN", 45),
            ("GYARADOS", 45),
            ("GROWLITHE", 47),
            ("ALAKAZAM", 50),
            ("VENUSAUR", 53),
        ],
        "Route 22 2nd",
    )
    add_entries(
        rows,
        "RIVAL2",
        12,
        [
            ("PIDGEOT", 47),
            ("RHYHORN", 45),
            ("EXEGGCUTE", 45),
            ("GYARADOS", 47),
            ("ALAKAZAM", 50),
            ("CHARIZARD", 53),
        ],
        "Route 22 2nd",
    )

    # RIVAL3 (Champion)
    add_entries(
        rows,
        "RIVAL3",
        1,
        [
            ("PIDGEOT", 61),
            ("ALAKAZAM", 59),
            ("RHYDON", 61),
            ("ARCANINE", 61),
            ("EXEGGUTOR", 63),
            ("BLASTOISE", 65),
        ],
        "Champion",
    )
    add_entries(
        rows,
        "RIVAL3",
        2,
        [
            ("PIDGEOT", 61),
            ("ALAKAZAM", 59),
            ("RHYDON", 61),
            ("GYARADOS", 61),
            ("ARCANINE", 63),
            ("VENUSAUR", 65),
        ],
        "Champion",
    )
    add_entries(
        rows,
        "RIVAL3",
        3,
        [
            ("PIDGEOT", 61),
            ("ALAKAZAM", 59),
            ("RHYDON", 61),
            ("EXEGGUTOR", 61),
            ("GYARADOS", 63),
            ("CHARIZARD", 65),
        ],
        "Champion",
    )

    lines = [
        "; Level-up moves (Gen 1 WriteMonMoves-style). Paste into data/trainers/custom_trainer_moves_table.asm",
        "; (replace CustomTrainerMoves: … db \\$ff block).",
        "",
        "CustomTrainerMoves:",
    ]

    for comment, cls, tno, slot, species, level in rows:
        label = species_to_label(species)
        try:
            m1, m2, m3, m4 = moves_at_level(label, level, base_moves, learnsets)
        except KeyError as e:
            print(e, file=sys.stderr)
            return 1
        safe = comment.replace("@", "'@'")
        lines.append(f'\t; {safe}')
        lines.append(f"\tdb {cls}, {tno}, {slot}, {m1}, {m2}, {m3}, {m4}")

    lines.extend(
        [
            "",
            "CustomTrainerMovesEnd:",
            "ASSERT (CustomTrainerMovesEnd - CustomTrainerMoves) % 7 == 0, \\",
            '\t"CustomTrainerMoves records must be 7 bytes: class, trainer no, slot, and 4 moves"',
            "\tdb $ff",
        ]
    )
    lines.append("")
    print("\n".join(lines))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
