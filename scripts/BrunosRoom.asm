BrunosRoom_Script:
	call KarenShowOrHideExitBlock
	call EnableAutoTextBoxDrawing
	ld hl, BrunosRoomTrainerHeaders
	ld de, BrunosRoom_ScriptPointers
	ld a, [wBrunosRoomCurScript]
	call ExecuteCurMapScriptInTable
	ld [wBrunosRoomCurScript], a
	ret

KarenShowOrHideExitBlock:
; Blocks or clears the exit to the next room.
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	CheckEvent EVENT_BEAT_KARENS_ROOM_TRAINER_0
	jr z, .blockExitToNextRoom
	ld a, $5
	jp .setExitBlock
.blockExitToNextRoom
	ld a, $24
.setExitBlock
	ld [wNewTileBlockID], a
	lb bc, 0, 2
	predef_jump ReplaceTileBlock

ResetKarenScript:
	xor a ; SCRIPT_BRUNOSROOM_DEFAULT
	ld [wJoyIgnore], a
	ld [wBrunosRoomCurScript], a
	ld [wCurMapScript], a
	ret

BrunosRoom_ScriptPointers:
	def_script_pointers
	dw_const BrunosRoomDefaultScript,               SCRIPT_BRUNOSROOM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_KARENSROOM_KAREN_START_BATTLE
	dw_const KarensRoomKarenEndBattleScript,        SCRIPT_KARENSROOM_KAREN_END_BATTLE
	dw_const KarensRoomKarenRematchEndBattleScript, SCRIPT_KARENSROOM_KAREN_REMATCH_END_BATTLE
	dw_const BrunosRoomPlayerIsMovingScript,        SCRIPT_BRUNOSROOM_PLAYER_IS_MOVING
	dw_const BrunosRoomNoopScript,                  SCRIPT_BRUNOSROOM_NOOP

BrunosRoomNoopScript:
	ret

KarenScriptWalkIntoRoom:
; Walk six steps upward.
	ld hl, wSimulatedJoypadStatesEnd
	ld a, PAD_UP
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, $6
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, SCRIPT_BRUNOSROOM_PLAYER_IS_MOVING
	ld [wBrunosRoomCurScript], a
	ld [wCurMapScript], a
	ret

BrunosRoomDefaultScript:
	ld hl, KarenEntranceCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	xor a
	ldh [hJoyPressed], a
	ldh [hJoyHeld], a
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSimulatedJoypadStatesIndex], a
	ld a, [wCoordIndex]
	cp $3  ; Is player standing one tile above the exit?
	jr c, .stopPlayerFromLeaving
	CheckAndSetEvent EVENT_AUTOWALKED_INTO_KARENS_ROOM
	jr z, KarenScriptWalkIntoRoom
.stopPlayerFromLeaving
	ld a, TEXT_KARENSROOM_KAREN_DONT_RUN_AWAY
	ldh [hTextID], a
	call DisplayTextID  ; "Don't run away!"
	ld a, PAD_UP
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, SCRIPT_BRUNOSROOM_PLAYER_IS_MOVING
	ld [wBrunosRoomCurScript], a
	ld [wCurMapScript], a
	ret

KarenEntranceCoords:
	dbmapcoord  4, 10
	dbmapcoord  5, 10
	dbmapcoord  4, 11
	dbmapcoord  5, 11
	db -1 ; end

BrunosRoomPlayerIsMovingScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a ; SCRIPT_BRUNOSROOM_DEFAULT
	ld [wJoyIgnore], a
	ld [wBrunosRoomCurScript], a
	ld [wCurMapScript], a
	ret

KarensRoomKarenEndBattleScript:
	call EndTrainerBattle
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetKarenScript
	ld a, TEXT_KARENSROOM_KAREN
	ldh [hTextID], a
	jp DisplayTextID

KarensRoomKarenRematchEndBattleScript:
	call EndTrainerBattle
	ld hl, wStatusFlags3
	res BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, wMiscFlags
	res BIT_SEEN_BY_TRAINER, [hl]
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetKarenScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_KARENSROOM_KAREN_REMATCH_VICTORY
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_KARENS_ROOM_TRAINER_0
	SetEvent EVENT_REMATCH_DEFEATED_KAREN
	jp ResetKarenScript

BrunosRoom_TextPointers:
	def_text_pointers
	dw_const KarensRoomKarenText,            TEXT_KARENSROOM_KAREN
	dw_const KarensRoomKarenDontRunAwayText, TEXT_KARENSROOM_KAREN_DONT_RUN_AWAY
	dw_const KarenRematchVictoryOverworldText, TEXT_KARENSROOM_KAREN_REMATCH_VICTORY

BrunosRoomTrainerHeaders:
	def_trainers
KarensRoomTrainerHeader0:
	trainer EVENT_BEAT_KARENS_ROOM_TRAINER_0, 0, KarenBeforeBattleText, KarenEndBattleText, KarenAfterBattleText
	db -1 ; end

KarensRoomKarenText:
	text_asm
	call PostGameRematchesUnlocked
	jr z, .vanilla
	CheckEvent EVENT_BEAT_KARENS_ROOM_TRAINER_0
	jr z, .rematch
	ld hl, KarenRematchMustRestartText
	call PrintText
	jp TextScriptEnd
.rematch
	ld hl, KarenRematchPreBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, KarenRematchEndBattleText
	ld de, KarenRematchEndBattleText
	call SaveEndBattleTextPointers
	ld hl, KarensRoomTrainerHeader0
	call StoreTrainerHeaderPointer
	xor a
	call ReadTrainerHeaderInfo
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	ld a, 2
	ld [wEngagedTrainerSet], a
	call InitBattleEnemyParameters
	ld a, 1
	ld [wGymLeaderNo], a
	ld hl, wStatusFlags4
	set BIT_UNKNOWN_4_1, [hl]
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, SCRIPT_KARENSROOM_KAREN_REMATCH_END_BATTLE
	ld [wBrunosRoomCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd
.vanilla
	ld a, 1
	ld [wGymLeaderNo], a
	ld hl, KarensRoomTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

KarenRematchPreBattleText:
	text_far _KarenRematchPreBattleText
	text_end

KarenRematchEndBattleText:
	text_far _KarenRematchDefeatText
	text_end

KarenRematchVictoryOverworldText:
	text_far _KarenRematchDefeatOverworldText
	text_end

KarenRematchMustRestartText:
	text_far _KarenRematchMustRestartText
	text_end

KarenBeforeBattleText:
	text_far _KarenBeforeBattleText
	text_end

KarenEndBattleText:
	text_far _KarenEndBattleText
	text_end

KarenAfterBattleText:
	text_far _KarenAfterBattleText
	text_end

KarensRoomKarenDontRunAwayText:
	text_far _KarensRoomKarenDontRunAwayText
	text_end
