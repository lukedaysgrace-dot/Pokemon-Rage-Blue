"""CPU-level gameplay regressions for all three builds (requires PyBoy).

Use temporary ROM copies without player saves. Presentation routines are
stubbed only where a test exercises arithmetic rather than interactive UI.
"""

from pathlib import Path
import shutil
import tempfile

from pyboy import PyBoy


ROOT = Path(__file__).resolve().parents[1]


class Game:
    def __init__(self, rom, directory):
        self.symbols = {}
        for line in (ROOT / f"{rom}.sym").read_text().splitlines():
            fields = line.split()
            if len(fields) == 2 and ":" in fields[0] and not line.startswith(";"):
                bank, address = fields[0].split(":")
                self.symbols[fields[1]] = (int(bank, 16), int(address, 16))
        path = Path(directory) / f"{rom}.gbc"
        shutil.copyfile(ROOT / f"{rom}.gbc", path)
        self.p = PyBoy(str(path), window="null", sound_emulated=False)
        self.p.set_emulation_speed(0)
        self.p.tick(100, render=False)

    def address(self, name):
        return self.symbols[name][1]

    def set(self, name, value):
        self.p.memory[self.address(name)] = value

    def get(self, name):
        return self.p.memory[self.address(name)]

    def word(self, name, value):
        address = self.address(name)
        self.p.memory[address:address + 2] = [value >> 8, value & 255]

    def call(self, name, frames=None, **registers):
        bank, address = self.symbols[name]
        # CALL routine; JR to itself. No interrupts or LCD-dependent waits.
        self.p.memory[0, 0x100:0x105] = [0xCD, address & 255, address >> 8, 0x18, 0xFE]
        self.p.memory[0xFFFF] = 0
        self.p.memory[0xFF40] = 0
        self.p.memory[0xFF70] = 0
        self.p.memory[0x2000] = bank
        self.set("hLoadedROMBank", bank)
        r = self.p.register_file
        r.PC, r.SP = 0x100, 0xDFFF
        for key, value in registers.items():
            setattr(r, key, value)
        if frames is None:
            frames = 30 if name == "CalcLevelFromExperience" else 3
        self.p.tick(frames, render=False)
        assert r.PC in (0x103, 0x104), f"{name} did not return: PC={r.PC:04x}"
        assert r.SP == 0xDFFF, f"{name} left an unbalanced stack"
        return r

    def stub(self, name):
        bank, address = self.symbols[name]
        self.p.memory[bank, address] = 0xC9  # RET


def scaled_stats(attack, defense):
    while attack > 255 or defense > 255:
        attack //= 4
        defense //= 4
    return max(1, attack), max(1, defense)


def damage_stats(game):
    for turn in (0, 1):
        attacker, defender = ("Player", "Enemy") if turn == 0 else ("Enemy", "Player")
        attack_struct = "wBattleMon" if turn == 0 else "wEnemyMon"
        defense_struct = "wEnemyMon" if turn == 0 else "wBattleMon"
        for special in (False, True):
            attack_stat = "Special" if special else "Attack"
            defense_stat = "Special" if special else "Defense"
            for screen in (False, True):
                for attack, defense in ((120, 80), (512, 3), (3, 512), (999, 999), (240, 600), (100, 512)):
                    game.set("hWhoseTurn", turn)
                    game.set(f"w{attacker}MovePower", 60)
                    game.set(f"w{attacker}MoveType", 20 if special else 0)
                    game.set(f"w{attacker}MoveEffect", 0)
                    game.set("wCriticalHitOrOHKO", 0)
                    game.set(f"w{defender}BattleStatus3", (2 if special else 4) if screen else 0)
                    game.word(attack_struct + attack_stat, attack)
                    game.word(defense_struct + defense_stat, defense)
                    game.set(attack_struct + "Level", 50)
                    r = game.call(f"GetDamageVarsFor{attacker}Attack")
                    expected = scaled_stats(attack, defense * (2 if screen else 1))
                    assert (r.B, r.C, r.D, r.E) == (*expected, 60, 50), (turn, special, screen, attack, defense, r.B, r.C, expected)
                    # This used to hang when the scaled defense became zero.
                    game.call("CalculateDamage", B=r.B, C=r.C, D=r.D, E=r.E)


