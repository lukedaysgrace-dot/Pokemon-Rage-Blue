SilphCo11F_Script:
	call SilphCo11FGateCallbackScript
	call EnableAutoTextBoxDrawing
	ld hl, SilphCo11TrainerHeaders
	ld de, SilphCo11F_ScriptPointers
	ld a, [wSilphCo11FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSilphCo11FCurScript], a
	ret

SilphCo11FGateCallbackScript:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	ld hl, SilphCo11GateCoords
	call SilphCo11F_SetCardKeyDoorYScript
	call SilphCo11FSetUnlockedDoorEventScript
	CheckEvent EVENT_SILPH_CO_11_UNLOCKED_DOOR
	ret nz
	ld a, $20
	ld [wNewTileBlockID], a
	lb bc, 6, 3
	predef_jump ReplaceTileBlock

SilphCo11GateCoords:
	dbmapcoord  3,  6
	db -1 ; end

SilphCo11F_SetCardKeyDoorYScript:
	push hl
	ld hl, wCardKeyDoorY
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a
	xor a
	ldh [hUnlockedSilphCoDoors], a
	pop hl
.loop_check_doors
	ld a, [hli]
	cp $ff
	jr z, .exit_loop
	push hl
	ld hl, hUnlockedSilphCoDoors
	inc [hl]
	pop hl
	cp b
	jr z, .check_y_coord
	inc hl
	jr .loop_check_doors
.check_y_coord
	ld a, [hli]
	cp c
	jr nz, .loop_check_doors
	ld hl, wCardKeyDoorY
	xor a
	ld [hli], a
	ld [hl], a
	ret
.exit_loop
	xor a
	ldh [hUnlockedSilphCoDoors], a
	ret

SilphCo11FSetUnlockedDoorEventScript:
	ldh a, [hUnlockedSilphCoDoors]
	and a
	ret z
	SetEvent EVENT_SILPH_CO_11_UNLOCKED_DOOR
	ret

SilphCo11FTeamRocketLeavesScript:
	ld hl, .HideToggleableObjectIDs
.hide_loop
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	cp -1 ; sentinel high byte; real indexes never reach $ff00
	jr z, .done_hiding
	push hl
	predef HideObject
	pop hl
	jr .hide_loop
.done_hiding
	ld hl, .ShowToggleableObjectIDs
.show_loop
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	cp -1 ; sentinel high byte; real indexes never reach $ff00
	ret z
	push hl
	predef ShowObject
	pop hl
	jr .show_loop

.ShowToggleableObjectIDs:
	dw TOGGLE_SAFFRON_CITY_8
	dw TOGGLE_SAFFRON_CITY_9
	dw TOGGLE_SAFFRON_CITY_A
	dw TOGGLE_SAFFRON_CITY_B
	dw TOGGLE_SAFFRON_CITY_C
	dw TOGGLE_SAFFRON_CITY_D
	dw -1 ; end

.HideToggleableObjectIDs:
	dw TOGGLE_SAFFRON_CITY_1
	dw TOGGLE_SAFFRON_CITY_2
	dw TOGGLE_SAFFRON_CITY_3
	dw TOGGLE_SAFFRON_CITY_4
	dw TOGGLE_SAFFRON_CITY_5
	dw TOGGLE_SAFFRON_CITY_6
	dw TOGGLE_SAFFRON_CITY_7
	dw TOGGLE_SAFFRON_CITY_E
	dw TOGGLE_SAFFRON_CITY_F
	dw TOGGLE_SILPH_CO_2F_2
	dw TOGGLE_SILPH_CO_2F_3
	dw TOGGLE_SILPH_CO_2F_4
	dw TOGGLE_SILPH_CO_2F_5
	dw TOGGLE_SILPH_CO_2F_TAMER
	dw TOGGLE_SILPH_CO_2F_JUGGLER
	dw TOGGLE_SILPH_CO_3F_1
	dw TOGGLE_SILPH_CO_3F_2
	dw TOGGLE_SILPH_CO_3F_TAMER1
	dw TOGGLE_SILPH_CO_3F_JUGGLER1
	dw TOGGLE_SILPH_CO_4F_1
	dw TOGGLE_SILPH_CO_4F_2
	dw TOGGLE_SILPH_CO_4F_3
	dw TOGGLE_SILPH_CO_5F_1
	dw TOGGLE_SILPH_CO_5F_2
	dw TOGGLE_SILPH_CO_5F_3
	dw TOGGLE_SILPH_CO_5F_4
	dw TOGGLE_SILPH_CO_6F_1
	dw TOGGLE_SILPH_CO_6F_2
	dw TOGGLE_SILPH_CO_6F_3
	dw TOGGLE_SILPH_CO_6F_TAMER
	dw TOGGLE_SILPH_CO_7F_1
	dw TOGGLE_SILPH_CO_7F_2
	dw TOGGLE_SILPH_CO_7F_3
	dw TOGGLE_SILPH_CO_7F_4
	dw TOGGLE_SILPH_CO_8F_1
	dw TOGGLE_SILPH_CO_8F_2
	dw TOGGLE_SILPH_CO_8F_3
	dw TOGGLE_SILPH_CO_9F_1
	dw TOGGLE_SILPH_CO_9F_2
	dw TOGGLE_SILPH_CO_9F_3
	dw TOGGLE_SILPH_CO_10F_1
	dw TOGGLE_SILPH_CO_10F_2
	dw TOGGLE_SILPH_CO_11F_1
	dw TOGGLE_SILPH_CO_11F_2
	dw TOGGLE_SILPH_CO_11F_3
	dw -1 ; end

