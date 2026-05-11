LancesRoom_Script:
	call LanceShowOrHideEntranceBlocks
	call EnableAutoTextBoxDrawing
	ld hl, LancesRoomTrainerHeaders
	ld de, LancesRoom_ScriptPointers
	ld a, [wLancesRoomCurScript]
	call ExecuteCurMapScriptInTable
	ld [wLancesRoomCurScript], a
	ret

LanceShowOrHideEntranceBlocks:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	CheckEvent EVENT_LANCES_ROOM_LOCK_DOOR
	jr nz, .closeEntrance
	; open entrance
	ld a, $31
	ld b, $32
	jp .setEntranceBlocks
.closeEntrance
	ld a, $72
	ld b, $73
.setEntranceBlocks
; Replaces the tile blocks so the player can't leave.
	push bc
	ld [wNewTileBlockID], a
	lb bc, 6, 2
	call .SetEntranceBlock
	pop bc
	ld a, b
	ld [wNewTileBlockID], a
	lb bc, 6, 3
.SetEntranceBlock:
	predef_jump ReplaceTileBlock

ResetLanceScript:
	xor a ; SCRIPT_LANCESROOM_DEFAULT
	ld [wJoyIgnore], a
	ld [wLancesRoomCurScript], a
	ld [wCurMapScript], a
	ret

LancesRoom_ScriptPointers:
	def_script_pointers
	dw_const LancesRoomDefaultScript,               SCRIPT_LANCESROOM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_LANCESROOM_LANCE_START_BATTLE
	dw_const LancesRoomLanceEndBattleScript,        SCRIPT_LANCESROOM_LANCE_END_BATTLE
	dw_const LancesRoomLanceRematchEndBattleScript, SCRIPT_LANCESROOM_LANCE_REMATCH_END_BATTLE
	dw_const LancesRoomPlayerIsMovingScript,        SCRIPT_LANCESROOM_PLAYER_IS_MOVING
	dw_const LancesRoomNoopScript,                  SCRIPT_LANCESROOM_NOOP

LancesRoomNoopScript:
	ret

LancesRoomDefaultScript:
; After beating the Champion, allow full room interaction even though EVENT_BEAT_LANCE stays set.
	call PostGameRematchesUnlocked
	jr nz, .continueLanceRoom
	CheckEvent EVENT_BEAT_LANCE
	ret nz
.continueLanceRoom
	ld hl, LanceTriggerMovementCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	xor a
	ldh [hJoyHeld], a
	ld a, [wCoordIndex]
	cp $3  ; Is player standing next to Lance's sprite?
	jr nc, .notStandingNextToLance
	CheckEvent EVENT_BEAT_LANCES_ROOM_TRAINER_0
	ret nz
	ld a, TEXT_LANCESROOM_LANCE
	ldh [hTextID], a
	jp DisplayTextID
.notStandingNextToLance
	cp $5  ; Is player standing on the entrance staircase?
	jr z, WalkToLance
	CheckAndSetEvent EVENT_LANCES_ROOM_LOCK_DOOR
	ret nz
	ld hl, wCurrentMapScriptFlags
	set BIT_CUR_MAP_LOADED_1, [hl]
	ld a, SFX_GO_INSIDE
	call PlaySound
	jp LanceShowOrHideEntranceBlocks

LanceTriggerMovementCoords:
	dbmapcoord  5,  1
	dbmapcoord  6,  2
	dbmapcoord  5, 11
	dbmapcoord  6, 11
	dbmapcoord 24, 16
	db -1 ; end

LancesRoomLanceEndBattleScript:
	call EndTrainerBattle
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetLanceScript
	ld a, TEXT_LANCESROOM_LANCE
	ldh [hTextID], a
	jp DisplayTextID

LancesRoomLanceRematchEndBattleScript:
	call EndTrainerBattle
	ld hl, wStatusFlags3
	res BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, wMiscFlags
	res BIT_SEEN_BY_TRAINER, [hl]
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetLanceScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_LANCESROOM_LANCE_REMATCH_VICTORY
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_LANCES_ROOM_TRAINER_0
	SetEvent EVENT_REMATCH_DEFEATED_LANCE
	jp ResetLanceScript

WalkToLance:
; Moves the player down the hallway to Lance's room.
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, WalkToLance_RLEList
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, SCRIPT_LANCESROOM_PLAYER_IS_MOVING
	ld [wLancesRoomCurScript], a
	ld [wCurMapScript], a
	ret

WalkToLance_RLEList:
	db PAD_UP, 12
	db PAD_LEFT, 12
	db PAD_DOWN, 7
	db PAD_LEFT, 6
	db -1 ; end

LancesRoomPlayerIsMovingScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a ; SCRIPT_LANCESROOM_DEFAULT
	ld [wJoyIgnore], a
	ld [wLancesRoomCurScript], a
	ld [wCurMapScript], a
	ret

LancesRoom_TextPointers:
	def_text_pointers
	dw_const LancesRoomLanceText, TEXT_LANCESROOM_LANCE
	dw_const LanceRematchVictoryOverworldText, TEXT_LANCESROOM_LANCE_REMATCH_VICTORY

LancesRoomTrainerHeaders:
	def_trainers
LancesRoomTrainerHeader0:
	trainer EVENT_BEAT_LANCES_ROOM_TRAINER_0, 0, LancesRoomLanceBeforeBattleText, LancesRoomLanceEndBattleText, LancesRoomLanceAfterBattleText
	db -1 ; end

LancesRoomLanceText:
	text_asm
	call PostGameRematchesUnlocked
	jr z, .vanilla
	CheckEvent EVENT_BEAT_LANCES_ROOM_TRAINER_0
	jr z, .rematch
; Beat Lance this run — must not block CHAMPIONS_ROOM until the rival rematch is won.
	CheckEvent EVENT_REMATCH_DEFEATED_RIVAL_CHAMPION
	jr nz, .rematchFinishedThisRun
	ld hl, LanceGoFightChampionReminderText
	call PrintText
	jp TextScriptEnd
.rematchFinishedThisRun
	ld hl, LanceRematchMustRestartText
	call PrintText
	jp TextScriptEnd
.rematch
	ld hl, LanceRematchPreBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, LanceRematchEndBattleText
	ld de, LanceRematchEndBattleText
	call SaveEndBattleTextPointers
	ld hl, LancesRoomTrainerHeader0
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
	ld a, SCRIPT_LANCESROOM_LANCE_REMATCH_END_BATTLE
	ld [wLancesRoomCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd
.vanilla
	ld a, 1
	ld [wGymLeaderNo], a
	ld hl, LancesRoomTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

LanceRematchPreBattleText:
	text_far _LancesRoomLanceRematchPreBattleText
	text_end

LanceRematchEndBattleText:
	text_far _LancesRoomLanceRematchDefeatText
	text_end

LanceRematchVictoryOverworldText:
	text_far _LancesRoomLanceRematchDefeatOverworldText
	text_end

LanceRematchMustRestartText:
	text_far _LancesRoomLanceRematchMustRestartText
	text_end

LanceGoFightChampionReminderText:
	text_far _LancesRoomLanceGoFightChampionReminderText
	text_end

LancesRoomLanceBeforeBattleText:
	text_far _LancesRoomLanceBeforeBattleText
	text_end

LancesRoomLanceEndBattleText:
	text_far _LancesRoomLanceEndBattleText
	text_end

LancesRoomLanceAfterBattleText:
	text_far _LancesRoomLanceAfterBattleText
	text_asm
	SetEvent EVENT_BEAT_LANCE
	jp TextScriptEnd
