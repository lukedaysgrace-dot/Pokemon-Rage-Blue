# Code audit — October 13, 2026

## Scope

Full pass over everything that differs from pret/pokered (about 6,000 changed
lines in `engine/` and `home/`, plus the new battle, AI, field-move, Pokémon
data and back-sprite files), using the October 12/13 content audit as the
reference for what had already been covered. Battle turn order, damage and
type maths, Counter, the trainer AI layers, party building and Stat EXP, EXP
bar, hard-mode caps, items, field HMs, toggleable objects, Town Map Fly, Hall
of Fame, trades and the new fossils were all read line by line. A scan of
every `callfar`/`farcall`/`predef` site checked that no caller reads a
register or flag those calls clobber, and every event flag that is checked
is also set somewhere.

## Bugs fixed

| Problem | Correction |
| --- | --- |
| When the player's Pokémon used Transform, it kept its own back sprite. `ChangeMonPic` redraws it through `LoadMonBackPic`, which uses the party species until `TRANSFORMED` is set — and Transform sets that bit only after the animation. | `ChangeMonPic` loads the requested species through the new `LoadMonBackPicOfCurPartySpecies` entry point. |
| Using Strength from the party menu played the cry of the first party member able to learn Strength instead of the Pokémon chosen. The HM-compatibility scan left its last checked species in `wCurPartySpecies`. | `PartyAnyCanLearnMove` saves and restores `wCurPartySpecies`. |
| A Pokémon received in a link trade had its stats recalculated without its Stat EXP, so it showed lower stats until its next level-up or PC deposit. | Recalculate with Stat EXP, like level-ups and the PC do. |
| Leech Seed drain was multiplied by the Toxic counter and advanced it a second time each turn (the original game's Leech Seed/Toxic glitch). | Leech Seed always drains 1/16 and leaves the counter alone. |
| A sleep move used on a Pokémon recharging from Hyper Beam skipped the "already has a status" check, so sleep replaced an existing Burn, Poison, Paralysis or Freeze. | The status check always runs. A recharging target still can't avoid the move, and stops needing to recharge only if it falls asleep. |
| With all nine fossil types in the bag, the fossil menu (Cinnabar Lab and the Cerulean scientist) stopped at eight and left out the Old Amber. | The menu holds every fossil type. Up to eight keep the usual two-row spacing; with nine, it lists one fossil per row so the box still fits on screen. |
| The enemy's Psywave could roll 0 damage while the player's never could. Link partners also consumed different random numbers for the same move. | Both sides roll in the range [1, level × 1.5). |

## New checks

`tools/test_gameplay_regressions.py` (run by `make audit-runtime`) adds six
CPU-level cases per build: the Transform back sprite, the field-move species
being kept, Stat EXP on traded Pokémon, Leech Seed with Toxic, sleep against
recharging and already-statused targets, and the fossil menu with two, eight
and nine fossils. Each one fails on the previous ROMs and passes now.

## Notes, not changed

- Psywave still never ends for a level-1 user (the damage range is empty).
  No Pokémon can know Psywave at level 1, so this can't happen in play.
- `LoadMonPartySpriteGfxWithLCDDisabled` loops forever if the party is
  empty. Every party-menu caller requires at least one Pokémon first.
- If a Metal Claw user's Attack is already 999, the 25% boost prints
  "Nothing happened!".

## Verification

`make` builds all three ROMs; `make audit` and `make audit-runtime` pass.

# Content audit — October 12, 2026

## Scope

Dialogue and text-box layout for all new and changed text, new trainer and
cutscene scripts (Green, Blue, Oak, Petrel, Proton, Ariana, Archer, Exile
Bruno, Elite Four and gym rematches, starter gifts, fossil scientist, bike
shop), trainer headers and party references, overworld sprite sets and
indoor sprite VRAM limits, NPC sprite sheets, Pokémon/icon/trainer graphics,
map headers and connections.

## Bugs fixed

| Problem | Correction |
| --- | --- |
| Blue's Cinnabar Island battle stored its trainer header by hand but never loaded the header's flag bit, so `EndTrainerBattle` set whichever event bit was left over from the previous trainer. | Load the flag bit (`xor a / call ReadTrainerHeaderInfo`) like the Elite Four rematch scripts do. |
| Golett's HD back sprite had its palette stored dark-to-light; `rgbgfx --colors auto` keeps indexed palette order, so the sprite was drawn with inverted shades. | Reordered the PNG palette light-to-dark (pixels unchanged). |
| Ralts, Kirlia, Gardevoir, Leafeon, Whirlipede and Scolipede icons had their two middle colours stored out of order, swapping light/dark in game. | Reordered the PNG palettes light-to-dark (pixels unchanged). |
| Clefairy (Celadon Mansion) and Chansey (Copycat's House) were set to WALK, but their sprite sheets have no walking frames, so they flickered garbage tiles while moving. | Changed both to STAY with the same axis, so they turn in place. |
| Silph Co. 1F (Petrel) and 3F (Proton) called `HideObject` every frame once the admin was gone, rewriting the toggle flag and redrawing all sprites on every step. | Hide only when the object is still visible. |
| After losing to Exile Bruno he stayed visible, and talking to him replayed his speech without starting the battle. | Hide him again when the player is off the trigger tile, so the trigger restarts the encounter. |
| Nine dialogue lines overflowed the 18-tile text box (HM prompt, "Climb onto dry land?", Karen/Lorelei rematch, Erika rematch, Vermilion Gym soldier, Blue's placeholder lose text). | Re-wrapped to fit; replaced the "(Placeholder)" text. |
| Typos and punctuation in new dialogue (Janine, Cerulean fossil scientist, Proton, Archer, Karen, Lance, Exile Bruno, Green, Rocket Hideout grunts, Vermilion Gym soldiers, rematch trainer). | Corrected capitalisation, apostrophes, ellipses and run-ons, and replaced a Vermilion Gym soldier's truncated "S!" with "Sir! Yes, sir!". |

## Follow-up pass (October 13)

Line-by-line review of the remaining new scripts: Oak's Lab, Bruno/Karen,
Agatha, Lance, Indigo Plateau, every gym rematch including Giovanni, Route 13
Mew, Hall of Fame, Day Care, Celadon Mart 5F, Rock Tunnel, Seafoam boulders,
Silph Co. floors, the Viridian Mart fisher and the other small script changes.
Starter-line teams for every Green, Blue and rival battle were matched against
the scripts that pick them, and the trainer level curve was rechecked. Every
new cutscene walking path was traced tile by tile against the map collision
data.

| Problem | Correction |
| --- | --- |
| After the Pallet Town finale, if the player stood to Green's left, she walked straight up through the fence at (4, 9). | That case now takes the same open route as the others (right, then up). |
| In Oak's Lab, when Green took Charmander's ball she disappeared one tile short of the door, unlike the other two routes. | Added the missing step so she leaves from the door mat. |
| Red: every Hall of Fame entry re-showed the Route 24 Charmander, Cerulean Bulbasaur and Vermilion Squirtle sprites, even after the player had received them. | Only re-show a gift Pokémon if it hasn't been given yet. |
| Cinnabar Island (Blue's final battle) and Viridian Gym (Giovanni rematch) called `ShowObject` every frame while waiting, redrawing every sprite on each step. | Show the object only if it is still hidden. |

## New checks

`tools/audit_content.py` (run by `make audit`) catches each class of problem
above: text-box width, indexed-palette shade order, WALK objects using sheets
without walking frames, indoor sprite VRAM limits, and scripted trainer
battles that skip loading the header flag bit, and map-script helpers that
show/hide an object on every frame without checking it first.

## Notes, not changed

- Lose texts passed to `SaveEndBattleTextPointers` (for example Green's "Come
  back when you're ready.") are never shown: the battle engine only prints
  end-of-battle text when the player wins, as in the original game.
- `Route1`, `Route5`, `IndigoPlateau` and `IndigoPlateauLobby` keep their
  cutscene state in the shared `wCurMapScript` byte instead of a per-map
  variable. It works because other maps leave it at 0, but it is fragile.
- Red, Mt. Moon B2F: when the Super Nerd walks over to warn about the
  fossils he stops one tile diagonally from the player instead of next to
  them. It only affects how the scene looks.
- Mansion B1F still defines toggles for a removed Mew/Poké Ball cutscene;
  they are harmless, and removing them would shift every later toggle index
  in existing saves.

## Verification

`make` builds all three ROMs; `make audit` and `make audit-runtime` pass.

# Code audit — October 11, 2026

## Scope

Repository-wide build and integrity checks, plus manual review of battle
calculations and effects, trainer AI and party loading, expanded species/move
indexing, evolution and experience, inventory and field moves, save handling,
progression gates, and map/event data. Existing color and intro changes were
preserved.

## Bugs fixed

| Problem | Correction |
| --- | --- |
| Scaling a high Attack against Defense below four could produce a zero divisor and freeze battle damage calculation. | Both scaled stats now have a minimum of one. |
| Reflect/Light Screen could push defensive stats beyond the range supported by one scaling pass, wrapping the defense byte and producing incorrect damage. | Continue scaling both stats until both fit in a byte. |
| Critical hits reconstructed enemy stats without hard-mode Stat EXP. | Use the battle's stored unmodified stats. |
| Critical hits used original party/species stats after Transform, rather than the copied stats. | Use the unmodified stats updated by Transform for both battlers. |
| Critical hits could still be reduced by Reflect/Light Screen when the defender had a lowered stat stage. | Bypass screens independently of defensive stat stages. |
| Metronome/Mirror Move could increase original party PP while the user was transformed. | Only compensate the copied battle PP when transformed. |
| Experience-based level calculation could return levels above 100 for excess experience, including accumulated daycare experience. | Stop the level search at `MAX_LEVEL`. |
| Stat-changing moves repeatedly reapplied Burn/Paralysis to already reduced stats, even when changing an unrelated stat. | Rebuild the affected battler's stats and apply each status penalty once. |
| Haze restored the user's full Attack/Speed while leaving its Burn/Paralysis status active. | Preserve the user's status penalty after resetting stages; retain the game's existing target-only status cure. |
| The north–south Underground Path declared 96 blocks but supplied only 92, causing map loading to read into the next map's data. | Match the header to the actual 4×23 map. Warps and hidden items remain within bounds. |

## Verification

All checks below passed on the final rebuilt ROMs.

- `make -j4 audit audit-runtime` builds Red, Blue, and Blue Debug and runs both audit targets.
- Existing data checks cover 446 Red trainer parties and 447 Blue trainer parties, custom moves, encounters, species/move tables, sprites, toggleable objects, and progression gates.
- New geometry checks cover 222 maps and 804 warp records per version, including shared map graphics and reviewed dynamic elevator exits.
- Bank-transfer checks run against symbols from all three builds.
- New CPU-level gameplay regressions exercise 160 cases per build: physical/special damage, both battlers, screens, critical stat stages, transformed PP, experience limits, stat/status interactions, and Haze.
- Existing emulator checks cover color modes, palette buffers, fades, save/load, new-game portraits, both genders, and preset/custom naming paths.
- Emulator regressions use disposable ROM copies and do not load player saves. Arithmetic/effect tests stub presentation routines; intro tests exercise real button input.

## Limits

This is a code and integrity audit with targeted emulator coverage, not a full
story/postgame playthrough or a physical Game Boy Color/link-cable test. Passing
checks do not guarantee that every possible gameplay sequence is bug-free.

## Repeat the checks

```sh
make audit
make audit-runtime  # requires PyBoy
```

Fixes are left in the working tree for review; rebuilt development ROMs are
available at the repository root.