def critical_stats(game):
    for turn in (0, 1):
        attacker, defender = ("Player", "Enemy") if turn == 0 else ("Enemy", "Player")
        attack_struct = "wBattleMon" if turn == 0 else "wEnemyMon"
        defense_struct = "wEnemyMon" if turn == 0 else "wBattleMon"
        for special in (False, True):
            attack_stat = "Special" if special else "Attack"
            defense_stat = "Special" if special else "Defense"
            for attack_stage in (6, 7, 8):
                for defense_stage in (6, 7, 8):
                    game.set("hWhoseTurn", turn)
                    game.set(f"w{attacker}MovePower", 60)
                    game.set(f"w{attacker}MoveType", 20 if special else 0)
                    game.set("wCriticalHitOrOHKO", 1)
                    game.set(f"w{attacker}BattleStatus3", 8)  # transformed
                    game.set(f"w{defender}BattleStatus3", 8 | (2 if special else 4))
                    game.set(f"w{attacker}Mon{attack_stat}Mod", attack_stage)
                    game.set(f"w{defender}Mon{defense_stat}Mod", defense_stage)
                    game.word(f"w{attacker}MonUnmodified{attack_stat}", 180)
                    game.word(f"w{defender}MonUnmodified{defense_stat}", 210)
                    game.word(attack_struct + attack_stat, 90 if attack_stage < 7 else 360)
                    game.word(defense_struct + defense_stat, 105 if defense_stage < 7 else 420)
                    game.word("wPartyMon1" + attack_stat, 50)
                    game.word("wPartyMon1" + defense_stat, 50)
                    game.set("wPlayerMonNumber", 0)
                    game.set("wEnemyMonSpecies", 153)  # Bulbasaur; distinct from copied stats
                    game.set("wEnemyMonLevel", 50)
                    game.set("wEnemyMonDVs", 255)
                    game.p.memory[game.address("wEnemyMonDVs") + 1] = 255
                    r = game.call(f"GetDamageVarsFor{attacker}Attack")
                    expected = scaled_stats(360 if attack_stage >= 8 else 180, 105 if defense_stage < 7 else 210)
                    assert (r.B, r.C, r.D, r.E) == (*expected, 60, 100), (turn, special, attack_stage, defense_stage, r.B, r.C, expected)


def transformed_pp(game):
    for transformed in (False, True):
        for slot in range(4):
            game.set("hWhoseTurn", 0)
            game.set("wPlayerBattleStatus1", 0)
            game.set("wPlayerBattleStatus2", 0)
            game.set("wPlayerBattleStatus3", 8 if transformed else 0)
            game.set("wPlayerMonNumber", 2)
            game.set("wPlayerMoveListIndex", slot)
            game.set("wPlayerSelectedMove", 33)  # Tackle
            party = game.address("wPartyMon3PP") + slot
            battle = game.address("wBattleMonPP") + slot
            game.p.memory[party] = 10
            game.p.memory[battle] = 4
            game.call("IncrementMovePP")
            selected = game.address("wPlayerSelectedMove")
            game.call("DecrementPP", D=selected >> 8, E=selected & 255)
            assert game.p.memory[battle] == 4
            assert game.p.memory[party] == 10, (transformed, slot, game.p.memory[party])


def experience_levels(game):
    # Every growth curve at its maximum, above it, and below level two.
    for species in (153, 5, 1, 21):  # medium slow, medium fast, slow, fast
        game.set("wCurSpecies", species)
        game.call("GetMonHeader")
        game.call("CalcExperience", D=100)
        address = game.address("hExperience")
        maximum = int.from_bytes(bytes(game.p.memory[address:address + 3]), "big")
        for exp, expected in ((0, 1), (maximum, 100), (maximum + 100000, 100), (0x500000, 100)):
            game.set("wLoadedMonSpecies", species)
            address = game.address("wLoadedMonExp")
            game.p.memory[address:address + 3] = [(exp >> 16) & 255, (exp >> 8) & 255, exp & 255]
            r = game.call("CalcLevelFromExperience")
            assert r.D == expected, (species, exp, r.D, expected)


