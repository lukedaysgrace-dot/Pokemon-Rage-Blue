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

## Upstream resources

The original disassembly's [wiki](https://github.com/pret/pokered/wiki) and
[installation documentation](INSTALL.md) remain useful references for RGBDS
development and project structure.
