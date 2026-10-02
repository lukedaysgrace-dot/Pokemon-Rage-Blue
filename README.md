# Pokémon Rage Blue

Pokémon Rage Blue is a Game Boy Color ROM hack built from the
[pret/pokered](https://github.com/pret/pokered) disassembly. It expands the
original game with a larger Pokédex, additional species, moves and types,
reworked trainer and wild encounters, new story and postgame content, modern
battle fixes, full-color presentation, and an optional hard mode.

The repository builds three development ROMs:

- `pokered.gbc` — Red-version content
- `pokeblue.gbc` — Blue-version content
- `pokeblue_debug.gbc` — Blue debug build

These are modified builds and are not expected to match the hashes of the
retail Pokémon Red or Blue ROMs.

## Recent gameplay updates

- In the Blue build, Route 2 now has level 5 Sandile in the slot previously
  occupied by level 3 Pidgey. Safari Zone East now has level 37 Paras in the
  slot previously occupied by level 35 Sandile.
- Gorochu can now learn HM03 Surf, alongside its existing Fly compatibility.
- Pikachu, Raichu and Gorochu share Pikachu graphics when using Surf or Fly.
  Town Map Fly uses the first compatible Pokémon in your party and requires
  HM02 in your bag and the Thunder Badge.
- Glalie's front and back sprites and Sirfetch'd's back sprite have been
  refreshed in the website's Pokédex.

## Building

Install RGBDS 1.0.1 (see `.rgbds-version`), GNU Make, GCC, and Python 3,
then run from Linux or WSL:

```sh
make
```

Run the project integrity checks after changing game data or banked code:

```sh
make audit
```

The audit validates trainer parties and custom moves, encounters, Pokémon and
move data, sprites, progression gates, toggleable objects, version parity, and
cross-bank calls for all supported builds.

## Website

A browsable guide to the game — Pokédex, moves, wild encounters and locations —
is generated straight from the source data in this repo and served from `docs/`
by GitHub Pages:

<https://lukedaysgrace-dot.github.io/Pokemon-Rage-Blue/>

Sprites are recoloured at build time using each species' actual in-game SGB
palette (`data/pokemon/palettes.asm` + `data/sgb/sgb_palettes.asm`), so the site
shows the same colours the game does rather than the raw greyscale art.
Everything reflects the `_BLUE` build.

To rebuild and publish after changing game data, from WSL:

```sh
./tools/site.sh
```

That regenerates `docs/`, commits it and pushes. Useful variants:

```sh
./tools/site.sh --build            # rebuild only, no git
./tools/site.sh -m "Add Route 9 encounters"
make site                          # same as --build
```

To rebuild only from Windows, with Python 3 and Pillow installed:

```powershell
python tools/site/build_site.py
```

The generator itself is `tools/site/build_site.py` (Python 3 + Pillow) and the
theme is `tools/site/style.css`. Nothing is hand-written in `docs/` — it is
entirely generated output, cleared and rebuilt on every run.

## Upstream resources

The original disassembly's [wiki](https://github.com/pret/pokered/wiki)
remains a useful reference for RGBDS development and project structure.
