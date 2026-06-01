#!/usr/bin/env python3
"""Sync parties_red.asm and custom_trainer_moves_table_red.asm into Blue counterparts.

Preserves Blue-only trainer data:
  - parties_blue.asm: ExileBrunoData, BrunoKarenData (Karen slot)
  - custom_trainer_moves_table_blue.asm: Karen E4, Exile Bruno, Karen rematch
"""
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
PARTIES_RED = ROOT / "data/trainers/parties_red.asm"
PARTIES_BLUE = ROOT / "data/trainers/parties_blue.asm"
MOVES_RED = ROOT / "data/trainers/custom_trainer_moves_table_red.asm"
MOVES_BLUE = ROOT / "data/trainers/custom_trainer_moves_table_blue.asm"


def extract_block(text: str, start_label: str, end_label: str) -> str:
    """Extract from start_label line (inclusive) up to but not including end_label line."""
    start = text.index(start_label)
    end = text.index(end_label, start)
    return text[start:end]


def sync_parties() -> None:
    red = PARTIES_RED.read_text()
    blue_old = PARTIES_BLUE.read_text()

    blue_only = extract_block(blue_old, "ExileBrunoData:", "BrockData:")
    out = extract_block(red, "YoungsterData:", "BrunoKarenData:")
    out += blue_only
    out += extract_block(red, "BrockData:", "SoldierData:")
    # SoldierData through end: same in both files when synced from red
    out += extract_block(red, "SoldierData:", "")

    PARTIES_BLUE.write_text(out)
    print(f"Wrote {PARTIES_BLUE.relative_to(ROOT)}")


def sync_moves() -> None:
    red = MOVES_RED.read_text()
    blue_old = MOVES_BLUE.read_text()

    karen_e4 = extract_block(blue_old, "; --- Karen ---", "; --- Exile Bruno")
    exile_bruno = extract_block(blue_old, "; --- Exile Bruno", "; --- Agatha ---")
    karen_rematch = extract_block(blue_old, "; --- Karen rematch", "; --- Agatha rematch")

    out = red.replace(
        "for Red version trainer parties.",
        "for Blue version trainer parties.",
    )

    bruno_e4 = extract_block(out, "; --- Bruno ---", "; --- Agatha ---")
    out = out.replace(bruno_e4, karen_e4 + exile_bruno)

    bruno_rematch = extract_block(out, "; --- Bruno rematch", "; --- Agatha rematch")
    out = out.replace(bruno_rematch, karen_rematch)

    MOVES_BLUE.write_text(out)
    print(f"Wrote {MOVES_BLUE.relative_to(ROOT)}")


def main() -> int:
    for path in (PARTIES_RED, MOVES_RED):
        if not path.is_file():
            print(f"Missing {path}", file=sys.stderr)
            return 1
    sync_parties()
    sync_moves()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
