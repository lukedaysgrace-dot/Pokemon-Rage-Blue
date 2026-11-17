"""Execute trainer Stat EXP matching and battle loading on disposable ROMs.

Requires PyBoy and freshly built Red, Blue and Blue debug ROMs/symbols.
No player saves are opened. Trainer construction and stat math are real ROM
code; only nickname text rendering is stubbed during battle-mon loading.
"""

import math
import re
import tempfile

from test_gameplay_regressions import Game, ROOT, species, word_at


BOSSES = """BROCK MISTY LT_SURGE ERIKA KOGA SABRINA BLAINE GIOVANNI
LORELEI BRUNO AGATHA LANCE RIVAL1 RIVAL2 RIVAL3 GREEN GREEN_ROCKET BLUE_CLOAK
JANINE ARIANA PETREL PROTON ARCHER PROF_OAK""".split()
COOLTRAINERS = ("COOLTRAINER_M", "COOLTRAINER_F")
CLASSES = {name: number for number, name in enumerate(re.findall(
    r"^\s*trainer_const\s+(\w+)",
    (ROOT / "constants/trainer_constants.asm").read_text(), re.M))}
POLICY = {**{name: 2 for name in BOSSES}, **{name: 0 for name in COOLTRAINERS}}
STATS = ("HP", "Attack", "Defense", "Speed", "Special")


class TrainerGame(Game):
    def call(self, name, frames=300, **registers):
        # Check once per frame rather than wasting a fixed, long timeout on
        # every small helper. Real party construction can need many frames.
        bank, address = self.symbols[name]
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
        for _ in range(frames):
            self.p.tick(1, render=False)
            if r.PC in (0x103, 0x104):
                assert r.SP == 0xDFFF, f"{name}: unbalanced stack"
                return r
        raise AssertionError(f"{name} did not return: PC={r.PC:04x}")


def points(value):
    root = math.isqrt(value)
    return min(255, root + (root * root < value)) // 4


def boosted(value):
    target = min(63, points(value) + 2)
    return 65535 if target == 63 else (4 * target) ** 2


def words(game, address):
    data = bytes(game.p.memory[address:address + 10])
    return [int.from_bytes(data[i:i + 2], "big") for i in range(0, 10, 2)]


def party(game, values=None):
    # Each stat's maximum comes from a different slot. The highest HP is
    # in slot six, which is fainted; taking only the lead/living mons fails.
    values = values or [65535, 4097, 10001, 20000, 65025]
    start = game.address("wPartyMon1")
    size = game.address("wPartyMon2") - start
    game.p.memory[start:start + 6 * size] = [0] * (6 * size)
    game.set("wPartyCount", 6)
    names = game.address("wPartySpecies")
    game.p.memory[names:names + 7] = [species("BULBASAUR")] * 6 + [255]
    for slot in range(6):
        base = start + slot * size
        game.p.memory[base] = species("BULBASAUR")
        game.p.memory[base + 2] = 1 if slot < 5 else 0
        for stat, value in enumerate(values):
            offset = game.address("wPartyMon1HPExp") - start + 2 * stat
            word = value if slot == (stat + 5) % 6 else 0
            game.p.memory[base + offset:base + offset + 2] = [word >> 8, word & 255]
    return values


def arithmetic(game):
    # Both sides of every square boundary, including training-point changes
    # and saturation. This is checked against Python integer arithmetic.
    values = {0, 1, 65535}
    for root in range(256):
        values.update(v for v in (root * root - 1, root * root, root * root + 1)
                      if 0 <= v <= 65535)
    for value in sorted(values):
        r = game.call("AddTrainerStatExpPointBonus", B=2, C=8,
                      D=value >> 8, E=value & 255)
        actual = r.D * 256 + r.E
        assert actual == boosted(value), (value, actual, boosted(value))
        assert (r.B, r.C) == (2, 8)
        assert points(actual) == min(63, points(value) + 2)
    return len(values)


