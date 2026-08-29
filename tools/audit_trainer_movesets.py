#!/usr/bin/env python3
"""Check custom trainer move rows against the parties they actually apply to.

Rows in data/trainers/custom_trainer_moves_table_{red,blue}.asm are keyed by
(class, wTrainerNo, party slot) — NOT by species. So editing a party silently
re-points a row at a different Pokemon, and the only thing that records the
row's intent is its `; <Species> L<level>` comment. This checks that comment
against data/trainers/parties_{red,blue}.asm and fails on any drift.

audit_game_data.py validates that the class/party/slot are in range and that
the move names exist; it cannot catch a row that is valid but now lands on the
wrong Pokemon. That is what this covers.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

# Trainer class constant -> party label in parties_{red,blue}.asm, where the
# CamelCase of the constant is not the label.
LABEL_OVERRIDES = {
    "LT_SURGE": "LtSurge",
    "ROCKET_F": "RocketF",
    "GREEN_ROCKET": "GreenRocket",
    "BLUE_CLOAK": "BlueCloak",
    "EXILE_BRUNO": "ExileBruno",
    "UNUSED_JUGGLER": "UnusedJuggler",
    "KAREN": "BrunoKaren",
    "BRUNO": "BrunoKaren",
}


def parse_parties(path: Path, version: str) -> dict[str, list[list[tuple[str, int]]]]:
    out: dict[str, list[list[tuple[str, int]]]] = {}
    cur: str | None = None
    stack: list[bool] = []
    for line in path.read_text(encoding="utf-8").splitlines():
        s = line.split(";")[0].strip()
        m = re.match(r"IF DEF\(_(RED|BLUE)\)", s)
        if m:
            stack.append(m.group(1) == version)
            continue
        if s.startswith("ELSE") and stack:
            stack[-1] = not stack[-1]
            continue
        if s.startswith("ENDC") and stack:
            stack.pop()
            continue
        if stack and not all(stack):
            continue
        m = re.match(r"(\w+)Data:", s)
        if m:
            cur = m.group(1)
            out.setdefault(cur, [])
            continue
        if s.startswith("db ") and cur:
            toks = [t.strip() for t in s[3:].split(",")]
            if not toks:
                continue
            if toks[0] == "$FF":
                mons = [(toks[i + 1], int(toks[i])) for i in range(1, len(toks) - 1, 2)]
            else:
                lvl = int(toks[0])
                mons = [(t, lvl) for t in toks[1:-1]]
            out[cur].append(mons)
    return out


def label_for(cls: str, parties: dict) -> str | None:
    if cls in LABEL_OVERRIDES and LABEL_OVERRIDES[cls] in parties:
        return LABEL_OVERRIDES[cls]
    cand = "".join(w.capitalize() for w in cls.split("_"))
    for k in parties:
        if k.lower() == cand.lower():
            return k
    return None


def norm(s: str) -> str:
    return re.sub(r"[^a-z0-9]", "", s.lower())


def check(version: str, parties_file: str, table_file: str) -> list[str]:
    parties = parse_parties(ROOT / parties_file, version)
    errors: list[str] = []
    pending: str | None = None
    for lineno, line in enumerate((ROOT / table_file).read_text(encoding="utf-8").splitlines(), 1):
        st = line.strip()
        if st.startswith(";"):
            c = st.lstrip("; ").strip()
            if c and not c.startswith("=") and not c.startswith("---"):
                pending = c
            continue
        if not st.startswith("db ") or st.startswith("db $ff"):
            continue
        toks = [t.strip() for t in st[3:].split(",")]
        if len(toks) != 7:
            pending = None
            continue
        cls, tno, slot = toks[0], int(toks[1]), int(toks[2])
        label = label_for(cls, parties)
        where = f"{table_file}:{lineno} {cls} party {tno} slot {slot}"
        if label is None:
            errors.append(f"{where}: no party table for class {cls}")
        elif tno < 1 or tno > len(parties[label]):
            errors.append(f"{where}: party {tno} does not exist ({len(parties[label])} defined)")
        elif slot < 1 or slot > len(parties[label][tno - 1]):
            errors.append(
                f"{where}: slot {slot} does not exist ({len(parties[label][tno - 1])} mons)"
            )
        elif pending is None:
            errors.append(f"{where}: row has no '; <Species> L<level>' comment")
        else:
            species, level = parties[label][tno - 1][slot - 1]
            m = re.match(r"(.+?)\s+L(\d+)\s*$", pending)
            cname = (m.group(1) if m else pending).strip()
            clevel = int(m.group(2)) if m else None
            if norm(cname) != norm(species):
                errors.append(
                    f"{where}: row is labelled {cname} but that slot now holds {species}"
                    " — the moveset probably needs regenerating"
                )
            elif clevel != level:
                errors.append(f"{where}: {species} comment says L{clevel}, party says L{level}")
        pending = None
    return errors


def main() -> int:
    total = 0
    for version, pfile, mfile in (
        ("RED", "data/trainers/parties_red.asm", "data/trainers/custom_trainer_moves_table_red.asm"),
        ("BLUE", "data/trainers/parties_blue.asm", "data/trainers/custom_trainer_moves_table_blue.asm"),
    ):
        errors = check(version, pfile, mfile)
        for e in errors:
            print(f"error: {e}")
        print(f"{version.lower()}: checked {mfile}, {len(errors)} problems")
        total += len(errors)
    print(f"errors: {total}")
    return 1 if total else 0


if __name__ == "__main__":
    sys.exit(main())
