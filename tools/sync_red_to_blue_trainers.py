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


def extract_block(text: str, start_label: str, end_label: str | None = None) -> str:
    """Extract from start_label line (inclusive) up to but not including end_label line.

    Pass end_label=None (or omit it) to extract from start_label through the end of
    the text. Note that an empty end_label must NOT be used for this: str.index("")
    returns the search offset itself, so `text[start:start]` silently yields "" and
    the whole tail of the file would be dropped without any error.
    """
    start = text.index(start_label)
    if end_label is None:
        return text[start:]
    if not end_label:
        raise ValueError(
            "extract_block: end_label must be a non-empty label or None "
            "(an empty string would silently drop everything after start_label)"
        )
    end = text.index(end_label, start)
    return text[start:end]


LABEL_RE = re.compile(r"(?m)^(\w+Data):")


def check_no_labels_lost(red: str, out: str, blue_old: str, dest: Path) -> None:
    """Fail loudly if any trainer-class label from either source is missing from `out`.

    The union of Red's labels and the existing Blue-only labels must all survive the
    splice; otherwise a mis-specified block boundary would drop trainer parties and
    the resulting file would still assemble (just with missing rosters).
    """
    expected = set(LABEL_RE.findall(red)) | set(LABEL_RE.findall(blue_old))
    got = set(LABEL_RE.findall(out))
    missing = sorted(expected - got)
    if missing:
        raise SystemExit(
            f"{dest.relative_to(ROOT)}: refusing to write, {len(missing)} trainer "
            f"label(s) would be dropped: {', '.join(missing)}"
        )


def sync_parties() -> None:
    red = PARTIES_RED.read_text()
    blue_old = PARTIES_BLUE.read_text()

    blue_only = extract_block(blue_old, "ExileBrunoData:", "BrockData:")
    out = extract_block(red, "YoungsterData:", "BrunoKarenData:")
    out += blue_only
    out += extract_block(red, "BrockData:", "SoldierData:")
    # SoldierData through end of file: same in both files when synced from red.
    # end_label=None means "to EOF" -- passing "" here silently truncated the file.
    out += extract_block(red, "SoldierData:")

    check_no_labels_lost(red, out, blue_old, PARTIES_BLUE)
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
    ).replace(
        "for _RED builds.",
        "for _BLUE builds.",
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
