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

## Building

Install the prerequisites described in [INSTALL.md](INSTALL.md), then run:

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

A browsable guide to the game — Pokédex, moves, wild encounters, locations and
trainers — is generated straight from the source data in this repo and served
from `docs/` by GitHub Pages:

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

The generator itself is `tools/site/build_site.py` (Python 3 + Pillow) and the
theme is `tools/site/style.css`. Nothing is hand-written in `docs/` — it is
entirely generated output, safe to delete and rebuild.

## Upstream resources

The original disassembly's [wiki](https://github.com/pret/pokered/wiki) and
[installation documentation](INSTALL.md) remain useful references for RGBDS
development and project structure.
