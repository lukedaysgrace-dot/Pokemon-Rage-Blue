#!/usr/bin/env python3
"""Static site generator for Pokemon Rage Blue.

Reads the disassembly source directly and writes a browsable, searchable
site into docs/ (served by GitHub Pages).

    python3 tools/site/build_site.py

Everything is generated from the _BLUE build's data.
"""

import os
import re
import sys
import html
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "docs"
DEFS = ("_BLUE",)

TITLE = "Pokémon Rage Blue"
TAGLINE = "A searchable guide generated directly from the game source."
REPO_URL = "https://github.com/lukedaysgrace-dot/Pokemon-Rage-Blue"


# --------------------------------------------------------------------------
# generic asm helpers
# --------------------------------------------------------------------------

def read(rel):
    p = ROOT / rel if not isinstance(rel, Path) else rel
    return p.read_text(encoding="utf-8", errors="replace").splitlines()


def strip_macros(lines):
    """Drop MACRO ... ENDM blocks (they contain their own IF DEF branches)."""
    out, skip = [], False
    for ln in lines:
        s = ln.strip()
        if s.startswith("MACRO "):
            skip = True
            continue
        if skip:
            if s.startswith("ENDM"):
                skip = False
            continue
        out.append(ln)
    return out


def apply_conditionals(lines, defs=DEFS):
    """Resolve IF DEF(...) / IF GEN_2_GRAPHICS / ELSE / ENDC for our build."""
    out, stack = [], []
    for ln in lines:
        s = ln.strip()
        m = re.match(r"^IF\s+DEF\(\s*(\w+)\s*\)", s)
        if m:
            stack.append(m.group(1) in defs)
            continue
        m = re.match(r"^IF\s+!\s*(\w+)", s)
        if m:
            stack.append(m.group(1) not in ("GEN_2_GRAPHICS_ON",))
            continue
        m = re.match(r"^IF\s+GEN_2_GRAPHICS\b", s)
        if m:
            stack.append(False)
            continue
        if re.match(r"^IF\b", s):
            stack.append(True)
            continue
        if re.match(r"^ELIF\b", s) and stack:
            stack[-1] = False
            continue
        if re.match(r"^ELSE\b", s) and stack:
            stack[-1] = not stack[-1]
            continue
        if re.match(r"^ENDC\b", s) and stack:
            stack.pop()
            continue
        if all(stack):
            out.append(ln)
    return out


def uncomment(ln):
    return ln.split(";")[0].strip()


def comment_of(ln):
    return ln.split(";", 1)[1].strip() if ";" in ln else ""


def title_name(s):
    out, prev = [], False
    for ch in s:
        if ch.isalpha():
            out.append(ch.lower() if prev else ch.upper())
            prev = True
        else:
            out.append(ch)
            prev = ch == "'"
    return "".join(out)


def slugify(s):
    s = s.lower()
    s = s.replace("♂", "-m").replace("♀", "-f").replace("é", "e")
    s = re.sub(r"[^a-z0-9]+", "-", s).strip("-")
    return s or "x"


def parse_consts(rel):
    """const_def / const / const_skip / map_const -> {NAME: value}."""
    vals, cur = {}, 0
    for ln in strip_macros(read(rel)):
        s = uncomment(ln)
        if not s:
            continue
        m = re.match(r"^const_def\s*(-?\d+)?", s)
        if m:
            cur = int(m.group(1)) if m.group(1) else 0
            continue
        m = re.match(r"^const_skip\s*(\d+)?", s)
        if m:
            cur += int(m.group(1) or 1)
            continue
        m = re.match(r"^(?:const|map_const)\s+(\w+)", s)
        if m:
            vals[m.group(1)] = cur
            cur += 1
            continue
    return vals


def parse_string_list(rel, marker=("li", "dname")):
    names = []
    for ln in apply_conditionals(strip_macros(read(rel))):
        s = ln.strip()
        m = re.match(r'^(%s)\s+"([^"]*)"' % "|".join(marker), s)
        if m:
            names.append(m.group(2))
    return names


# --------------------------------------------------------------------------
# types
# --------------------------------------------------------------------------

TYPE_DISPLAY = {
    "NORMAL": "Normal", "FIGHTING": "Fighting", "FLYING": "Flying",
    "POISON": "Poison", "GROUND": "Ground", "ROCK": "Rock", "BIRD": "Bird",
    "BUG": "Bug", "DRAGON": "Dragon", "DARK": "Dark", "STEEL": "Steel",
    "FIRE": "Fire", "WATER": "Water", "GRASS": "Grass",
    "ELECTRIC": "Electric", "PSYCHIC_TYPE": "Psychic", "ICE": "Ice",
    "GHOST": "Ghost",
}

TYPE_CONSTS = parse_consts("constants/type_constants.asm")
TYPE_BY_ID = {v: k for k, v in TYPE_CONSTS.items()}


def type_name(const):
    return TYPE_DISPLAY.get(const, title_name(const.replace("_", " ")))


def type_badge(const):
    n = type_name(const)
    return '<span class="badge type-%s">%s</span>' % (n.lower(), esc(n))


def esc(s):
    return html.escape(str(s), quote=True)


# --------------------------------------------------------------------------
# palettes  (SGB super palettes + per-species assignment)
# --------------------------------------------------------------------------