def status_penalties(game):
    for routine in ("PrintText", "PrintStatText", "PlayCurrentMoveAnimation", "PlayCurrentMoveAnimation2"):
        game.stub(routine)
    for turn in (0, 1):
        for up in (False, True):
            target = turn if up else 1 - turn
            side = "Player" if target == 0 else "Enemy"
            battler = "wBattleMon" if target == 0 else "wEnemyMon"
            move_side = "Player" if turn == 0 else "Enemy"
            for status in (16, 64):  # Burn, Paralysis
                for index in range(6):
                    game.set("hWhoseTurn", turn)
                    game.set("wLinkState", 4)  # avoid the offline AI's random stat-down failure
                    game.set("wMoveMissed", 0)
                    game.set("wPlayerBattleStatus1", 0)
                    game.set("wEnemyBattleStatus1", 0)
                    game.set("wPlayerBattleStatus2", 0)
                    game.set("wEnemyBattleStatus2", 0)
                    game.set("wPlayerMoveNum", 0)
                    game.set("wEnemyMoveNum", 0)
                    game.set("wPlayerMoveAccuracy", 255)
                    game.set("wEnemyMoveAccuracy", 255)
                    game.set(f"w{move_side}MoveEffect", (10 if up else 18) + index)
                    game.set("wBattleMonStatus", status)
                    game.set("wEnemyMonStatus", status)
                    for name, struct in (("Player", "wBattleMon"), ("Enemy", "wEnemyMon")):
                        for stat in ("Attack", "Defense", "Speed", "Special", "Accuracy", "Evasion"):
                            game.set(f"w{name}Mon{stat}Mod", 7)
                        for stat in ("Attack", "Defense", "Speed", "Special"):
                            game.word(f"w{name}MonUnmodified{stat}", 160)
                            game.word(struct + stat, 80 if status == 16 and stat == "Attack" else 40 if status == 64 and stat == "Speed" else 160)
                    game.call("StatModifierUpEffect" if up else "StatModifierDownEffect")
                    for number, stat in enumerate(("Attack", "Defense", "Speed", "Special")):
                        expected = (240 if up else 105) if number == index else 160
                        if status == 16 and stat == "Attack":
                            expected = max(1, expected // 2)
                        if status == 64 and stat == "Speed":
                            expected = max(1, expected // 4)
                        address = game.address(battler + stat)
                        actual = int.from_bytes(bytes(game.p.memory[address:address + 2]), "big")
                        assert actual == expected, (turn, up, status, index, stat, actual, expected)
                    assert game.get("hWhoseTurn") == turn


def haze_status(game):
    for turn in (0, 1):
        user = "wBattleMon" if turn == 0 else "wEnemyMon"
        target = "wEnemyMon" if turn == 0 else "wBattleMon"
        for status in (16, 64):
            game.set("hWhoseTurn", turn)
            for side, struct in (("Player", "wBattleMon"), ("Enemy", "wEnemyMon")):
                game.set(struct + "Status", status)
                game.set(f"w{side}BattleStatus1", 0)
                game.set(f"w{side}BattleStatus2", 0)
                game.set(f"w{side}BattleStatus3", 8)
                for stat in ("Attack", "Defense", "Speed", "Special", "Accuracy", "Evasion"):
                    game.set(f"w{side}Mon{stat}Mod", 8)
                for stat in ("Attack", "Defense", "Speed", "Special"):
                    game.word(f"w{side}MonUnmodified{stat}", 160)
                    game.word(struct + stat, 240)
            game.call("HazeEffect_")
            assert game.get(user + "Status") == status
            assert game.get(target + "Status") == 0
            for struct in (user, target):
                for stat in ("Attack", "Defense", "Speed", "Special"):
                    expected = 80 if struct == user and status == 16 and stat == "Attack" else 40 if struct == user and status == 64 and stat == "Speed" else 160
                    address = game.address(struct + stat)
                    actual = int.from_bytes(bytes(game.p.memory[address:address + 2]), "big")
                    assert actual == expected, (turn, status, struct, stat, actual, expected)
            assert game.get("hWhoseTurn") == turn


def constant(path, name):
    """Value of a const_def/const enumeration entry."""
    value = None
    for line in (ROOT / path).read_text().splitlines():
        line = line.split(";")[0].strip()
        if line.startswith("const_def"):
            value = 0
        elif line.startswith("const ") and value is not None:
            if line.split()[1] == name:
                return value
            value += 1
        elif line.startswith("const_skip") and value is not None:
            parts = line.split()
            value += int(parts[1]) if len(parts) > 1 else 1
        elif line.startswith("const_next") and value is not None:
            value = int(line.split()[1].replace("$", "0x"), 0)
    raise KeyError(name)


def species(name):
    return constant("constants/pokemon_constants.asm", name)


def word_at(game, name):
    address = game.address(name)
    return int.from_bytes(bytes(game.p.memory[address:address + 2]), "big")


def leech_seed_toxic(game):
    game.stub("UpdateCurMonHPBar")
    for turn in (0, 1):
        side = "Player" if turn == 0 else "Enemy"
        struct = "wBattleMon" if turn == 0 else "wEnemyMon"
        for leech_seed in (True, False):
            game.set("hWhoseTurn", turn)
            game.word(struct + "MaxHP", 160)
            game.word(struct + "HP", 160)
            game.set(f"w{side}BattleStatus3", 1)  # BADLY_POISONED
            game.set(f"w{side}ToxicCounter", 3)
            hp = game.address(struct + "HP")
            r = game.call("HandlePoisonBurnLeechSeed_DecreaseOwnHP", HL=hp, F=0x10 if leech_seed else 0)
            damage = 10 if leech_seed else 40  # Leech Seed ignores the Toxic counter
            assert word_at(game, struct + "HP") == 160 - damage, (turn, leech_seed, word_at(game, struct + "HP"))
            assert (r.B << 8 | r.C) == damage, (turn, leech_seed, r.B, r.C)
            assert game.get(f"w{side}ToxicCounter") == (3 if leech_seed else 4), (turn, leech_seed)


def sleep_recharge(game):
    for routine in ("PrintText", "PlayCurrentMoveAnimation2", "PrintDidntAffectText", "MoveHitTest"):
        game.stub(routine)
    for turn in (0, 1):
        side = "Enemy" if turn == 0 else "Player"
        status = "wEnemyMonStatus" if turn == 0 else "wBattleMonStatus"
        for recharging in (False, True):
            for old_status in (0, 1 << 3, 1 << 4, 1 << 5, 1 << 6):  # none, PSN, BRN, FRZ, PAR
                game.set("hWhoseTurn", turn)
                game.set("wMoveMissed", 0)
                game.set(status, old_status)
                game.set(f"w{side}BattleStatus2", 1 << 5 if recharging else 0)  # NEEDS_TO_RECHARGE
                game.call("SleepEffect")
                if old_status:
                    # an existing status is never replaced, recharging or not
                    assert game.get(status) == old_status, (turn, recharging, old_status, game.get(status))
                    assert game.get(f"w{side}BattleStatus2") == (1 << 5 if recharging else 0)
                else:
                    assert 1 <= game.get(status) <= 7, (turn, recharging, game.get(status))
                    assert game.get(f"w{side}BattleStatus2") == 0, (turn, recharging)


def fossil_menu(game):
    # The Cinnabar Lab / Cerulean fossil menu lists every fossil type, the
    # Old Amber included, switching to one row per fossil when nine are held.
    for routine in ("SaveScreenTilesToBuffer2", "LoadScreenTilesFromBuffer2", "UpdateSprites", "PrintText"):
        game.stub(routine)
    bank, address = game.symbols["HandleMenuInput"]
    game.p.memory[bank, address:address + 3] = [0x3E, 0x02, 0xC9]  # ld a, PAD_B; ret (cancel)
    fossils = ["DOME_FOSSIL", "HELIX_FOSSIL", "SKULL_FOSSIL", "ARMOR_FOSSIL", "CLAW_FOSSIL",
               "ROOT_FOSSIL", "JAW_FOSSIL", "SAIL_FOSSIL", "OLD_AMBER"]
    for count in (9, 8, 2):
        held = fossils if count == 9 else fossils[:count]
        bag = game.address("wNumBagItems")
        data = [count]
        for name in held:
            data += [constant("constants/item_constants.asm", name), 1]
        game.p.memory[bag:bag + len(data) + 1] = data + [0xFF]
        game.call("Lab4Script_GetFossilsInBag", frames=10)
        filtered = game.address("wFilteredBagItems")
        assert game.get("wFilteredBagItemsCount") == count, (count, game.get("wFilteredBagItemsCount"))
        assert game.p.memory[filtered + count] == 0xFF
        assert game.p.memory[filtered + count - 1] == constant("constants/item_constants.asm", held[-1])
        tilemap = game.address("wTileMap")
        game.p.memory[tilemap:tilemap + 20 * 18] = [0x7F] * (20 * 18)
        game.set("hUILayoutFlags", 0)
        game.call("GiveFossilToCinnabarLab", frames=60)
        spacing = 1 if count > 8 else 2
        bottom = 2 + (count - 1) * spacing + 1  # the box's bottom border row
        assert bottom < 18, count
        for index in range(count):
            assert game.p.memory[tilemap + (2 + index * spacing) * 20 + 2] != 0x7F, (count, index)
        assert game.p.memory[tilemap + bottom * 20 + 1] != 0x7F, (count, "bottom border")
        assert game.get("hUILayoutFlags") == 0, "menu spacing flag left set"


def transform_back_pic(game):
    # Transform redraws the player's mon before TRANSFORMED is set; the new
    # back sprite must be the target's species, not the party species.
    for routine in ("GetMonHeader", "ClearScreenArea", "UncompressMonSprite", "ScaleSpriteByTwo",
                    "InterlaceMergeSpriteBuffers", "CopyVideoData", "GetTileIDList",
                    "GetMonSpriteTileMapPointerFromRowCount", "CopyPicTiles", "RunPaletteCommand"):
        game.stub(routine)
    ditto, pikachu = species("DITTO"), species("PIKACHU")
    game.set("hWhoseTurn", 0)
    game.set("wIsInBattle", 1)
    game.set("wOptions", 0)
    game.set("wPlayerBattleStatus3", 0)
    game.set("wPlayerMonNumber", 0)
    game.set("wPartyMon1Species", ditto)
    game.set("wBattleMonSpecies", ditto)
    game.set("wEnemyMonSpecies", pikachu)
    game.call("AnimationTransformMon")
    assert game.get("wCurSpecies") == pikachu, game.get("wCurSpecies")


def field_move_species(game):
    # Choosing Strength for the second party mon from the party menu must not
    # leave the first compatible mon's species behind: the cry comes from it.
    machoke, geodude = species("MACHOKE"), species("GEODUDE")
    strength = constant("constants/move_constants.asm", "STRENGTH")
    game.set("wPartyCount", 2)
    party = game.address("wPartySpecies")
    game.p.memory[party:party + 3] = [machoke, geodude, 0xFF]
    game.set("wWhichPokemon", 1)
    game.set("wCurPartySpecies", geodude)
    r = game.call("PartyAnyCanLearnMove", A=strength)
    assert r.F & 0x10, "the party should be able to use Strength"
    assert game.get("wCurPartySpecies") == geodude, game.get("wCurPartySpecies")


def traded_stat_exp(game):
    # A mon received in a link trade keeps its Stat EXP contribution.
    onix = species("ONIX")
    max_hp = []
    for stat_exp in (0, 0xFFFF):
        game.set("wPartyCount", 0)
        game.set("wCurPartySpecies", onix)
        game.set("wWhichPokemon", 0)
        loaded = game.address("wLoadedMon")
        game.p.memory[loaded:loaded + 44] = [0] * 44
        game.set("wLoadedMonSpecies", onix)
        game.set("wLoadedMonLevel", 50)
        game.word("wLoadedMonHP", 1)
        for stat in ("HP", "Attack", "Defense", "Speed", "Special"):
            game.word(f"wLoadedMon{stat}Exp", stat_exp)
        r = game.call("_AddEnemyMonToPlayerParty", frames=30)
        assert not r.F & 0x10, "trade add failed"
        max_hp.append(word_at(game, "wPartyMon1MaxHP"))
    assert max_hp[1] > max_hp[0], max_hp


def main():
    failures = []
    with tempfile.TemporaryDirectory(prefix="rage-blue-audit-") as directory:
        for rom in ("pokered", "pokeblue", "pokeblue_debug"):
            game = Game(rom, directory)
            try:
                for check in (damage_stats, critical_stats, transformed_pp, experience_levels, status_penalties, haze_status,
                              leech_seed_toxic, sleep_recharge, field_move_species, traded_stat_exp, fossil_menu, transform_back_pic):
                    try:
                        check(game)
                        print(f"{rom}: {check.__name__} PASS")
                    except AssertionError as error:
                        failures.append(f"{rom}: {check.__name__}: {error}")
                        print(f"{failures[-1]}")
            finally:
                game.p.stop(save=False)
    assert not failures, "\n".join(failures)


if __name__ == "__main__":
    main()
