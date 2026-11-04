"""Check Bruno rematch progression and cave object flags on disposable ROMs."""

import tempfile

from test_gameplay_regressions import Game, constant


def event_location(game, name):
    event = constant("constants/event_constants.asm", name)
    return game.address("wEventFlags") + event // 8, 1 << (event % 8)


def rematch(game, blue):
    # Skip text rendering and music; execute the real trainer setup and end script.
    for name in ("PrintText", "PlayTrainerMusic", "TextScriptEnd", "DisplayTextID"):
        game.stub(name)
    bank, address = game.symbols["BrunosRoomBrunoText"]
    game.symbols["BrunoInteraction"] = bank, address + 1  # skip text_asm byte
    game.set("wNumHoFTeams", 1)
    game.set("hSpriteIndex", 1)
    opponent = (196 if blue else 197) + 0x22  # BRUNO
    game.set("wMapSpriteExtraData", opponent)
    game.p.memory[game.address("wMapSpriteExtraData") + 1] = 1
    beaten, mask = event_location(game, "EVENT_BEAT_BRUNOS_ROOM_TRAINER_0")
    rematched, rematch_mask = event_location(game, "EVENT_REMATCH_DEFEATED_BRUNO")
    for lost in (True, False):
        game.p.memory[beaten] = 0
        game.p.memory[rematched] = 0
        game.set("wTrainerHeaderFlagBit", 7)  # stale bit must be replaced
        game.call("BrunoInteraction")
        assert game.get("wCurOpponent") == opponent
        assert game.get("wTrainerNo") == 2
        assert game.get("wTrainerHeaderFlagBit") == 1
        assert game.get("wBrunosRoomCurScript") == 3
        assert game.get("wStatusFlags4") & 2  # battle starts
        assert not game.p.memory[beaten] & mask
        game.set("wIsInBattle", 0xFF if lost else 0)
        game.call("BrunosRoomBrunoRematchEndBattleScript")
        assert bool(game.p.memory[beaten] & mask) == (not lost)
        assert bool(game.p.memory[rematched] & rematch_mask) == (not lost)
        assert game.get("wBrunosRoomCurScript") == 0
        assert game.get("wJoyIgnore") == 0
    # After a win, talking again requires restarting the League challenge.
    game.set("wTrainerNo", 99)
    game.call("BrunoInteraction")
    assert game.get("wTrainerNo") == 99
    assert game.get("wBrunosRoomCurScript") == 0


def cave(game):
    # The former ambush tile must leave normal trainer/Mewtwo handling active.
    game.stub("CheckFightingMapTrainers")
    game.stub("EnableAutoTextBoxDrawing")
    game.set("wXCoord", 21)
    game.set("wYCoord", 8)
    game.set("wCeruleanCaveB1FCurScript", 0)
    game.set("wStatusFlags7", 0)
    game.set("wJoyIgnore", 0)
    game.call("CeruleanCaveB1F_Script")
    assert game.get("wCeruleanCaveB1FCurScript") == 0
    assert game.get("wJoyIgnore") == 0
    game.call("InitializeToggleableObjectsFlags")
    game.set("wCurMap", 0xE3)  # CERULEAN_CAVE_B1F
    game.call("MarkTownVisitedAndLoadToggleableObjects")
    address = game.address("wToggleableObjectList")
    assert list(game.p.memory[address:address + 7]) == [1, 0, 2, 1, 3, 2, 255]
    address = game.address("wToggleableObjectBase")
    base = int.from_bytes(bytes(game.p.memory[address:address + 2]), "little")
    # A saved hidden-Mewtwo flag must still hide Mewtwo, without hiding items.
    flags = game.address("wToggleableObjectFlags")
    game.p.memory[flags + base // 8] |= 1 << (base % 8)
    for sprite, hidden in ((1, True), (2, False), (3, False)):
        game.set("hCurrentSpriteOffset", sprite << 4)
        game.call("IsObjectHidden")
        assert bool(game.get("hIsToggleableObjectOff")) == hidden
    return base


def main():
    bases = []
    with tempfile.TemporaryDirectory(prefix="rage-blue-bruno-") as directory:
        for rom in ("pokered", "pokeblue", "pokeblue_debug"):
            game = Game(rom, directory)
            try:
                rematch(game, blue=rom != "pokered")
                bases.append(cave(game))
                print(f"{rom}: Bruno rematch and Cerulean Cave PASS")
            finally:
                game.p.stop(save=False)
    assert bases[1] == bases[2] == bases[0] + 1, bases


if __name__ == "__main__":
    main()
