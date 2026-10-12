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

    def call(self, name, **registers):
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
        self.p.tick(30 if name == "CalcLevelFromExperience" else 3, render=False)
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


def main():
    failures = []
    with tempfile.TemporaryDirectory(prefix="rage-blue-audit-") as directory:
        for rom in ("pokered", "pokeblue", "pokeblue_debug"):
            game = Game(rom, directory)
            try:
                for check in (damage_stats, critical_stats, transformed_pp, experience_levels, status_penalties, haze_status):
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