SilphCo11FResetCurScript:
	xor a
	ld [wJoyIgnore], a
; fallthrough
SilphCo11FSetCurScript:
	ld [wSilphCo11FCurScript], a
	ld [wCurMapScript], a
	ret

SilphCo11F_ScriptPointers:
	def_script_pointers
	dw_const SilphCo11FDefaultScript,               SCRIPT_SILPHCO11F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SILPHCO11F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SILPHCO11F_END_BATTLE
	dw_const SilphCo11FGiovanniBattleFacingScript,  SCRIPT_SILPHCO11F_GIOVANNI_FACING
	dw_const SilphCo11FGiovanniStartBattleScript,   SCRIPT_SILPHCO11F_GIOVANNI_START_BATTLE
	dw_const SilphCo11FGiovanniAfterBattleScript,   SCRIPT_SILPHCO11F_GIOVANNI_AFTER_BATTLE
	dw_const SilphCo11FArianaBattleScript,          SCRIPT_SILPHCO11F_ARIANA_BATTLE
	dw_const SilphCo11FArianaAfterBattleScript,     SCRIPT_SILPHCO11F_ARIANA_AFTER_BATTLE
	dw_const SilphCo11FArcherAfterBattleScript,     SCRIPT_SILPHCO11F_ARCHER_AFTER_BATTLE

SilphCo11FDefaultScript:
	CheckEvent EVENT_BEAT_SILPH_CO_11F_TRAINER_0
	jr nz, .check_giovanni
	ld hl, .ArianaTriggerCoords
	call ArePlayerCoordsInArray
	jr nc, .check_giovanni
	ld a, [wCoordIndex]
	ld [wSavedCoordIndex], a
	xor a
	ldh [hJoyHeld], a
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
	ld a, SILPHCO11F_ROCKET1
	ld [wEmotionBubbleSpriteIndex], a
	xor a ; EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, SILPHCO11F_ROCKET1
	ldh [hSpriteIndex], a
	ld de, .ArianaApproachMovementRight
	ld a, [wSavedCoordIndex]
	cp 1
	jr z, .got_ariana_movement
	ld de, .ArianaApproachMovementCenter
	cp 2
	jr nz, .got_ariana_movement
	ld de, .ArianaApproachMovementLeft
.got_ariana_movement
	call MoveSprite
	ld a, SCRIPT_SILPHCO11F_ARIANA_BATTLE
	jp SilphCo11FSetCurScript
.check_giovanni
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ret nz
	ld hl, .PlayerCoordsArray
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	ld a, [wCoordIndex]
	ld [wSavedCoordIndex], a
	xor a
	ldh [hJoyHeld], a
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_SILPHCO11F_GIOVANNI
	ldh [hTextID], a
	call DisplayTextID
	ld a, SILPHCO11F_GIOVANNI
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld de, .GiovanniMovement
	call MoveSprite
	ld a, SCRIPT_SILPHCO11F_GIOVANNI_FACING
	jp SilphCo11FSetCurScript

.PlayerCoordsArray:
	dbmapcoord  6, 13
	dbmapcoord  7, 12
	db -1 ; end

.ArianaTriggerCoords:
	dbmapcoord  3,  3
	dbmapcoord  2,  3
	dbmapcoord  1,  3
	db -1 ; end

.ArianaApproachMovementRight:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db -1 ; end

.ArianaApproachMovementCenter:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

.ArianaApproachMovementLeft:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db -1 ; end

.GiovanniMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

