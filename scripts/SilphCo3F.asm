SilphCo3F_Script:
	call SilphCo3FGateCallbackScript
	call EnableAutoTextBoxDrawing
	ld hl, SilphCo3TrainerHeaders
	ld de, SilphCo3F_ScriptPointers
	ld a, [wSilphCo3FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSilphCo3FCurScript], a
	ret

; Adjacent tiles around the warp panel (Proton stands at 11,11).
SilphCo3F_ProtonTriggerCoords:
	dbmapcoord 11, 10
	dbmapcoord 11, 12
	dbmapcoord 10, 11
	dbmapcoord 12, 11
	db -1 ; end

SilphCo3FGateCallbackScript:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	call SilphCo3F_EnforceProtonHiddenUnlessTriggered
	ld hl, .GateCoordinates
	call SilphCo2F_SetCardKeyDoorYScript
	call SilphCo3F_UnlockedDoorEventScript
	CheckEvent EVENT_SILPH_CO_3_UNLOCKED_DOOR1
	jr nz, .unlock_door1
	push af
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 4, 4
	predef ReplaceTileBlock
	pop af
.unlock_door1
	CheckEventAfterBranchReuseA EVENT_SILPH_CO_3_UNLOCKED_DOOR2, EVENT_SILPH_CO_3_UNLOCKED_DOOR1
	ret nz
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 4, 8
	predef_jump ReplaceTileBlock

.GateCoordinates:
	dbmapcoord  4,  4
	dbmapcoord  8,  4
	db -1 ; end

; On map load, keep Proton hidden unless the player warps/spawns on a trigger tile.
SilphCo3F_EnforceProtonHiddenUnlessTriggered:
	CheckEvent EVENT_BEAT_SILPH_CO_3F_PROTON
	ret nz
	ld hl, SilphCo3F_ProtonTriggerCoords
	call ArePlayerCoordsInArray
	ret c
	ld de, TOGGLE_SILPH_CO_3F_PROTON
	predef HideObject
	ret

SilphCo3F_UnlockedDoorEventScript:
	EventFlagAddress hl, EVENT_SILPH_CO_3_UNLOCKED_DOOR1
	ldh a, [hUnlockedSilphCoDoors]
	and a
	ret z
	cp $1
	jr nz, .unlock_door1
	SetEventReuseHL EVENT_SILPH_CO_3_UNLOCKED_DOOR1
	ret
.unlock_door1
	SetEventAfterBranchReuseHL EVENT_SILPH_CO_3_UNLOCKED_DOOR2, EVENT_SILPH_CO_3_UNLOCKED_DOOR1
	ret

SilphCo3F_ScriptPointers:
	def_script_pointers
	dw_const SilphCo3FDefaultScript,                SCRIPT_SILPHCO3F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SILPHCO3F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SILPHCO3F_END_BATTLE
	dw_const SilphCo3FProtonBattleScript,           SCRIPT_SILPHCO3F_PROTON_BATTLE
	dw_const SilphCo3FProtonAfterBattleScript,      SCRIPT_SILPHCO3F_PROTON_AFTER_BATTLE
	dw_const SilphCo3FProtonExitScript,             SCRIPT_SILPHCO3F_PROTON_EXIT

SilphCo3FDefaultScript:
	CheckEvent EVENT_BEAT_SILPH_CO_3F_PROTON
	jp nz, .hide_proton
	ld hl, SilphCo3F_ProtonTriggerCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	ld a, [wCoordIndex]
	ld [wSilphCo3FProtonVariant], a
	xor a
	ldh [hJoyHeld], a
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld de, TOGGLE_SILPH_CO_3F_PROTON
	predef ShowObject
	call UpdateSprites
	ld c, 12
	call DelayFrames
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
	call SilphCo3FProtonFacePlayer
	xor a
	ld [wEmotionBubbleSpriteIndex], a ; player
	ld [wWhichEmotionBubble], a ; EXCLAMATION_BUBBLE
	predef EmotionBubble
	ld a, SILPHCO3F_PROTON
	ld [wEmotionBubbleSpriteIndex], a
	xor a ; EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	call Delay3
	ld a, SCRIPT_SILPHCO3F_PROTON_BATTLE
	jp SilphCo3FSetCurScript
.hide_proton
	ld de, TOGGLE_SILPH_CO_3F_PROTON
	predef HideObject
	jp CheckFightingMapTrainers

SilphCo3FSetCurScript:
	ld [wSilphCo3FCurScript], a
	ld [wCurMapScript], a
	ret

SilphCo3FResetCurScript:
	xor a
	ld [wJoyIgnore], a
	jr SilphCo3FSetCurScript

SilphCo3FProtonFacePlayer:
	ld a, [wSilphCo3FProtonVariant]
	ld b, SPRITE_FACING_UP
	cp 1
	jr z, .got_facing
	ld b, SPRITE_FACING_DOWN
	cp 2
	jr z, .got_facing
	ld b, SPRITE_FACING_LEFT
	cp 3
	jr z, .got_facing
	ld b, SPRITE_FACING_RIGHT
.got_facing
	ld a, b
	ldh [hSpriteFacingDirection], a
	ld a, SILPHCO3F_PROTON
	ldh [hSpriteIndex], a
	jp SetSpriteFacingDirectionAndDelay

