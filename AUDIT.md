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
