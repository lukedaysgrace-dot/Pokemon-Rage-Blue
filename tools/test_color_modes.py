"""Run CPU-level color-mode and SRAM regression checks on disposable ROM copies.

Requires PyBoy. Build all three ROMs first. Player saves are never used.
"""
from pathlib import Path
import os
from pyboy import PyBoy
import shutil

def symbols(path):
    out = {}
    for line in Path(path).read_text().splitlines():
        if line.startswith(';') or not line:
            continue
        parts = line.split()
        if len(parts) == 2 and ':' in parts[0]:
            bank, addr = parts[0].split(':')
            out[parts[1]] = (int(bank, 16), int(addr, 16))
    return out
os.chdir(Path(__file__).resolve().parents[1])
Path('.reference').mkdir(exist_ok=True)
for rom in ('pokered', 'pokeblue', 'pokeblue_debug'):
    s = symbols(rom + '.sym')
    dest = '.reference/runtime_' + rom + '.gbc'
    shutil.copyfile(rom + '.gbc', dest)
    p = PyBoy(dest, window='null', sound_emulated=False)
    p.set_emulation_speed(0)
    p.tick(100)

    def setvar(name, value):
        p.memory[s[name][1]] = value

    def data(name, size):
        bank, addr = s[name]
        return p.memory[bank, addr:addr + size]

    def call(name, wram_bank=0, **regs):
        bank, addr = s[name]
        p.memory[0, 256:261] = [205, addr & 255, addr >> 8, 24, 254]
        p.memory[65535] = 0
        p.memory[65344] = 0
        p.memory[65392] = wram_bank
        p.memory[8192] = bank
        setvar('hLoadedROMBank', bank)
        r = p.register_file
        r.PC = 256
        r.SP = 0xDFFF
        for k, v in regs.items():
            setattr(r, k, v)
        p.tick(30 if name in ('SaveMainData', 'LoadMainData') else 2, render=False)
        assert r.PC in (259, 260), (rom, name, hex(r.PC))
        assert r.SP == 0xDFFF, (name, hex(r.SP))
        # Keep subsequent setvar calls on the game's main WRAM bank.
        p.memory[65392] = 0
    for mode, cursor in ((0, 10), (8, 1), (16, 14)):
        for flags in (0, 32, 64, 128, 224):
            setvar('wOptions', 3 | mode | flags)
            call('SetCursorPositionsFromOptions')
            assert p.memory[s['wOptionsColorModeCursorX'][1]] == cursor
            call('SetOptionsFromCursorPositions')
            assert p.memory[s['wOptions'][1]] == 3 | mode | flags
    for mode, sprite_id, flags, expected in ((0, 1, 0, 0), (0, 2, 0, 1), (0, 22, 0, 2), (16, 2, 0, 0), (16, 2, 16, 20)):
        setvar('wOptions', mode)
        setvar('hSpriteOffset2', 0)
        p.memory[0xc100] = sprite_id
        call('ColorOverworldSprite', A=flags, D=0xc8, E=0, HL=0xc810)
        assert p.memory[0xc800] == expected, (mode, sprite_id, flags)
    setvar('wOptions', 0)
    call('DeterminePaletteID', A=153)
    assert p.register_file.A == 22
    call('DetermineBackSpritePaletteID', A=153)
    assert p.register_file.A == 22
    call('DeterminePaletteID', A=170)
    assert p.register_file.A == 25
    call('DeterminePaletteID', A=0)
    assert p.register_file.A == 16
    # Exercise the existing map loader using the real banked stack too.
    for mode in (0, 8):
        for tileset in range(24):
            setvar('wOptions', mode)
            setvar('wCurMapTileset', tileset)
            setvar('wCurMap', 0)
            call('LoadTilesetPalette', B=18, C=52, D=86, E=120, HL=51336)
            assert (p.register_file.B, p.register_file.C, p.register_file.D, p.register_file.E, p.register_file.HL) == (18, 52, 86, 120, 51336), (mode, tileset)
    for tileset in range(24):
        for mapid, dark, palette in [(0, 0, 'ShinGBCEnhancedOverworldPalettes'), (10, 0, 'ShinGBCEnhancedOverworldPalettes'), (12, 0, 'ShinGBCEnhancedOverworldPalettes'), (192, 0, 'ShinGBCEnhancedOverworldPalettes_ColdCavern'), (159, 0, 'ShinGBCEnhancedOverworldPalettes_ColdCavern'), (82, 6, 'ShinGBCEnhancedOverworldPalettes_DarkCavern')]:
            setvar('wOptions', 16)
            setvar('wCurMapTileset', tileset)
            setvar('wCurMap', mapid)
            setvar('wMapPalOffset', dark)
            call('LoadTilesetPalette', B=18, C=52, D=86, E=120, HL=51336)
            assert p.memory[2, 53248:53312] == data(palette, 64), (rom, tileset, mapid)
            assert (p.register_file.B, p.register_file.C, p.register_file.D, p.register_file.E, p.register_file.HL) == (18, 52, 86, 120, 51336)
            pointers = data('ShinOverworldTilePalPointers', 48)
            addr = pointers[tileset * 2] + pointers[tileset * 2 + 1] * 256
            source = p.memory[68, addr:addr + 96]
            town = data('ShinPalSettings_TownSpecialPal', 11)[mapid] if mapid <= 10 else 6
            assert p.memory[2, 53760:53856] == [town if x == 8 else x for x in source]
            assert p.memory[2, 53856:54016] == [3] * 160
            call('LoadOverworldSpritePalettes')
            assert p.memory[2, 53312:53376] == data(palette, 64)
    # Compare the final object buffer to Shin's home/fade.asm, rather than
    # merely checking that its unprocessed RGB palette data was copied.
    setvar('wOptions', 16)
    setvar('wCurMap', 0)
    setvar('wMapPalOffset', 0)
    call('LoadTilesetPalette')
    call('LoadOverworldSpritePalettes')
    raw = data('ShinGBCEnhancedOverworldPalettes', 64)
    # Shared Rage Blue pattern, Shin OBP0, Shin OBP1 (FadePal1..8).
    fades = [(0xff, 0xff, 0xff), (0xfe, 0xfe, 0xf8),
             (0xf9, 0xe4, 0xe4), (0xe4, 0xd0, 0xe0),
             (0xe4, 0xd0, 0xe0), (0x90, 0x80, 0x90),
             (0x40, 0x40, 0x40), (0, 0, 0)]
    def mapped_colors(palettes, patterns):
        return [byte for slot in range(8) for color in range(4)
                for byte in palettes[slot * 8 + ((patterns[slot] >> (color * 2)) & 3) * 2:
                                     slot * 8 + ((patterns[slot] >> (color * 2)) & 3) * 2 + 2]]
    for current, obp0, obp1 in fades:
        p.memory[0xff47] = current
        p.memory[0xff48] = current
        p.memory[0xff49] = current
        p.memory[2, 0xd788:0xd78a] = [1, 1]
        p.memory[2, 0xd703] = 1
        call('RefreshPalettesPreVBlank', wram_bank=2)
        assert p.memory[2, 0xd744:0xd784] == mapped_colors(raw, [obp0] * 4 + [obp1] * 4), (rom, hex(current), 'Shin sprite fade')
        bg_expected = ([0] * 64 if current == 0xff else [0xff] * 64
                       if current == 0 else mapped_colors(raw, [current] * 8))
        assert p.memory[2, 0xd704:0xd744] == bg_expected, (rom, hex(current), 'background unchanged')
    # Menu/battle palette loaders must turn off the overworld shade adapter.
    call('LoadSGBPalette_Sprite', D=16, E=0)
    assert p.memory[2, 0xd08c] == 0
    for mode in (0, 8):
        setvar('wOptions', mode)
        call('LoadTilesetPalette')
        call('LoadOverworldSpritePalettes')
        assert p.memory[2, 0xd08c] == 0
        sprite_raw = p.memory[2, 0xd040:0xd080]
        p.memory[0xff48] = 0xe4
        p.memory[0xff49] = 0xe4
        p.memory[2, 0xd789] = 1
        call('RefreshPalettesPreVBlank', wram_bank=2)
        expected = sprite_raw if mode == 0 else data('MonochromePalette', 8) * 8
        assert p.memory[2, 0xd744:0xd784] == expected, (rom, mode, 'original/GBC unchanged')
    for index in range(4):
        bank, addr = s['SetColor']
        p.memory[65535] = 0
        p.memory[65344] = 0
        p.memory[8192] = bank
        setvar('hLoadedROMBank', bank)
        p.memory[2, 53387] = 8
        r = p.register_file
        r.PC = 256
        r.SP = 0xDFFF
        r.A = index
        r.B = 8
        r.HL = 51200
        p.memory[0, 256:267] = [62, 2, 224, 112, 62, index, 205, addr & 255, addr >> 8, 24, 254]
        p.tick(1, render=False)
        assert p.memory[51200:51202] == data('MonochromePalette', 8)[index * 2:index * 2 + 2]
    p.memory[65392] = 0
    for mode in (0, 8, 16):
        setvar('wOptions', 3 | mode)
        call('SaveMainData')
        setvar('wOptions', 3)
        call('LoadMainData')
        assert p.memory[s['wOptions'][1]] == 3 | mode
    p.stop(save=False)
    print(rom + ': Gen 1 palettes, 144 Shin map cases, Shin sprite shades/fades, original/GBC buffers, monochrome, save/load PASS')