def initialization(game):
    maxima = party(game)
    before = bytes(game.p.memory[game.address("wPartyCount"):game.address("wPartyMon1") + 6 * 44])
    target = game.address("wEnemyMon1HPExp")
    for difficulty in (0, 1):
        for name, cls in CLASSES.items():
            game.set("wMonDataLocation", 1)
            game.set("wDifficulty", difficulty)
            game.set("wLinkState", 0)
            game.set("wTrainerClass", cls)
            game.p.memory[target - 1:target + 11] = [0xA5] * 12
            r = game.call("InitializeTrainerStatExp", D=(target - 1) >> 8, E=(target - 1) & 255)
            expected = ([boosted(v) for v in maxima] if POLICY.get(name) == 2
                        else maxima if name in COOLTRAINERS else [0] * 5)
            if not difficulty:
                expected = [0] * 5
            assert words(game, target) == expected, (difficulty, name, words(game, target), expected)
            assert game.p.memory[target - 1] == game.p.memory[target + 10] == 0xA5
            assert (r.D << 8 | r.E) == target + 9
    after = bytes(game.p.memory[game.address("wPartyCount"):game.address("wPartyMon1") + 6 * 44])
    assert after == before, "matching changed the player's party"
    for location, link in ((0, 0), (2, 0), (1, 4)):
        game.set("wMonDataLocation", location)
        game.set("wLinkState", link)
        game.set("wTrainerClass", CLASSES["BROCK"])
        game.p.memory[target:target + 10] = [255] * 10
        game.call("InitializeTrainerStatExp", D=(target - 1) >> 8, E=(target - 1) & 255)
        # Locations with a nonzero low nibble are enemy additions in Gen 1.
        assert words(game, target) == ([boosted(v) for v in maxima] if location == 2 else [0] * 5)
    game.set("wLinkState", 0)
    for count in (0, 7, 255):
        game.set("wPartyCount", count)
        r = game.call("GetPlayerMaximumStatExp", B=2, C=0)
        assert (r.D, r.E, r.B, r.C) == (0, 0, 2, 0)
    party(game)
    # Empty and terminator species cannot contribute stale training.
    for invalid in (0, 255):
        game.set("wPartyMon6Species", invalid)
        r = game.call("GetPlayerMaximumStatExp", B=2, C=0)
        assert (r.D, r.E) == (0, 0)
    party(game, [0] * 5)
    for stat in range(5):
        r = game.call("GetPlayerMaximumStatExp", B=2, C=2 * stat)
        assert (r.D, r.E) == (0, 0)


def trainer_rows(game, cls, number):
    bank, table = game.symbols["TrainerDataPointers"]
    pointer = table + (cls - 1) * 2
    address = game.p.memory[bank, pointer] | (game.p.memory[bank, pointer + 1] << 8)
    for _ in range(number - 1):
        while game.p.memory[bank, address]:
            address += 1
        address += 1
    first = game.p.memory[bank, address]
    address += 1
    result = []
    while game.p.memory[bank, address]:
        if first == 255:
            level = game.p.memory[bank, address]
            address += 1
        else:
            level = first
        result.append((level, game.p.memory[bank, address]))
        address += 1
    return result


def check_stats(game, prefix, level, training):
    # Compare against the complete Gen 1 formula using the base data loaded
    # by the real battle loader and the actual fixed DVs for that trainer.
    header = game.address("wMonHeader")
    dv = game.address(prefix + "DVs")
    attack, defense = game.p.memory[dv] >> 4, game.p.memory[dv] & 15
    speed, special = game.p.memory[dv + 1] >> 4, game.p.memory[dv + 1] & 15
    hp = ((attack & 1) << 3) | ((defense & 1) << 2) | ((speed & 1) << 1) | (special & 1)
    for stat, iv, word, index in zip(STATS, (hp, attack, defense, speed, special), training, range(5)):
        base = game.p.memory[header + 1 + index]
        expected = min(999, ((base + iv) * 2 + points(word)) * level // 100
                       + (level + 10 if index == 0 else 5))
        name = "MaxHP" if stat == "HP" else stat
        assert word_at(game, prefix + name) == expected, (prefix, stat, word_at(game, prefix + name), expected)