def load_super_palettes():
    """PAL_NAME -> [(r,g,b) x4] in 8-bit."""
    pals = {}
    lines = apply_conditionals(strip_macros(read("data/sgb/sgb_palettes.asm")))
    for ln in lines:
        if "RGB" not in ln:
            continue
        body = uncomment(ln)
        m = re.match(r"^RGB\s+(.*)$", body)
        if not m:
            continue
        nums = [int(x) for x in re.findall(r"\d+", m.group(1))]
        if len(nums) < 12:
            continue
        name = comment_of(ln).split()[0] if comment_of(ln) else None
        if not name or not name.startswith("PAL_"):
            continue
        pals[name] = [
            (nums[i] * 255 // 31, nums[i + 1] * 255 // 31, nums[i + 2] * 255 // 31)
            for i in (0, 3, 6, 9)
        ]
    return pals


def load_mon_palette_ids():
    """dex number -> PAL_ constant (index 0 is MissingNo)."""
    lines = apply_conditionals(strip_macros(read("data/pokemon/palettes.asm")))
    ids = []
    for ln in lines:
        s = uncomment(ln)
        m = re.match(r"^db\s+(PAL_\w+)$", s)
        if m:
            ids.append(m.group(1))
        elif s.startswith("table_width") and ids:
            break
    return ids


SUPER_PALETTES = load_super_palettes()
MON_PALETTE_IDS = load_mon_palette_ids()


def palette_for_dex(dex):
    name = MON_PALETTE_IDS[dex] if 0 <= dex < len(MON_PALETTE_IDS) else "PAL_MEWMON"
    return SUPER_PALETTES.get(name, SUPER_PALETTES.get("PAL_MEWMON")), name


# --------------------------------------------------------------------------
# pokemon
# --------------------------------------------------------------------------

GROWTH = {
    "GROWTH_MEDIUM_FAST": "Medium Fast", "GROWTH_SLIGHTLY_FAST": "Slightly Fast",
    "GROWTH_SLIGHTLY_SLOW": "Slightly Slow", "GROWTH_MEDIUM_SLOW": "Medium Slow",
    "GROWTH_FAST": "Fast", "GROWTH_SLOW": "Slow",
}

MON_CONSTS = parse_consts("constants/pokemon_constants.asm")
MON_BY_INDEX = {v: k for k, v in MON_CONSTS.items()}
DEX_CONSTS = parse_consts("constants/pokedex_constants.asm")
MON_NAMES_RAW = parse_string_list("data/pokemon/names.asm", ("dname",))

# internal index (1..N) -> display name
INDEX_NAME = {}
for i, raw in enumerate(MON_NAMES_RAW, start=1):
    INDEX_NAME[i] = title_name(raw)

CONST_NAME = {}
for const, idx in MON_CONSTS.items():
    if idx in INDEX_NAME:
        CONST_NAME[const] = INDEX_NAME[idx]
CONST_NAME.setdefault("NO_MON", "None")


def parse_base_stats():
    mons = {}
    order = []
    for ln in read("data/pokemon/base_stats.asm"):
        m = re.match(r'^\s*INCLUDE\s+"(data/pokemon/base_stats/[^"]+)"', ln)
        if m:
            order.append(m.group(1))
    for path in order:
        lines = apply_conditionals(strip_macros(read(path)))
        dbs, tmhm, front = [], [], None
        buf = None
        for ln in lines:
            s = uncomment(ln)
            if not s:
                continue
            if buf is not None:
                buf += " " + s.rstrip("\\").strip()
                if not s.endswith("\\"):
                    tmhm = [t.strip() for t in re.sub(r"^tmhm\s+", "", buf).split(",") if t.strip()]
                    buf = None
                continue
            if s.startswith("tmhm"):
                buf = s.rstrip("\\").strip()
                if not s.endswith("\\"):
                    tmhm = [t.strip() for t in re.sub(r"^tmhm\s+", "", buf).split(",") if t.strip()]
                    buf = None
                continue
            m = re.match(r'^INCBIN\s+"([^"]+)"', s)
            if m:
                front = m.group(1)
                continue
            if s.startswith("db "):
                dbs.append(s[3:].strip())
        if len(dbs) < 7:
            continue
        dex = DEX_CONSTS.get(dbs[0].strip(), 0)
        stats = [int(x) for x in re.findall(r"-?\d+", dbs[1])]
        types = [t.strip() for t in dbs[2].split(",")]
        slug = Path(path).stem
        name = None
        for const, idx in MON_CONSTS.items():
            pass
        mons[slug] = {
            "slug": slug,
            "file": path,
            "dex": dex,
            "dex_const": dbs[0].strip(),
            "hp": stats[0], "atk": stats[1], "def": stats[2],
            "spd": stats[3], "spc": stats[4],
            "types": [t for t in types if t],
            "catch": int(re.findall(r"-?\d+", dbs[3])[0]),
            "exp": int(re.findall(r"-?\d+", dbs[4])[0]),
            "start_moves": [m.strip() for m in dbs[5].split(",") if m.strip() not in ("", "NO_MOVE")],
            "growth": GROWTH.get(dbs[6].strip(), title_name(dbs[6].replace("GROWTH_", "").replace("_", " "))),
            "tmhm": tmhm,
            "front": front,
        }
    return mons


def parse_dex_order():
    """internal index (1..N) -> dex number."""
    out = {}
    i = 0
    for ln in read("data/pokemon/dex_order.asm"):
        s = uncomment(ln)
        m = re.match(r"^db\s+(\S+)$", s)
        if m:
            i += 1
            out[i] = DEX_CONSTS.get(m.group(1), 0)
    return out


INDEX_DEX = parse_dex_order()
DEX_INDEX = {v: k for k, v in INDEX_DEX.items() if v}


def parse_dex_entries():
    """dex entry label -> {species, height_ft, height_in, weight, text}."""
    entries = {}
    lines = apply_conditionals(strip_macros(read("data/pokemon/dex_entries.asm")))
    cur = None
    for ln in lines:
        m = re.match(r"^(\w+)DexEntry:", ln)
        if m:
            cur = m.group(1)
            entries[cur] = {"species": "", "ft": 0, "inch": 0, "weight": 0}
            continue
        if cur is None:
            continue
        s = uncomment(ln)
        m = re.match(r'^db\s+"([^"]*)@"', s)
        if m:
            entries[cur]["species"] = title_name(m.group(1))
            continue
        m = re.match(r"^db\s+(\d+)\s*,\s*(\d+)$", s)
        if m:
            entries[cur]["ft"], entries[cur]["inch"] = int(m.group(1)), int(m.group(2))
            continue
        m = re.match(r"^dw\s+(\d+)$", s)
        if m:
            entries[cur]["weight"] = int(m.group(1))
    return entries


def detext(s):
    """Expand the disassembly's text control codes into readable prose."""
    s = s.replace("#MON", "Pokémon").replace("#", "Poké")
    s = s.replace("<PLAYER>", "the player").replace("<RIVAL>", "the rival")
    s = s.replace("<TARGET>", "the target").replace("<USER>", "the user")
    s = re.sub(r"<[^>]*>", "", s)
    return s.replace("@", "").strip()


def parse_dex_text():
    """_XDexEntry -> flavour text."""
    out, cur, parts = {}, None, []
    for ln in read("data/pokemon/dex_text.asm"):
        m = re.match(r"^_(\w+)DexEntry::", ln)
        if m:
            if cur:
                out[cur] = " ".join(parts).strip()
            cur, parts = m.group(1), []
            continue
        if cur is None:
            continue
        s = ln.strip()
        if s.startswith("dex"):
            out[cur] = " ".join(parts).strip()
            cur, parts = None, []
            continue
        m = re.match(r'^(text|next|page|line|para)\s+"([^"]*)"', s)
        if m:
            parts.append(detext(m.group(2)))
    if cur:
        out[cur] = " ".join(parts).strip()
    return out


def parse_evos_moves():
    """mon constant -> {'evos': [...], 'learnset': [(level, MOVE)]}."""
    lines = apply_conditionals(strip_macros(read("data/pokemon/evos_moves.asm")))
    # label order from the pointer table = internal index order
    labels = []
    for ln in lines:
        m = re.match(r"^\s*dw\s+(\w+EvosMoves)$", uncomment(ln))
        if m:
            labels.append(m.group(1))
    blocks, cur = {}, None
    for ln in lines:
        m = re.match(r"^(\w+EvosMoves):", ln)
        if m:
            cur = m.group(1)
            blocks[cur] = []
            continue
        if cur:
            blocks[cur].append(ln)
    result = {}
    for i, label in enumerate(labels, start=1):
        const = MON_BY_INDEX.get(i)
        if not const:
            continue
        evos, learn, in_evos = [], [], True
        for ln in blocks.get(label, []):
            s = uncomment(ln)
            if not s:
                continue
            m = re.match(r"^(?:blue_)?evolve_level\s+(\d+)\s*,\s*(\w+)$", s)
            if m:
                evos.append(("level", m.group(1), m.group(2)))
                continue
            m = re.match(r"^(?:blue_)?evolve_item\s+(\w+)\s*,\s*(\d+)\s*,\s*(\w+)$", s)
            if m:
                evos.append(("item", m.group(1), m.group(3)))
                continue
            if not s.startswith("db"):
                continue
            args = [a.strip() for a in s[2:].split(",")]
            if in_evos:
                if args[0] == "EVOLVE_LEVEL":
                    evos.append(("level", args[1], args[2]))
                elif args[0] == "EVOLVE_ITEM":
                    evos.append(("item", args[1], args[3]))
                elif args[0] == "EVOLVE_TRADE":
                    evos.append(("trade", args[1], args[2]))
                elif args[0] == "0":
                    in_evos = False
                continue
            if args[0] == "0":
                break
            if len(args) >= 2:
                learn.append((int(args[0]), args[1]))
        result[const] = {"evos": evos, "learnset": learn}
    return result


# --------------------------------------------------------------------------
# moves
# --------------------------------------------------------------------------

def parse_moves():
    names = [title_name(n) for n in parse_string_list("data/moves/names.asm", ("li",))]
    lines = apply_conditionals(strip_macros(read("data/moves/moves.asm")))
    rows = []
    for ln in lines:
        s = uncomment(ln)
        m = re.match(r"^move\s+(.*)$", s)
        if not m:
            continue
        args = [a.strip() for a in m.group(1).split(",")]
        if len(args) < 6:
            continue
        rows.append({
            "const": args[0],
            "effect": args[1],
            "power": int(re.findall(r"-?\d+", args[2])[0]),
            "type": args[3],
            "acc": int(re.findall(r"-?\d+", args[4])[0]),
            "pp": int(re.findall(r"-?\d+", args[5])[0]),
        })
    moves = {}
    for i, row in enumerate(rows):
        row["num"] = i + 1
        row["name"] = names[i] if i < len(names) else title_name(row["const"])
        row["slug"] = slugify(row["name"])
        moves[row["const"]] = row
    return moves


def parse_tmhm():
    """MOVE const -> 'TM08' / 'HM01'."""
    out = {}
    tms, hms = [], []
    for ln in read("constants/item_constants.asm"):
        s = uncomment(ln)
        m = re.match(r"^add_tm\s+(\w+)", s)
        if m:
            tms.append(m.group(1))
        m = re.match(r"^add_hm\s+(\w+)", s)
        if m:
            hms.append(m.group(1))
    for i, mv in enumerate(tms, start=1):
        out[mv] = "TM%02d" % i
    for i, mv in enumerate(hms, start=1):
        out[mv] = "HM%02d" % i
    return out


ITEM_NAMES = [title_name(n) for n in parse_string_list("data/items/names.asm", ("li",))]
ITEM_CONSTS = parse_consts("constants/item_constants.asm")
ITEM_BY_CONST = {}
for _c, _v in ITEM_CONSTS.items():
    if 1 <= _v <= len(ITEM_NAMES):
        ITEM_BY_CONST[_c] = ITEM_NAMES[_v - 1]


def item_name(const):
    return ITEM_BY_CONST.get(const, title_name(const.replace("_", " ")))


# --------------------------------------------------------------------------
# maps / wild encounters
# --------------------------------------------------------------------------

MAP_FIXUPS = [
    (r"\bSs\b", "S.S."), (r"\bMt\b", "Mt."), (r"\bB(\d)f\b", r"B\1F"),
    (r"\b(\d)f\b", r"\1F"), (r"\bHq\b", "HQ"), (r"\bPokecenter\b", "Poké Center"),
    (r"\bPokemon\b", "Pokémon"), (r"\bSilphco\b", "Silph Co."),
]


def map_title(const):
    s = title_name(const.replace("_", " "))
    for pat, rep in MAP_FIXUPS:
        s = re.sub(pat, rep, s)
    return s


def parse_wild():
    """label -> {'grass_rate','grass','water_rate','water'}"""
    data = {}
    for path in sorted((ROOT / "data/wild/maps").glob("*.asm")):
        lines = apply_conditionals(strip_macros(read(path)))
        cur, mode = None, None
        for ln in lines:
            m = re.match(r"^(\w+WildMons):", ln)
            if m:
                cur = m.group(1)
                data[cur] = {"grass_rate": 0, "grass": [], "water_rate": 0, "water": []}
                mode = None
                continue
            if cur is None:
                continue
            s = uncomment(ln)
            m = re.match(r"^def_(grass|water)_wildmons\s+(\d+)", s)
            if m:
                mode = m.group(1)
                data[cur][mode + "_rate"] = int(m.group(2))
                continue
            if re.match(r"^end_(grass|water)_wildmons", s):
                mode = None
                continue
            m = re.match(r"^db\s+(\d+)\s*,\s*(\w+)$", s)
            if m and mode:
                data[cur][mode].append((int(m.group(1)), m.group(2)))
    return data


MAP_CONSTS = parse_consts("constants/map_constants.asm")
MAP_BY_ID = {}
for _k, _v in MAP_CONSTS.items():
    MAP_BY_ID.setdefault(_v, _k)


def parse_wild_map_table():
    """ordered [(MAP_CONST, label)] from the WildDataPointers table."""
    out, i = [], 0
    for ln in read("data/wild/grass_water.asm"):
        s = uncomment(ln)
        m = re.match(r"^dw\s+(\w+)$", s)
        if m:
            out.append((MAP_BY_ID.get(i, ""), m.group(1)))
            i += 1
        elif out and s.startswith("INCLUDE"):
            break
    return out


def parse_rod(rel, label):
    lines = apply_conditionals(strip_macros(read(rel)))
    mons, started = [], False
    for ln in lines:
        s = uncomment(ln)
        if s.startswith(label):
            started = True
            continue
        if not started:
            continue
        m = re.match(r"^db\s+(\d+)\s*,\s*(\w+)$", s)
        if m:
            mons.append((int(m.group(1)), m.group(2)))
    return mons


def parse_super_rod():
    """MAP_CONST -> [(level, MON)]"""
    lines = apply_conditionals(strip_macros(read("data/wild/super_rod.asm")))
    assign, groups, cur = [], {}, None
    for ln in lines:
        s = uncomment(ln)
        m = re.match(r"^dbw\s+(\w+)\s*,\s*\.(\w+)$", s)
        if m:
            assign.append((m.group(1), m.group(2)))
            continue
        m = re.match(r"^\.(\w+):", s)
        if m:
            cur = m.group(1)
            groups[cur] = []
            continue
        if cur is None:
            continue
        m = re.match(r"^db\s+(\d+)\s*,\s*(\w+)$", s)
        if m:
            groups[cur].append((int(m.group(1)), m.group(2)))
    return {mp: groups.get(g, []) for mp, g in assign}


# --------------------------------------------------------------------------
# sprites: recolour the 4-shade source art with each species' in-game palette
# --------------------------------------------------------------------------

try:
    from PIL import Image
    HAVE_PIL = True
except ImportError:
    HAVE_PIL = False


def luminance(rgb):
    return (rgb[0] * 299 + rgb[1] * 587 + rgb[2] * 114) // 1000


def shade_map(colors):
    """Map an image's source colours onto GB colour indices 0-3.

    The art is 4-colour but does not always use the exact 0/85/170/255 ramp
    (Salamence's front sprite, for instance, uses 254/110/100/0). rgbgfx ranks
    the colours by luminance when it builds the .2bpp tiles, so rank them the
    same way here instead of quantising by absolute brightness - otherwise two
    near-identical greys collapse onto one palette colour and a whole shade of
    the mon's palette never gets used.
    """
    order = sorted(colors, key=lambda c: -luminance(c))
    if len(order) == 4:
        return {c: i for i, c in enumerate(order)}
    # unusual art with fewer shades: fall back to the nearest DMG grey
    return {c: min(3, max(0, int(round((255 - luminance(c)) / 85.0)))) for c in order}


def colorize(src, dst, palette):
    """Map the 4 grey shades onto the mon's SGB palette; cut the outer background."""
    im = Image.open(src).convert("RGB")
    w, h = im.size
    raw = im.tobytes()
    px = [tuple(raw[i:i + 3]) for i in range(0, len(raw), 3)]
    lookup = shade_map(set(px))
    shades = [lookup[p] for p in px]

    # flood fill the outside background (shade 0) so it becomes transparent
    outside = bytearray(w * h)
    stack = []
    for x in range(w):
        for y in (0, h - 1):
            stack.append(y * w + x)
    for y in range(h):
        for x in (0, w - 1):
            stack.append(y * w + x)
    while stack:
        i = stack.pop()
        if outside[i] or shades[i] != 0:
            continue
        outside[i] = 1
        x, y = i % w, i // w
        if x > 0:
            stack.append(i - 1)
        if x < w - 1:
            stack.append(i + 1)
        if y > 0:
            stack.append(i - w)
        if y < h - 1:
            stack.append(i + w)

    out = Image.new("RGBA", (w, h))
    data = []
    for i, s in enumerate(shades):
        if outside[i]:
            data.append((0, 0, 0, 0))
        else:
            r, g, b = palette[s]
            data.append((r, g, b, 255))
    out.putdata(data)
    dst.parent.mkdir(parents=True, exist_ok=True)
    out.save(dst)


def build_sprites(mons):
    made = {"front": {}, "back": {}}
    if not HAVE_PIL:
        print("  ! Pillow not installed - sprites will be skipped "
              "(pip install Pillow)", file=sys.stderr)
        return made
    for slug, mon in mons.items():
        palette, _ = palette_for_dex(mon["dex"])
        # the art files are named after the INCBIN path, which does not always
        # match the base_stats filename (mrmime -> mr.mime, porygonz -> porygon_z)
        art = Path(mon["front"]).stem if mon.get("front") else slug
        for kind, rel in (("front", "gfx/pokemon/front/%s.png" % art),
                          ("back", "gfx/pokemon/back/%sb.png" % art)):
            src = ROOT / rel
            if not src.exists():
                continue
            dst = OUT / "assets" / "sprites" / kind / ("%s.png" % slug)
            try:
                colorize(src, dst, palette)
                made[kind][slug] = "assets/sprites/%s/%s.png" % (kind, slug)
            except Exception as exc:
                print("  ! %s %s: %s" % (kind, slug, exc), file=sys.stderr)
    return made


# --------------------------------------------------------------------------
# page shell
# --------------------------------------------------------------------------

NAV = [("pokedex.html", "Pokédex"), ("moves.html", "Moves"),
       ("encounters.html", "Encounters"), ("locations.html", "Locations")]


def page(path, title, body, depth=0):
    up = "../" * depth
    nav = "".join('<a href="%s%s">%s</a>' % (up, href, esc(label))
                  for href, label in NAV)
    doc = (
        '<!doctype html><html lang="en"><head><meta charset="utf-8">'
        '<meta name="viewport" content="width=device-width,initial-scale=1">'
        '<title>%s · %s</title>'
        '<link rel="stylesheet" href="%sassets/style.css"></head><body>'
        '<header><a class="brand" href="%sindex.html">◆ %s</a><nav>%s</nav></header>'
        '<main>%s</main>'
        '<footer>Generated from the <a href="%s">Pokémon Rage Blue</a> source. '
        'Data reflects the Blue build.</footer>'
        '</body></html>'
    ) % (esc(title), esc(TITLE), up, up, esc(TITLE), nav, body, REPO_URL)
    dst = OUT / path
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(doc, encoding="utf-8")


def stat_bar(label, value, mx=180):
    pct = min(100, int(value * 100 / mx))
    return ('<div class="stat"><span>%s</span><i><b style="width:%d%%"></b></i>'
            '<span>%d</span></div>' % (esc(label), pct, value))


def mon_link(mon, up=""):
    return '<a href="%spokemon/%s.html">%s</a>' % (up, mon["slug"], esc(mon["name"]))


def build():
    print("Reading source data...")
    base = parse_base_stats()
    evos = parse_evos_moves()
    moves = parse_moves()
    tmhm_num = parse_tmhm()
    dex_entries = parse_dex_entries()
    dex_text = parse_dex_text()
    wild = parse_wild()
    wild_table = parse_wild_map_table()
    super_rod = parse_super_rod()
    old_rod = parse_rod("data/wild/old_rod.asm", "OldRodMons")
    good_rod = parse_rod("data/wild/good_rod.asm", "GoodRodMons")

    # ---- assemble the pokemon records -----------------------------------
    mons = {}          # const -> record
    by_slug = {}
    for slug, m in base.items():
        idx = DEX_INDEX.get(m["dex"])
        const = MON_BY_INDEX.get(idx) if idx else None
        name = INDEX_NAME.get(idx) if idx else title_name(slug)
        if not const:
            const = slug.upper()
        rec = dict(m)
        rec["const"] = const
        rec["index"] = idx or 0
        rec["name"] = name or title_name(slug)
        rec["total"] = m["hp"] + m["atk"] + m["def"] + m["spd"] + m["spc"]
        ev = evos.get(const, {"evos": [], "learnset": []})
        rec["evos"] = ev["evos"]
        rec["learnset"] = ev["learnset"]
        rec["locations"] = []
        entry_key = "".join(c for c in slug.title() if c.isalnum())
        rec["entry"] = None
        for key in (entry_key, slug.capitalize()):
            if key in dex_entries:
                rec["entry"] = dex_entries[key]
                rec["flavour"] = dex_text.get(key, "")
                break
        rec.setdefault("flavour", "")
        mons[const] = rec
        by_slug[slug] = rec

    ordered = sorted(mons.values(), key=lambda r: (r["dex"] or 9999, r["name"]))

    # pre-evolutions
    for rec in ordered:
        for kind, arg, target in rec["evos"]:
            t = mons.get(target)
            if t is not None:
                t.setdefault("from", []).append((rec, kind, arg))

    sprites = build_sprites(by_slug)
    for slug, rec in by_slug.items():
        rec["front_png"] = sprites["front"].get(slug)
        rec["back_png"] = sprites["back"].get(slug)

    # ---- locations -------------------------------------------------------
    locations = []
    seen = {}
    for const, label in wild_table:
        if not const or const == "unused":
            continue
        w = wild.get(label)
        grass = w["grass"] if w else []
        water = w["water"] if w else []
        srod = super_rod.get(const, [])
        if not (grass or water or srod):
            continue
        loc = {
            "const": const,
            "title": map_title(const),
            "slug": slugify(const),
            "grass": grass,
            "grass_rate": w["grass_rate"] if w else 0,
            "water": water,
            "water_rate": w["water_rate"] if w else 0,
            "super_rod": srod,
        }
        if loc["slug"] in seen:
            continue
        seen[loc["slug"]] = loc
        locations.append(loc)

    for loc in locations:
        for method, entries in (("Grass", loc["grass"]), ("Surfing", loc["water"]),
                                ("Super Rod", loc["super_rod"])):
            for lvl, mon in entries:
                rec = mons.get(mon)
                if rec is not None:
                    rec["locations"].append((loc, method, lvl))
    for name, entries in (("Old Rod", old_rod), ("Good Rod", good_rod)):
        for lvl, mon in entries:
            rec = mons.get(mon)
            if rec is not None:
                rec["locations"].append(({"title": "Any fishable water",
                                          "slug": None}, name, lvl))

    render_all(mons, ordered, moves, tmhm_num, locations, old_rod, good_rod)


SEARCH_JS = """
<script>
(function(){
  var q=document.getElementById('q'), t=document.getElementById('t');
  var items=[].slice.call(document.querySelectorAll('[data-search]'));
  var count=document.getElementById('count');
  function run(){
    var s=(q&&q.value||'').toLowerCase().trim(), ty=(t&&t.value)||'';
    var n=0;
    items.forEach(function(el){
      var ok=(!s||el.dataset.search.indexOf(s)>-1)&&(!ty||(' '+el.dataset.types+' ').indexOf(' '+ty+' ')>-1);
      el.hidden=!ok; if(ok)n++;
    });
    if(count)count.textContent=n+' shown';
  }
  if(q)q.addEventListener('input',run);
  if(t)t.addEventListener('change',run);
  run();
})();
</script>
"""


def effect_name(const):
    if const in ("NO_ADDITIONAL_EFFECT", "NO_EFFECT"):
        return "—"
    return title_name(re.sub(r"_EFFECT\d*$", "", const).replace("_", " "))


def toolbar(types, placeholder="Search..."):
    opts = "".join('<option value="%s">%s</option>' % (t.lower(), esc(t))
                   for t in types)
    return ('<div class="toolbar"><input id="q" placeholder="%s" autocomplete="off">'
            '<select id="t"><option value="">All types</option>%s</select></div>'
            '<p class="muted" id="count"></p>' % (esc(placeholder), opts))


def mon_card(rec, up=""):
    types = [type_name(t) for t in rec["types"]]
    types = list(dict.fromkeys(types))
    img = ('<img src="%s%s" alt="%s" loading="lazy">' % (up, rec["front_png"], esc(rec["name"]))
           if rec.get("front_png") else '<div class="placeholder">◆</div>')
    return ('<a class="card" href="%spokemon/%s.html" data-search="%s" data-types="%s">'
            '<small>#%03d</small>%s<div class="cname">%s</div><div>%s</div></a>' % (
                up, rec["slug"],
                esc((rec["name"] + " " + " ".join(types)).lower()),
                esc(" ".join(t.lower() for t in types)),
                rec["dex"], img, esc(rec["name"]),
                "".join(type_badge(t) for t in dict.fromkeys(rec["types"]))))


def render_all(mons, ordered, moves, tmhm_num, locations, old_rod, good_rod):
    all_types = sorted({type_name(t) for r in ordered for t in r["types"]})
    move_types = sorted({type_name(m["type"]) for m in moves.values()})

    # ---------- home ------------------------------------------------------
    preview = "".join(mon_card(r) for r in ordered[:36])
    slots = sum(len(l["grass"]) + len(l["water"]) + len(l["super_rod"]) for l in locations)
    body = (
        '<section class="hero"><div><p class="eyebrow">GAME BOY COLOR ROM HACK</p>'
        '<h1>Rage Blue</h1><p>%s</p>'
        '<a class="button" href="pokedex.html">Explore the Pokédex</a></div>'
        '<div class="gem">◆</div></section>'
        '<section class="counts"><div><b>%d</b> Pokémon</div><div><b>%d</b> Moves</div>'
        '<div><b>%d</b> Encounter slots</div></section>'
        '<h2>Pokédex preview</h2><div class="grid">%s</div>'
        '<p class="more"><a class="button" href="pokedex.html">See all %d Pokémon</a></p>'
    ) % (esc(TAGLINE), len(ordered), len(moves), slots, preview, len(ordered))
    page("index.html", "Home", body)

    # ---------- pokedex ---------------------------------------------------
    body = ('<div class="head"><h1>Pokédex</h1><p class="muted">%d species in the '
            'Blue build.</p></div>%s<div class="grid">%s</div>%s') % (
        len(ordered), toolbar(all_types, "Search by name or type..."),
        "".join(mon_card(r) for r in ordered), SEARCH_JS)
    page("pokedex.html", "Pokédex", body)

    # ---------- per-mon ---------------------------------------------------
    for rec in ordered:
        render_mon(rec, mons, moves, tmhm_num)

    # ---------- moves -----------------------------------------------------
    rows = []
    for m in sorted(moves.values(), key=lambda x: x["num"]):
        tn = type_name(m["type"])
        rows.append(
            '<div class="row" data-search="%s" data-types="%s">'
            '<span><b>%s</b></span><span>%s</span><span>%s</span>'
            '<span>%s</span><span>%s</span><span>%s</span></div>' % (
                esc((m["name"] + " " + tn + " " + effect_name(m["effect"])).lower()),
                esc(tn.lower()), esc(m["name"]), type_badge(m["type"]),
                esc(effect_name(m["effect"])),
                m["power"] or "—", m["acc"] or "—", m["pp"]))
    header = ('<div class="row labels"><span>Move</span><span>Type</span>'
              '<span>Effect</span><span>Pwr</span><span>Acc</span><span>PP</span></div>')
    body = ('<div class="head"><h1>Moves</h1><p class="muted">%d moves.</p></div>'
            '%s<div class="table">%s%s</div>%s') % (
        len(moves), toolbar(move_types, "Search moves..."),
        header, "".join(rows), SEARCH_JS)
    page("moves.html", "Moves", body)

    # ---------- locations -------------------------------------------------
    cards = []
    for loc in sorted(locations, key=lambda l: l["title"]):
        bits = []
        if loc["grass"]:
            bits.append("Grass")
        if loc["water"]:
            bits.append("Surfing")
        if loc["super_rod"]:
            bits.append("Super Rod")
        species = len({m for _, m in loc["grass"] + loc["water"] + loc["super_rod"]})
        cards.append(
            '<a class="location-card" href="location/%s.html" data-search="%s" data-types="">'
            '<h3>%s</h3><p>%d species</p><div class="chips">%s</div></a>' % (
                loc["slug"], esc(loc["title"].lower()), esc(loc["title"]), species,
                "".join("<span>%s</span>" % esc(b) for b in bits)))
    body = ('<div class="head"><h1>Locations</h1><p class="muted">%d places with wild '
            'encounters.</p></div><div class="toolbar"><input id="q" placeholder="Search locations..." '
            'autocomplete="off"></div><p class="muted" id="count"></p>'
            '<div class="location-grid">%s</div>%s') % (
        len(locations), "".join(cards), SEARCH_JS)
    page("locations.html", "Locations", body)

    for loc in locations:
        render_location(loc, mons)

    # ---------- encounters ------------------------------------------------
    render_encounters(locations, mons, old_rod, good_rod)



def render_mon(rec, mons, moves, tmhm_num):
    up = "../"
    img = ('<img class="big" src="%s%s" alt="%s">' % (up, rec["front_png"], esc(rec["name"]))
           if rec.get("front_png") else '<div class="placeholder big">◆</div>')
    back = ('<img class="backsprite" src="%s%s" alt="%s (back)">' % (up, rec["back_png"], esc(rec["name"]))
            if rec.get("back_png") else "")

    entry = rec.get("entry") or {}
    flavour = rec.get("flavour", "")
    meta = []
    if entry.get("species"):
        meta.append("<div><dt>Species</dt><dd>%s</dd></div>" % esc(entry["species"]))
    if entry.get("ft") or entry.get("inch"):
        meta.append("<div><dt>Height</dt><dd>%d'%02d\"</dd></div>" % (entry["ft"], entry["inch"]))
    if entry.get("weight"):
        meta.append("<div><dt>Weight</dt><dd>%.1f lb</dd></div>" % (entry["weight"] / 10.0))
    meta.append("<div><dt>Catch rate</dt><dd>%d</dd></div>" % rec["catch"])
    meta.append("<div><dt>Base exp</dt><dd>%d</dd></div>" % rec["exp"])
    meta.append("<div><dt>Growth</dt><dd>%s</dd></div>" % esc(rec["growth"]))

    stats = "".join([
        stat_bar("HP", rec["hp"]), stat_bar("Attack", rec["atk"]),
        stat_bar("Defense", rec["def"]), stat_bar("Speed", rec["spd"]),
        stat_bar("Special", rec["spc"]),
    ])

    # evolutions
    evo_rows = []
    for prev, kind, arg in rec.get("from", []):
        evo_rows.append('<p class="evofrom">Evolves from %s</p>' % mon_link(prev, up))
    for kind, arg, target in rec["evos"]:
        t = mons.get(target)
        label = {"level": "Level %s" % arg, "item": item_name(arg), "trade": "Trade"}.get(kind, kind)
        name = mon_link(t, up) if t else esc(title_name(target))
        evo_rows.append('<div class="evorow"><span class="cond">%s</span>'
                        '<span class="arrow">→</span>%s</div>' % (esc(label), name))
    evo_html = "".join(evo_rows) or '<p class="noevo">Does not evolve.</p>'

    # learnset
    learn = ['<div class="learn header"><span>Level</span><span>Move</span><span>Type</span></div>']
    for mv in rec["start_moves"]:
        m = moves.get(mv)
        learn.append('<div class="learn"><span>Start</span><span>%s</span><span>%s</span></div>' % (
            esc(m["name"] if m else title_name(mv)), type_badge(m["type"]) if m else ""))
    for lvl, mv in rec["learnset"]:
        m = moves.get(mv)
        learn.append('<div class="learn"><span>Lv %d</span><span>%s</span><span>%s</span></div>' % (
            lvl, esc(m["name"] if m else title_name(mv)), type_badge(m["type"]) if m else ""))

    tms = []
    for mv in rec["tmhm"]:
        m = moves.get(mv)
        num = tmhm_num.get(mv, "")
        tms.append("<code>%s%s</code>" % (
            ("<b>%s</b> " % esc(num)) if num else "",
            esc(m["name"] if m else title_name(mv))))
    tm_html = ('<div class="chips">%s</div>' % "".join(tms)) if tms else '<p class="noevo">None.</p>'

    # where to find
    locs = []
    for loc, method, lvl in rec["locations"]:
        link = ('<a href="%slocation/%s.html">%s</a>' % (up, loc["slug"], esc(loc["title"]))
                if loc.get("slug") else esc(loc["title"]))
        locs.append('<div class="location-row">%s<span>%s</span><span>Lv %d</span></div>' % (
            link, esc(method), lvl))
    loc_html = ("".join(locs) if locs
                else '<p class="noevo">Not found in the wild — evolve, trade or catch it elsewhere.</p>')

    body = (
        '<p><a class="back" href="%spokedex.html">← Pokédex</a></p>'
        '<section class="monhero"><div class="sprites">%s%s</div>'
        '<div><p class="eyebrow">#%03d</p><h1>%s</h1><div>%s</div>'
        '<p class="flavour">%s</p></div></section>'
        '<div class="twocol">'
        '<div class="panel"><h2>Base stats <em>Total %d</em></h2>%s</div>'
        '<div class="panel"><h2>Details</h2><dl>%s</dl></div></div>'
        '<div class="twocol">'
        '<div class="panel"><h2>Level-up moves</h2>%s</div>'
        '<div><div class="panel"><h2>Evolution</h2><div class="evolist">%s</div></div>'
        '<div class="panel"><h2>Where to find</h2>%s</div></div></div>'
        '<div class="panel"><h2>TM / HM</h2>%s</div>'
    ) % (up, img, back, rec["dex"], esc(rec["name"]),
         "".join(type_badge(t) for t in dict.fromkeys(rec["types"])),
         esc(flavour), rec["total"], stats, "".join(meta),
         "".join(learn), evo_html, loc_html, tm_html)
    page("pokemon/%s.html" % rec["slug"], rec["name"], body, depth=1)


def encounter_table(entries, mons, up, title, rate=None):
    if not entries:
        return ""
    counts = {}
    for lvl, mon in entries:
        counts[mon] = counts.get(mon, 0) + 1
    total = len(entries)
    rows = ['<div class="encounter-card labels"><span>Pokémon</span><span>Type</span>'
            '<span>Levels</span><span>Slots</span><span>Rate</span></div>']
    order = []
    for lvl, mon in entries:
        if mon not in order:
            order.append(mon)
    for mon in order:
        rec = mons.get(mon)
        lvls = sorted({l for l, m in entries if m == mon})
        lv = str(lvls[0]) if len(lvls) == 1 else "%d–%d" % (lvls[0], lvls[-1])
        rows.append('<div class="encounter-card"><span>%s</span><span>%s</span>'
                    '<span>Lv %s</span><span>%d/%d</span><span>%d%%</span></div>' % (
                        mon_link(rec, up) if rec else esc(title_name(mon)),
                        "".join(type_badge(t) for t in dict.fromkeys(rec["types"])) if rec else "",
                        lv, counts[mon], total, round(counts[mon] * 100.0 / total)))
    head = esc(title)
    if rate:
        head += ' <em>encounter rate %d</em>' % rate
    return '<div class="panel"><h2>%s</h2>%s</div>' % (head, "".join(rows))


def render_location(loc, mons):
    up = "../"
    body = ('<p><a class="back" href="%slocations.html">← Locations</a></p>'
            '<div class="head"><h1>%s</h1></div>%s%s%s') % (
        up, esc(loc["title"]),
        encounter_table(loc["grass"], mons, up, "Tall grass", loc["grass_rate"]),
        encounter_table(loc["water"], mons, up, "Surfing", loc["water_rate"]),
        encounter_table(loc["super_rod"], mons, up, "Super Rod"))
    page("location/%s.html" % loc["slug"], loc["title"], body, depth=1)


def render_encounters(locations, mons, old_rod, good_rod):
    rows = []
    for loc in sorted(locations, key=lambda l: l["title"]):
        for method, entries in (("Grass", loc["grass"]), ("Surfing", loc["water"]),
                                ("Super Rod", loc["super_rod"])):
            seen = []
            for lvl, mon in entries:
                if mon in seen:
                    continue
                seen.append(mon)
                rec = mons.get(mon)
                lvls = sorted({l for l, m in entries if m == mon})
                lv = str(lvls[0]) if len(lvls) == 1 else "%d–%d" % (lvls[0], lvls[-1])
                slots = sum(1 for _, m in entries if m == mon)
                rows.append(
                    '<div class="erow" data-search="%s" data-types="%s">'
                    '<span><a href="location/%s.html">%s</a></span>'
                    '<span>%s</span><span>%s</span><span>%s</span>'
                    '<span>Lv %s</span><span>%d%%</span></div>' % (
                        esc((loc["title"] + " " + (rec["name"] if rec else mon) + " " + method).lower()),
                        esc(" ".join(type_name(t).lower() for t in rec["types"]) if rec else ""),
                        loc["slug"], esc(loc["title"]),
                        mon_link(rec) if rec else esc(title_name(mon)),
                        "".join(type_badge(t) for t in dict.fromkeys(rec["types"])) if rec else "",
                        esc(method), lv, round(slots * 100.0 / max(1, len(entries)))))
    fishing = []
    for name, entries in (("Old Rod", old_rod), ("Good Rod", good_rod)):
        for lvl, mon in entries:
            rec = mons.get(mon)
            fishing.append('<div class="location-row">%s<span>%s</span><span>Lv %d</span></div>' % (
                mon_link(rec) if rec else esc(title_name(mon)), esc(name), lvl))
    all_types = sorted({type_name(t) for r in mons.values() for t in r["types"]})
    head = ('<div class="erow labels"><span>Location</span><span>Pokémon</span><span>Type</span>'
            '<span>Method</span><span>Levels</span><span>Rate</span></div>')
    body = ('<div class="head"><h1>Encounters</h1><p class="muted">Every wild slot in the '
            'Blue build.</p></div>%s<div class="table">%s%s</div>'
            '<div class="panel"><h2>Old Rod &amp; Good Rod <em>anywhere fishable</em></h2>%s</div>%s') % (
        toolbar(all_types, "Search by location, Pokémon or method..."),
        head, "".join(rows), "".join(fishing), SEARCH_JS)
    page("encounters.html", "Encounters", body)


def main():
    # docs/ is entirely generated: clear it so removed pages never linger
    if OUT.exists():
        for child in OUT.iterdir():
            try:
                shutil.rmtree(child) if child.is_dir() else child.unlink()
            except OSError as exc:
                print("  ! could not remove %s: %s" % (child, exc), file=sys.stderr)
    OUT.mkdir(parents=True, exist_ok=True)
    css_src = Path(__file__).with_name("style.css")
    (OUT / "assets").mkdir(parents=True, exist_ok=True)
    shutil.copyfile(css_src, OUT / "assets" / "style.css")
    (OUT / ".nojekyll").write_text("", encoding="utf-8")
    build()
    n = sum(1 for _ in OUT.rglob("*.html"))
    print("Done. %d pages in %s" % (n, OUT))


if __name__ == "__main__":
    main()