SilphCo11FArianaBattleScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	ld a, SILPHCO11F_ROCKET1
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_SILPHCO11F_ROCKET1
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, SilphCo11FRocket1EndBattleText
	ld de, SilphCo11FRocket1EndBattleText
	call SaveEndBattleTextPointers
	ld a, 1
	ld [wTrainerNo], a
	ld a, OPP_ARIANA
	ld [wCurOpponent], a
	ld [wEnemyMonOrTrainerClass], a
	ld a, SCRIPT_SILPHCO11F_ARIANA_AFTER_BATTLE
	ld [wSilphCo11FCurScript], a
	ld [wCurMapScript], a
	ld hl, wStatusFlags7
	set BIT_USE_CUR_MAP_SCRIPT, [hl]
	xor a
	ldh [hJoyHeld], a
	ret

SilphCo11FArianaAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SilphCo11FResetCurScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_SILPH_CO_11F_TRAINER_0
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	ld a, SILPHCO11F_ROCKET1
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	ld a, TEXT_SILPHCO11F_ROCKET1_AFTER_BATTLE
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ld [wJoyIgnore], a
	jp SilphCo11FSetCurScript

SilphCo11FSetPlayerAndSpriteFacingDirectionScript:
	ld [wPlayerMovingDirection], a
	ld a, SILPHCO11F_GIOVANNI
	ldh [hSpriteIndex], a
	ld a, b
	ldh [hSpriteFacingDirection], a
	jp SetSpriteFacingDirectionAndDelay

SilphCo11FGiovanniAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SilphCo11FResetCurScript
	ld a, [wSavedCoordIndex]
	cp 1 ; index of second, upper-right entry in SilphCo11FDefaultScript.PlayerCoordsArray
	jr z, .face_player_up
	ld a, PLAYER_DIR_LEFT
	ld b, SPRITE_FACING_RIGHT
	jr .continue
.face_player_up
	ld a, PLAYER_DIR_UP
	ld b, SPRITE_FACING_DOWN
.continue
	call SilphCo11FSetPlayerAndSpriteFacingDirectionScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_SILPHCO11F_GIOVANNI_YOU_RUINED_OUR_PLANS
	ldh [hTextID], a
	call DisplayTextID
	call GBFadeOutToBlack
	call SilphCo11FTeamRocketLeavesScript
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	SetEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	xor a
	ld [wJoyIgnore], a
	jp SilphCo11FSetCurScript

SilphCo11FGiovanniBattleFacingScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, SILPHCO11F_GIOVANNI
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wSavedCoordIndex]
	cp 1 ; index of second, upper-right entry in SilphCo11FDefaultScript.PlayerCoordsArray
	jr z, .face_player_up
	ld a, PLAYER_DIR_LEFT
	ld b, SPRITE_FACING_RIGHT
	jr .continue
.face_player_up
	ld a, PLAYER_DIR_UP
	ld b, SPRITE_FACING_DOWN
.continue
	call SilphCo11FSetPlayerAndSpriteFacingDirectionScript
	call Delay3
	ld a, SCRIPT_SILPHCO11F_GIOVANNI_START_BATTLE
	jp SilphCo11FSetCurScript

SilphCo11FGiovanniStartBattleScript:
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, SilphCo10FGiovanniILostAgainText
	ld de, SilphCo10FGiovanniILostAgainText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	xor a
	ld [wJoyIgnore], a
	ld a, SCRIPT_SILPHCO11F_GIOVANNI_AFTER_BATTLE
	jp SilphCo11FSetCurScript

SilphCo11FArcherAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SilphCo11FResetCurScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_SILPH_CO_11F_TRAINER_1
	ld a, TEXT_SILPHCO11F_ROCKET2_AFTER_BATTLE
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_SILPH_CO_11_UNLOCKED_DOOR
	ld a, $3
	ld [wNewTileBlockID], a
	lb bc, 6, 3
	predef ReplaceTileBlock
	xor a
	ld [wJoyIgnore], a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	jp SilphCo11FSetCurScript

SilphCo11F_TextPointers:
	def_text_pointers
	dw_const SilphCo11FSilphPresidentText,            TEXT_SILPHCO11F_SILPH_PRESIDENT
	dw_const SilphCo11FBeautyText,                    TEXT_SILPHCO11F_BEAUTY
	dw_const SilphCo11FGiovanniText,                  TEXT_SILPHCO11F_GIOVANNI
	dw_const SilphCo11FRocket1Text,                   TEXT_SILPHCO11F_ROCKET1
	dw_const SilphCo11FRocket2Text,                   TEXT_SILPHCO11F_ROCKET2
	dw_const SilphCo11FRocket1AfterBattleText,        TEXT_SILPHCO11F_ROCKET1_AFTER_BATTLE
	dw_const SilphCo11FRocket2AfterBattleText,        TEXT_SILPHCO11F_ROCKET2_AFTER_BATTLE
	dw_const SilphCo11FGiovanniYouRuinedOurPlansText, TEXT_SILPHCO11F_GIOVANNI_YOU_RUINED_OUR_PLANS