def load_battler(game, slot, training):
    prefix = f"wEnemyMon{slot + 1}"
    level = game.get(prefix + "Level")
    game.set("wWhichPokemon", slot)
    game.set("wCurEnemyLevel", level)
    game.set("wEnemyMonSpecies2", game.get(prefix + "Species"))
    game.set("wEnemyBattleStatus3", 0)
    game.call("LoadEnemyMonData")
    assert bytes(game.p.memory[game.address("wEnemyMonMaxHP"):game.address("wEnemyMonMaxHP") + 10]) == bytes(
        game.p.memory[game.address(prefix + "MaxHP"):game.address(prefix + "MaxHP") + 10])
    assert word_at(game, "wEnemyMonHP") == word_at(game, prefix + "HP")
    check_stats(game, "wEnemyMon", level, training)


def battles(game, blue):
    game.stub("GetMonName")  # presentation only
    source = (ROOT / f"data/trainers/parties_{'blue' if blue else 'red'}.asm").read_text()
    groups = re.split(r"^(\w+Data):\s*$", source, flags=re.M)
    row_counts = {groups[i]: len(re.findall(r"^\s*db\s", groups[i + 1], re.M))
                  for i in range(1, len(groups), 2)}
    pointers = re.findall(r"^\s*dw\s+(\w+Data)", (ROOT / "data/trainers/parties.asm").read_text(), re.M)
    maxima = party(game, [1024, 2048, 4096, 8192, 16384])
    count = 0
    for difficulty in (1, 0):
        for name in (*POLICY, "YOUNGSTER"):
            cls = CLASSES[name]
            for number in range(1, row_counts[pointers[cls - 1]] + 1):
                game.set("wDifficulty", difficulty)
                game.set("wLinkState", 0)
                game.set("wTrainerClass", cls)
                game.set("wCurOpponent", (196 if blue else 197) + cls)
                game.set("wTrainerNo", number)
                game.set("wLoneAttackNo", 0)
                game.set("wIsInBattle", 2)
                expected_party = trainer_rows(game, cls, number)
                game.call("ReadTrainer")
                assert game.get("wEnemyPartyCount") == len(expected_party), (name, number)
                expected = ([boosted(v) for v in maxima] if POLICY.get(name) == 2
                            else maxima if name in COOLTRAINERS else [0] * 5)
                if not difficulty:
                    expected = [0] * 5
                for slot, (level, mon) in enumerate(expected_party):
                    prefix = f"wEnemyMon{slot + 1}"
                    assert (game.get(prefix + "Level"), game.get(prefix + "Species")) == (level, mon)
                    assert words(game, game.address(prefix + "HPExp")) == expected, (name, number, slot, expected)
                    assert word_at(game, prefix + "HP") == word_at(game, prefix + "MaxHP")
                # Every authored row's lead reaches the battle stat loader.
                load_battler(game, 0, expected)
                # Damage, switch to the last teammate, then return. Loading
                # a trained mon must never heal its current HP to its max.
                game.word("wEnemyMon1HP", max(1, word_at(game, "wEnemyMon1MaxHP") - 7))
                load_battler(game, len(expected_party) - 1, expected)
                load_battler(game, 0, expected)
                count += 1
    # Link parties arrive over serial and ReadTrainer must leave them alone.
    game.set("wLinkState", 4)
    start = game.address("wEnemyPartyCount")
    end = game.address("wEnemyMon6") + 44
    original = bytes(game.p.memory[start:end])
    game.call("ReadTrainer")
    assert bytes(game.p.memory[start:end]) == original
    return count


def main():
    with tempfile.TemporaryDirectory(prefix="rage-blue-training-") as directory:
        for rom in ("pokered", "pokeblue", "pokeblue_debug"):
            game = TrainerGame(rom, directory)
            try:
                count = arithmetic(game)
                print(f"{rom}: {count} square-boundary arithmetic checks PASS", flush=True)
                initialization(game)
                print(f"{rom}: all trainer classes, independent maxima, fainted/empty party and scope guards PASS", flush=True)
                count = battles(game, blue=rom != "pokered")
                print(f"{rom}: {count} trainer rows across Hard/Normal Mode, stat formulas, switching and link preservation PASS", flush=True)
            finally:
                game.p.stop(save=False)


if __name__ == "__main__":
    main()
