# Color modes

Options → COLOR MODE selects `ORIG`, `GBC`, or `SHIN`. Left/right cycles
through the choices. The overworld reloads its palettes when Options closes.
The choice is saved with the existing options byte; existing saves default to
GBC. Text speed, battle settings, and back-sprite selection remain independent.

- **ORIG**: monochrome Game Boy presentation throughout the game. Background
  and object colors follow BGP/OBP shade mappings, including fades and flashes.
- **GBC**: pokered-gbc's overworld palette values, tile assignments, roof
  colors, cave/object palettes, and sprite assignments. Uses the original
  Gen 1 Pokémon palettes and shared trainer palette, with Gen 1 graphics.
  Rage Blue's added species and sprite identities retain their own assignments.
- **SHIN**: Shin's enhanced overworld palettes and tile assignments, including
  town-specific colors, Seafoam's cold palette, and unlit caves. Overworld
  sprites use Shin's OBP0/OBP1 palette selection and shade mappings, including
  white faces, the light red clothing accent, and the original sprite fades.
  Battles retain Rage Blue's Gen 1 Pokémon palettes and existing animation
  rendering.

## Sources and credit

GBC values and original sprite assignments were checked against
[dannye/pokered-gbc](https://github.com/dannye/pokered-gbc/tree/c1a3b6c5a7591472241036d0cf09c3817f841f93),
by FroggestSpirit, Drenn, and dannye. Original sprite identities are matched
by their constants because Rage Blue has inserted additional sprites.

The enhanced palettes, tile assignment tables, and town wildcard data in
`data/shin_palettes.asm` are adapted from `custom_functions/func_enhancedcolor.asm`
in [jojobear13/shinpokered](https://github.com/jojobear13/shinpokered/tree/a7a9b1361e55aaa5afed6b5d14b5e7bd44002179).
Credit goes to jojobear13/joenote and the Shin Pokémon team. Their source
[reuse guidelines](https://github.com/jojobear13/shinpokered/blob/a7a9b1361e55aaa5afed6b5d14b5e7bd44002179/README.md#legal-mumbo-jumbo)
apply to those data. `modes.asm` adapts them to Rage Blue's GBC transfer engine;
it does not import Shin's gamma shader or other gameplay features.

## Validation

Run `make audit` after building all three variants. Optional CPU-level palette,
bank-preservation, monochrome, and SRAM persistence checks use PyBoy:

```sh
python3 tools/test_color_modes.py
python3 tools/test_intro_palettes.py
```

This requires PyBoy and uses disposable ROM copies under `.reference/`.
It does not load or overwrite the player's save files.
The intro checks cover A/B input, preset and custom names, both character
choices, and restoring the version's portrait palette after name entry.