SilphCo11TrainerHeaders:
	def_trainers 4
SilphCo11TrainerHeader0:
	trainer EVENT_BEAT_SILPH_CO_11F_TRAINER_0, 4, SilphCo11FRocket1BattleText, SilphCo11FRocket1EndBattleText, SilphCo11FRocket1AfterBattleText
SilphCo11TrainerHeader1:
	trainer EVENT_BEAT_SILPH_CO_11F_TRAINER_1, 0, SilphCo11FRocket2BattleText, SilphCo11FRocket2EndBattleText, SilphCo11FRocket2AfterBattleText
	db -1 ; end

SilphCo11FSilphPresidentText:
	text_asm
	CheckEvent EVENT_GOT_MASTER_BALL
	jp nz, .got_item
	ld hl, .Text
	call PrintText
	lb bc, MASTER_BALL, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .ReceivedMasterBallText
	call PrintText
	SetEvent EVENT_GOT_MASTER_BALL
	jr .done
.bag_full
	ld hl, .NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, .MasterBallDescriptionText
	call PrintText
.done
	jp TextScriptEnd

.Text:
	text_far _SilphCo11FSilphPresidentText
	text_end

.ReceivedMasterBallText:
	text_far _SilphCo11FSilphPresidentReceivedMasterBallText
	sound_get_key_item
	text_end

.MasterBallDescriptionText:
	text_far _SilphCo11FSilphPresidentMasterBallDescriptionText
	text_end

.NoRoomText:
	text_far _SilphCo11FSilphPresidentNoRoomText
	text_end

SilphCo11FBeautyText:
	text_far _SilphCo11FBeautyText
	text_end

SilphCo11FGiovanniText:
	text_far _SilphCo11FGiovanniText
	text_end

SilphCo10FGiovanniILostAgainText:
	text_far _SilphCo10FGiovanniILostAgainText
	text_end

SilphCo11FGiovanniYouRuinedOurPlansText:
	text_far _SilphCo11FGiovanniYouRuinedOurPlansText
	text_end

SilphCo11FRocket1Text:
	text_asm
	ld hl, SilphCo11TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SilphCo11FRocket1BattleText:
	text_far _SilphCo11FRocket1BattleText
	text_end

SilphCo11FRocket1EndBattleText:
	text_far _SilphCo11FRocket1EndBattleText
	text_end

SilphCo11FRocket1AfterBattleText:
	text_far _SilphCo11FRocket1AfterBattleText
	text_end

SilphCo11FRocket2Text:
	text_asm
	CheckEvent EVENT_BEAT_SILPH_CO_11F_TRAINER_1
	jr nz, .after_battle
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
	ld hl, .BattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, .EndBattleText
	ld de, .EndBattleText
	call SaveEndBattleTextPointers
	ld a, 1
	ld [wTrainerNo], a
	ld a, OPP_ARCHER
	ld [wCurOpponent], a
	ld [wEnemyMonOrTrainerClass], a
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, SCRIPT_SILPHCO11F_ARCHER_AFTER_BATTLE
	ld [wSilphCo11FCurScript], a
	ld [wCurMapScript], a
	ld hl, wStatusFlags7
	set BIT_USE_CUR_MAP_SCRIPT, [hl]
	jr .done
.after_battle
	ld hl, .AfterBattleText
	call PrintText
.done
	jp TextScriptEnd

.BattleText:
	text_far _SilphCo11FRocket2BattleText
	text_end

.EndBattleText:
	text_far _SilphCo11FRocket2EndBattleText
	text_end

.AfterBattleText:
	text_far _SilphCo11FRocket2AfterBattleText
	text_end

SilphCo11FRocket2BattleText:
	text_far _SilphCo11FRocket2BattleText
	text_end

SilphCo11FRocket2EndBattleText:
	text_far _SilphCo11FRocket2EndBattleText
	text_end

SilphCo11FRocket2AfterBattleText:
	text_far _SilphCo11FRocket2AfterBattleText
	text_end

SilphCo10FPorygonText: ; unreferenced
	text_asm
	ld hl, .Text
	call PrintText
	ld a, PORYGON
	call DisplayPokedex
	jp TextScriptEnd

.Text:
	text_far _SilphCo10FPorygonText
	text_end
