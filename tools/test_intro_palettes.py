"""Check new-game intro colors through A/B input and both naming paths.

Requires PyBoy and built Red/Blue ROMs. Uses disposable copies without saves.
"""
from pathlib import Path
import os
import shutil

from pyboy import PyBoy


def read_symbols(path):
    result = {}
    for line in Path(path).read_text().splitlines():
        fields = line.split()
        if len(fields) == 2 and ':' in fields[0] and not line.startswith(';'):
            bank, address = fields[0].split(':')
            result[fields[1]] = (int(bank, 16), int(address, 16))
    return result


os.chdir(Path(__file__).resolve().parents[1])
Path('.reference').mkdir(exist_ok=True)
portrait_texts = ('OakSpeechText1', 'OakSpeechText2', 'IntroducePlayerText',
                  'YourNameIsText', 'IntroduceRivalText', 'HisNameIsText',
                  'OakSpeechText3')
for rom in ('pokered', 'pokeblue'):
    symbols = read_symbols(rom + '.sym')
    palette_id = 19 if rom == 'pokeblue' else 18  # PAL_CYANMON / PAL_REDMON
    source_bank, source_address = symbols['SuperPalettes']
    for mode in (0, 8, 16):
        for custom in (False, True):
            # Exercise the girl choice alongside custom names.
            gender = int(custom)
            dest = f'.reference/intro_{rom}_{mode}_{custom}.gbc'
            shutil.copyfile(rom + '.gbc', dest)
            p = PyBoy(dest, window='null', sound_emulated=False)
            p.set_emulation_speed(0)
            stage = ['boot']
            seen = set()
            failures = []
            lists = [0]
            keyboards = [0]
            expected = p.memory[source_bank, source_address + palette_id * 8:
                                source_address + palette_id * 8 + 8]

            def enter_stage(name):
                stage[0] = name

            def name_list(_):
                lists[0] += 1
                stage[0] = 'name list'

            def keyboard(_):
                keyboards[0] += 1
                stage[0] = 'keyboard'

            text_addresses = {symbols[name][1]: name for name in portrait_texts}

            def text_hook(_):
                name = text_addresses.get(p.register_file.HL)
                if name is None or p.memory[symbols['hLoadedROMBank'][1]] != 1:
                    return
                # PyBoy hook callbacks swallow exceptions; report them after tick.
                if p.memory[2, 0xd000:0xd008] != expected:
                    failures.append((rom, mode, custom, name, 'intro color changed'))
                seen.add(name)
                stage[0] = name

            p.hook_register(*symbols['PrintText'], text_hook, None)
            p.hook_register(*symbols['BoyGirlChoice'], enter_stage, 'gender choice')
            p.hook_register(*symbols['DisplayIntroNameTextBox'], name_list, None)
            p.hook_register(*symbols['DisplayNamingScreen.inputLoop'], keyboard, None)

            def press(key, after=70):
                p.button_press(key)
                p.tick(8)
                p.button_release(key)
                p.tick(after)
                assert not failures, failures[0]

            p.tick(1600)
            press('start', 120)
            p.memory[symbols['wOptions'][1]] = 3 | mode
            p.memory[symbols['wOptionsInitialized'][1]] = 1
            p.memory[2, 0xd08b] = mode
            press('a', 100)
            for step in range(120):
                if p.memory[symbols['wDefaultPaletteCommand'][1]] == 9:
                    break
                if stage[0] == 'name list':
                    before = p.memory[2, 0xd000:0xd008]
                    press('b')
                    assert p.memory[2, 0xd000:0xd008] == before, (rom, mode, 'B on name list')
                    if not custom:
                        press('down')
                    press('a')
                elif stage[0] == 'keyboard':
                    press('a')
                    press('b')  # delete a letter, then submit a valid name
                    press('a')
                    press('start')
                elif stage[0] == 'gender choice':
                    if gender:
                        press('down')
                    press('a')
                else:
                    # Advance all portrait dialogue with B, including the rival.
                    press('b' if stage[0] in portrait_texts else 'a')
            else:
                raise AssertionError((rom, mode, custom, stage[0], 'intro did not finish'))
            assert seen == set(portrait_texts), (rom, mode, custom, seen)
            assert lists[0] == 2 and bool(keyboards[0]) == custom
            assert p.memory[symbols['wPlayerGender'][1]] == gender
            assert p.memory[symbols['wOptions'][1]] & 24 == mode
            p.stop(save=False)
    print(rom + ': intro portraits, B dialogue/name selection, custom-name deletion/return, both genders, all color modes PASS')
