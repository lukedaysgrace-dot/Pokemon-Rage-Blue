#!/usr/bin/env python3
"""Content checks for dialogue, overworld sprites, battle graphics and scripts.

Complements audit_game_data.py with problems that assemble cleanly but show up
in game:

- dialogue lines wider than the 18-tile text box
- `--colors auto` graphics whose colour order inverts the Game Boy shades
- NPCs set to WALK whose sprite sheet has no walking frames
- indoor maps that load more overworld sprite sheets than VRAM can hold
- scripted trainer battles that never load the trainer header's flag bit
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TEXT_BOX_WIDTH = 18
MAX_WALKING_SHEETS = 9  # VRAM slots 2-10; slot 1 is the player
MAX_STILL_SHEETS = 2  # 4-tile sheets share two fixed VRAM slots

# Width in tiles of control characters that expand while printing. Names are
# counted at their maximum length.
TOKEN_WIDTHS = {
    "<PLAYER>": 7,
    "<RIVAL>": 7,
    "<PKMN>": 2,
    "<PC>": 2,
    "<TM>": 2,
    "<TRAINER>": 7,
    "<ROCKET>": 6,
    "<……>": 2,
    "<USER>": 10,
    "<TARGET>": 10,
}
STRING = re.compile(r'"((?:[^"\\]|\\.)*)"')


def strip_comment(line: str) -> str:
    out: list[str] = []
    quoted = False
    for char in line:
        if char == '"':
            quoted = not quoted
        if char == ";" and not quoted:
            break
        out.append(char)
    return "".join(out).rstrip()


def text_width(text: str) -> int:
    width = 0
    i = 0
    while i < len(text):
        char = text[i]
        if char == "<":
            end = text.find(">", i)
            if end != -1:
                width += TOKEN_WIDTHS.get(text[i : end + 1], 1)
                i = end + 1
                continue
        if char == "@":
            break
        if char == "#":
            width += 4  # "POKé"
        elif char == "'" and i + 1 < len(text) and text[i + 1] in "dlstvrm":
            width += 1  # 'd, 'l, 's ... are single tiles
            i += 1
        else:
            width += 1
        i += 1
    return width


def check_text_widths() -> list[str]:
    errors: list[str] = []
    paths: set[Path] = set()
    for folder in ("text", "data", "scripts", "engine", "home", "maps"):
        paths.update((ROOT / folder).rglob("*.asm"))
    for path in sorted(paths):
        rel = path.relative_to(ROOT)
        if "dex_text" in path.name or "pokedex_entries" in path.name:
            continue  # Pokédex pages have their own layout check
        width = 0
        active = False
        lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
        for number, raw in enumerate(lines, 1):
            line = strip_comment(raw)
            if not line.strip():
                continue
            if not line[0].isspace():
                active = False  # new label
                continue
            match = re.match(r"\s+([a-z_]+)\b\s*(.*)$", line)
            if not match:
                continue
            command, args = match.groups()
            strings = STRING.findall(args)
            literal = strings[0] if strings else ""
            if command == "text":
                width = width + text_width(literal) if active else text_width(literal)
                active = "@" not in literal
            elif command in ("line", "cont", "para", "next", "page"):
                width = text_width(literal)
                active = "@" not in literal
            elif command == "text_decimal" and active:
                parts = [part.strip() for part in args.split(",")]
                if len(parts) >= 3 and parts[2].isdigit():
                    width += int(parts[2])
                continue
            elif command in ("done", "prompt", "text_end", "text_far", "text_asm"):
                active = False
                continue
            else:
                continue
            if width > TEXT_BOX_WIDTH:
                errors.append(
                    f"{rel}:{number}: text line is {width} tiles wide "
                    f"(max {TEXT_BOX_WIDTH}): {raw.strip()}"
                )
    return errors


def auto_colour_pngs() -> list[Path]:
    """PNGs converted with `rgbgfx --colors auto` (see Makefile)."""
    paths = list((ROOT / "gfx/pokemon").rglob("*.png"))
    paths += (ROOT / "gfx/icons").glob("*.png")
    paths += (ROOT / "gfx/sprites").glob("*_new.png")
    paths.append(ROOT / "gfx/sprites/blue.png")
    for name in ("petrel", "proton", "archer", "ariana", "soldier"):
        paths.append(ROOT / f"gfx/trainers/{name}.png")
    return sorted(path for path in paths if path.is_file())


def check_shade_order() -> list[str]:
    """Indexed PNGs keep their palette order under `--colors auto`.

    If that order is not light-to-dark, the generated tiles swap shades in
    game (a fully reversed palette inverts the whole picture).
    """
    try:
        from PIL import Image
    except ImportError:
        return ["Pillow is required for the graphics shade check (pip install Pillow)"]
    errors: list[str] = []
    for path in auto_colour_pngs():
        image = Image.open(path)
        if image.mode != "P" or "transparency" in image.info:
            continue
        palette = image.getpalette() or []
        used: list[int] = []
        for _, index in sorted(image.getcolors(256) or [], key=lambda item: item[1]):
            colour = tuple(palette[index * 3 : index * 3 + 3])
            if colour not in [tuple(palette[i * 3 : i * 3 + 3]) for i in used]:
                used.append(index)
        lums = [
            2126 * palette[i * 3] + 7152 * palette[i * 3 + 1] + 722 * palette[i * 3 + 2]
            for i in used
        ]
        if any(a < b for a, b in zip(lums, lums[1:])):
            errors.append(
                f"{path.relative_to(ROOT)}: palette is not ordered light to dark, "
                "so its shades are swapped in game"
            )
    return errors


def sprite_tables(version: str) -> tuple[dict[str, int], dict[str, Path]]:
    """Tile counts and source PNGs for each SPRITE_* constant."""
    tiles: dict[str, int] = {}
    labels: dict[str, str] = {}
    keep: list[bool] = []
    for raw in (ROOT / "data/sprites/sprites.asm").read_text(encoding="utf-8").splitlines():
        line = strip_comment(raw).strip()
        if line.startswith("IF DEF("):
            keep.append(line == f"IF DEF(_{version.upper()})")
            continue
        if line.startswith("ENDC"):
            keep.pop()
            continue
        if keep and not all(keep):
            continue
        match = re.match(r"overworld_sprite\s+(\w+),\s*(\d+)", line)
        sprite = re.search(r";\s*(SPRITE_\w+)", raw)
        if match and sprite:
            labels[sprite.group(1)] = match.group(1)
            tiles[sprite.group(1)] = int(match.group(2))
    sources: dict[str, Path] = {}
    for asm in (ROOT / "gfx").rglob("*.asm"):
        for raw in asm.read_text(encoding="utf-8").splitlines():
            match = re.match(r'(\w+)::?\s+INCBIN\s+"([^"]+)\.2bpp"', raw.strip())
            if match:
                sources[match.group(1)] = ROOT / f"{match.group(2)}.png"
    pngs = {sprite: sources[label] for sprite, label in labels.items() if label in sources}
    return tiles, pngs


def map_objects(path: Path, version: str) -> list[tuple[int, list[str]]]:
    rows: list[tuple[int, list[str]]] = []
    keep: list[bool] = []
    for number, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        line = strip_comment(raw).strip()
        if line.startswith("IF DEF("):
            keep.append(line == f"IF DEF(_{version.upper()})")
            continue
        if line.startswith("ELSE"):
            keep[-1] = not keep[-1]
            continue
        if line.startswith("ENDC"):
            keep.pop()
            continue
        if keep and not all(keep):
            continue
        match = re.match(r"object_event\s+(.*)", line)
        if match:
            rows.append((number, [part.strip() for part in match.group(1).split(",")]))
    return rows


def outdoor_maps() -> set[str]:
    """Object-file stems of maps that use fixed outdoor sprite sets."""
    map_ids: list[str] = []
    first_indoor = 0
    for raw in (ROOT / "constants/map_constants.asm").read_text(encoding="utf-8").splitlines():
        match = re.match(r"\s*map_const\s+(\w+)", raw)
        if match:
            map_ids.append(match.group(1))
        if "FIRST_INDOOR_MAP" in raw:
            first_indoor = len(map_ids)
    outdoor_ids = set(map_ids[:first_indoor])
    stems: set[str] = set()
    for header in (ROOT / "data/maps/headers").glob("*.asm"):
        match = re.search(r"map_header\s+\w+,\s*(\w+)", header.read_text(encoding="utf-8"))
        if match and match.group(1) in outdoor_ids:
            stems.add(header.stem)
    return stems


def check_overworld_sprites() -> list[str]:
    try:
        from PIL import Image
    except ImportError:
        return []
    errors: list[str] = []
    outdoor = outdoor_maps()
    for version in ("red", "blue"):
        tiles, pngs = sprite_tables(version)
        no_walk_frames = {
            sprite
            for sprite, count in tiles.items()
            if count == 12 and sprite in pngs and Image.open(pngs[sprite]).size[1] < 96
        }
        for path in sorted((ROOT / "data/maps/objects").glob("*.asm")):
            rel = path.relative_to(ROOT)
            objects = map_objects(path, version)
            for number, args in objects:
                if len(args) > 3 and args[2] in no_walk_frames and args[3] == "WALK":
                    errors.append(
                        f"{rel}:{number}: {args[2]} has no walking frames, "
                        "so a WALK object shows garbage tiles (use STAY)"
                    )
            if path.stem in outdoor:
                continue  # outdoor sets are checked by audit_game_data.py
            walking = {args[2] for _, args in objects if tiles.get(args[2]) == 12}
            still = {args[2] for _, args in objects if tiles.get(args[2]) == 4}
            if len(walking) > MAX_WALKING_SHEETS:
                errors.append(
                    f"{version}: {rel}: {len(walking)} different walking sprites "
                    f"(VRAM holds {MAX_WALKING_SHEETS})"
                )
            if len(still) > MAX_STILL_SHEETS:
                errors.append(
                    f"{version}: {rel}: {len(still)} different 4-tile sprites "
                    f"(VRAM holds {MAX_STILL_SHEETS}): {', '.join(sorted(still))}"
                )
    return sorted(set(errors))


def check_scripted_trainer_headers() -> list[str]:
    """EndTrainerBattle sets the bit in wTrainerHeaderFlagBit; scripts that
    store a header pointer by hand must also load that bit."""
    errors: list[str] = []
    for path in sorted((ROOT / "scripts").glob("*.asm")):
        lines = [strip_comment(raw).strip() for raw in path.read_text(encoding="utf-8").splitlines()]
        for index, line in enumerate(lines):
            if line != "call StoreTrainerHeaderPointer":
                continue
            following = [line for line in lines[index + 1 : index + 8] if line][:3]
            if "xor a" not in following or "call ReadTrainerHeaderInfo" not in following:
                errors.append(
                    f"{path.relative_to(ROOT)}:{index + 1}: StoreTrainerHeaderPointer is not "
                    "followed by 'xor a / call ReadTrainerHeaderInfo'; EndTrainerBattle "
                    "would set a stale event flag bit"
                )
    return errors


def main() -> int:
    errors: list[str] = []
    errors += check_text_widths()
    errors += check_shade_order()
    errors += check_overworld_sprites()
    errors += check_scripted_trainer_headers()
    print(f"content errors: {len(errors)}")
    for error in errors:
        print(f"  {error}")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
