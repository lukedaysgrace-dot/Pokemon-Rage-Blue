#!/usr/bin/env python3
"""Check map block lengths, event bounds and destination warps in both versions."""

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]


def active_lines(path, version):
    conditions = []
    for number, raw in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        line = raw.split(";", 1)[0].strip()
        match = re.fullmatch(r"IF DEF\((_RED|_BLUE)\)", line)
        if match:
            conditions.append(match[1] == "_" + version.upper())
        elif line == "ELSE":
            conditions[-1] = not conditions[-1]
        elif line == "ENDC":
            conditions.pop()
        elif line.startswith(("IF ", "ELIF ")):
            raise ValueError(f"{path}:{number}: unsupported conditional {line}")
        elif line and all(conditions):
            yield number, line
    if conditions:
        raise ValueError(f"{path}: unterminated conditional")


def audit(version):
    errors = []
    dimensions = {}
    for _, line in active_lines(ROOT / "constants/map_constants.asm", version):
        match = re.fullmatch(r"map_const\s+(\w+),\s*(\d+),\s*(\d+)", line)
        if match:
            name, width, height = match.groups()
            dimensions[name] = int(width), int(height)
        alias = re.fullmatch(r"DEF\s+(\w+)\s+EQU\s+(\w+)", line)
        if alias and alias[2] in dimensions:
            dimensions[alias[1]] = dimensions[alias[2]]

    blocks = {}
    aliases = []
    for _, line in active_lines(ROOT / "maps.asm", version):
        alias = re.fullmatch(r"(\w+)_Blocks:", line)
        if alias:
            aliases.append(alias[1])
            continue
        match = re.fullmatch(r'(\w+)_Blocks:\s+INCBIN\s+"([^"]+)"', line)
        if match:
            for name in aliases + [match[1]]:
                blocks[name] = ROOT / match[2]
            aliases.clear()
        elif aliases:
            raise ValueError(f"Unexpected source after block aliases: {line}")

    maps = {}
    for path in sorted((ROOT / "data/maps/headers").glob("*.asm")):
        for _, line in active_lines(path, version):
            match = re.match(r"map_header\s+(\w+),\s*(\w+),", line)
            if not match:
                continue
            name, map_id = match.groups()
            width, height = dimensions[map_id]
            binary = blocks.get(name)
            if binary is None:
                errors.append(f"{name}: missing block data")
            elif binary.stat().st_size != width * height:
                errors.append(f"{binary.relative_to(ROOT)}: {binary.stat().st_size} blocks, expected {width * height}")
            objects = list(active_lines(ROOT / f"data/maps/objects/{name}.asm", version))
            warps = [(number, line) for number, line in objects if line.startswith("warp_event ")]
            maps[map_id] = name, width * 2, height * 2, objects, warps
    if "BRUNOS_ROOM" in maps:
        maps["KARENS_ROOM"] = maps["BRUNOS_ROOM"]
    elif "KARENS_ROOM" in maps:
        maps["BRUNOS_ROOM"] = maps["KARENS_ROOM"]

    warp_count = 0
    for map_id, (name, width, height, objects, warps) in maps.items():
        if map_id == ("KARENS_ROOM" if version == "red" else "BRUNOS_ROOM"):
            continue
        for number, line in objects:
            event = re.match(r"(warp_event|bg_event|object_event)\s+(-?\d+),\s*(-?\d+),", line)
            if event:
                kind, x, y = event.groups()
                if not (0 <= int(x) < width and 0 <= int(y) < height):
                    errors.append(f"{name}:{number}: {kind} ({x}, {y}) outside {width}x{height}")
        for number, line in warps:
            warp_count += 1
            match = re.fullmatch(r"warp_event\s+\d+,\s*\d+,\s*(\w+|\-1),\s*(\d+)", line)
            if not match:
                errors.append(f"{name}:{number}: cannot parse warp {line}")
                continue
            destination, index = match.groups()
            if destination in ("LAST_MAP", "-1"):
                continue  # resolved from wLastMap at runtime
            if map_id == "SILPH_CO_ELEVATOR" and destination == "UNUSED_MAP_ED":
                continue  # SilphCoElevatorStoreWarpEntriesScript replaces both exits on entry
            target = maps.get(destination)
            if target is None:
                errors.append(f"{name}:{number}: warp to missing map {destination}")
            elif not 1 <= int(index) <= len(target[4]):
                errors.append(f"{name}:{number}: warp {index} outside {destination}'s {len(target[4])} warps")
    print(f"{version}: {len({data[0] for data in maps.values()})} maps, {warp_count} warps, {len(errors)} problems")
    for error in errors:
        print(f"  {error}")
    return errors


def main():
    errors = audit("red") + audit("blue")
    return bool(errors)


if __name__ == "__main__":
    raise SystemExit(main())