SilphCo3FProtonBattleScript:
	call SilphCo3FProtonFacePlayer
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	; Sprite index lets DisplayTextID read TEXT_* from wMapSpriteData; TEXT_SILPHCO3F_* alone is ambiguous.
	ld a, SILPHCO3F_PROTON
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, SilphCo3FProtonEndBattleText
	ld de, SilphCo3FProtonEndBattleText
	call SaveEndBattleTextPointers
	ld a, 2
	ld [wTrainerNo], a
	ld a, OPP_PROTON
	ld [wCurOpponent], a
	ld [wEnemyMonOrTrainerClass], a
	ld a, SCRIPT_SILPHCO3F_PROTON_AFTER_BATTLE
	ld [wSilphCo3FCurScript], a
	ld [wCurMapScript], a
	ld hl, wStatusFlags7
	set BIT_USE_CUR_MAP_SCRIPT, [hl]
	xor a
	ld [wJoyIgnore], a ; StartTrainerBattle clears this before battle; scripted cutscene path must too
	ldh [hJoyHeld], a
	ret

SilphCo3FProtonAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SilphCo3FResetCurScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_SILPH_CO_3F_PROTON
	call SilphCo3FProtonFacePlayer
	ld a, TEXT_SILPHCO3F_PROTON_AFTER_BATTLE
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, SCRIPT_SILPHCO3F_PROTON_EXIT
	jp SilphCo3FSetCurScript

SilphCo3FProtonExitScript:
	ld de, TOGGLE_SILPH_CO_3F_PROTON
	predef HideObject
	xor a
	ld [wJoyIgnore], a
	call PlayDefaultMusic
	xor a
	jp SilphCo3FSetCurScript

SilphCo3F_TextPointers:
	def_text_pointers
	dw_const SilphCo3FSilphWorkerMText, TEXT_SILPHCO3F_SILPH_WORKER_M
	dw_const SilphCo3FRocketText,       TEXT_SILPHCO3F_ROCKET
	dw_const SilphCo3FScientistText,    TEXT_SILPHCO3F_SCIENTIST
	dw_const PickUpItemText,            TEXT_SILPHCO3F_HYPER_POTION
	dw_const SilphCo3FProtonText,       TEXT_SILPHCO3F_PROTON
	dw_const SilphCo3FTamer1Text,       TEXT_SILPHCO3F_TAMER1
	dw_const SilphCo3FJuggler1Text,     TEXT_SILPHCO3F_JUGGLER1
	dw_const SilphCo3FProtonAfterBattleText, TEXT_SILPHCO3F_PROTON_AFTER_BATTLE

SilphCo3TrainerHeaders:
	def_trainers 2
SilphCo3TrainerHeader0:
	trainer EVENT_BEAT_SILPH_CO_3F_TRAINER_0, 2, SilphCo3FRocketBattleText, SilphCo3FRocketEndBattleText, SilphCo3FRocketAfterBattleText
SilphCo3TrainerHeader1:
	trainer EVENT_BEAT_SILPH_CO_3F_TRAINER_1, 3, SilphCo3FScientistBattleText, SilphCo3FScientistEndBattleText, SilphCo3FScientistAfterBattleText
SilphCo3TrainerHeader2:
	trainer EVENT_BEAT_SILPH_CO_3F_TRAINER_2, 2, SilphCo3FTamer1BattleText, SilphCo3FTamer1EndBattleText, SilphCo3FTamer1AfterBattleText
SilphCo3TrainerHeader3:
	trainer EVENT_BEAT_SILPH_CO_3F_TRAINER_3, 2, SilphCo3FJuggler1BattleText, SilphCo3FJuggler1EndBattleText, SilphCo3FJuggler1AfterBattleText
	db -1 ; end

SilphCo3FSilphWorkerMText:
	text_asm
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ld hl, .YouSavedUsText
	jr nz, .beat_giovanni
	ld hl, .WhatShouldIDoText
.beat_giovanni
	call PrintText
	jp TextScriptEnd

.WhatShouldIDoText:
	text_far _SilphCo3FSilphWorkerMWhatShouldIDoText
	text_end

.YouSavedUsText:
	text_far _SilphCo3FSilphWorkerMYouSavedUsText
	text_end

SilphCo3FRocketText:
	text_asm
	ld hl, SilphCo3TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SilphCo3FRocketBattleText:
	text_far _SilphCo3FRocketBattleText
	text_end

SilphCo3FRocketEndBattleText:
	text_far _SilphCo3FRocketEndBattleText
	text_end

SilphCo3FRocketAfterBattleText:
	text_far _SilphCo3FRocketAfterBattleText
	text_end

SilphCo3FScientistText:
	text_asm
	ld hl, SilphCo3TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SilphCo3FTamer1Text:
	text_asm
	ld hl, SilphCo3TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

SilphCo3FJuggler1Text:
	text_asm
	ld hl, SilphCo3TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

SilphCo3FScientistBattleText:
	text_far _SilphCo3FScientistBattleText
	text_end

SilphCo3FScientistEndBattleText:
	text_far _SilphCo3FScientistEndBattleText
	text_end

SilphCo3FScientistAfterBattleText:
	text_far _SilphCo3FScientistAfterBattleText
	text_end

SilphCo3FTamer1BattleText:
	text_far _SilphCo3FTamer1BattleText
	text_end

SilphCo3FTamer1EndBattleText:
	text_far _SilphCo3FTamer1EndBattleText
	text_end

SilphCo3FTamer1AfterBattleText:
	text_far _SilphCo3FTamer1AfterBattleText
	text_end

SilphCo3FJuggler1BattleText:
	text_far _SilphCo3FJuggler1BattleText
	text_end

SilphCo3FJuggler1EndBattleText:
	text_far _SilphCo3FJuggler1EndBattleText
	text_end

SilphCo3FJuggler1AfterBattleText:
	text_far _SilphCo3FJuggler1AfterBattleText
	text_end

SilphCo3FProtonText:
	text_far _SilphCo3FProtonText
	text_end

SilphCo3FProtonEndBattleText:
	text_far _SilphCo3FProtonEndBattleText
	text_end

SilphCo3FProtonAfterBattleText:
	text_far _SilphCo3FProtonAfterBattleText
	text_end
