RocketHideoutB2F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, RocketHideout2TrainerHeaders
	ld de, RocketHideoutB2F_ScriptPointers
	ld a, [wRocketHideoutB2FCurScript]
	cp SCRIPT_ROCKETHIDEOUTB2F_GREEN_EXIT + 1
	jr c, .scriptIndexOk
	xor a
	ld [wRocketHideoutB2FCurScript], a
.scriptIndexOk:
	call ExecuteCurMapScriptInTable
	ld [wRocketHideoutB2FCurScript], a
	ret

RocketHideoutB2F_ScriptPointers:
	def_script_pointers
	dw_const RocketHideoutB2FDefaultScript,         SCRIPT_ROCKETHIDEOUTB2F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_ROCKETHIDEOUTB2F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_ROCKETHIDEOUTB2F_END_BATTLE
	dw_const RocketHideoutB2FPlayerSpinningScript,  SCRIPT_ROCKETHIDEOUTB2F_PLAYER_SPINNING
	dw_const RocketHideoutB2FGreenBattleScript,      SCRIPT_ROCKETHIDEOUTB2F_GREEN_BATTLE
	dw_const RocketHideoutB2FGreenAfterBattleScript, SCRIPT_ROCKETHIDEOUTB2F_GREEN_AFTER_BATTLE
	dw_const RocketHideoutB2FGreenExitScript,       SCRIPT_ROCKETHIDEOUTB2F_GREEN_EXIT

RocketHideoutB2FDefaultScript:
	CheckEvent EVENT_BEAT_ROCKET_HIDEOUT_B2F_GREEN
	jp nz, .skip_green_trigger
	ld hl, RocketHideoutB2FGreenTriggerCoords
	call ArePlayerCoordsInArray
	jp nc, .skip_green_trigger
	ld a, [wCoordIndex]
	ld [wRocketHideoutB2FGreenVariant], a
	ld a, [wWalkBikeSurfState]
	and a
	jr z, .green_music_ok
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
.green_music_ok
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
; Show Green before emotion bubble (bubble needs a visible sprite — Route 10 runs bubble after sprite exists).
	ld a, TOGGLE_ROCKET_HIDEOUT_B2F_GREEN
	ld [wToggleableObjectIndex], a
	predef ShowObject
	call RocketHideoutB2FGreenFacePlayer
	call UpdateSprites
	ld c, 12
	call DelayFrames
; Bubble over the player (sprite index 0): emotion_bubbles indexes wSpritePlayerStateData1 plus (index)*$10 via swap — see PalletTownOakWalksDown.
	xor a
	ld [wEmotionBubbleSpriteIndex], a
	ld [wWhichEmotionBubble], a ; EXCLAMATION_BUBBLE
	predef EmotionBubble
	call ReloadMapSpriteTilePatterns
	call UpdateSprites
	call PlayGreenEncounterMusic
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
; Scripted path from hidden position (21,22); ROM table + MoveSprite (trainer-style walk frames).
	ld a, [wRocketHideoutB2FGreenVariant]
	cp 2 ; wCoordIndex 2 = trigger (25,18)
	ld de, RocketHideoutB2FGreenApproachFrom25
	jr z, .greenDoApproach
	ld de, RocketHideoutB2FGreenApproachFrom24 ; wCoordIndex 1 = (24,18)
.greenDoApproach
	ld a, ROCKETHIDEOUTB2F_GREEN
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_ROCKETHIDEOUTB2F_GREEN_BATTLE
	ld [wRocketHideoutB2FCurScript], a
	ld [wCurMapScript], a
	ret
.skip_green_trigger
	ld a, [wYCoord]
	ld b, a
	ld a, [wXCoord]
	ld c, a
	ld hl, RocketHideout2ArrowTilePlayerMovement
	call DecodeArrowMovementRLE
	cp $ff
	jp z, CheckFightingMapTrainers
	ld hl, wMovementFlags
	set BIT_SPINNING, [hl]
	call StartSimulatingJoypadStates
	ld a, SFX_ARROW_TILES
	call PlaySound
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, SCRIPT_ROCKETHIDEOUTB2F_PLAYER_SPINNING
	ld [wCurMapScript], a
	ret

RocketHideout2ArrowTilePlayerMovement:
	map_coord_movement  4,  9, RocketHideout2ArrowMovement1
	map_coord_movement  4, 11, RocketHideout2ArrowMovement2
	map_coord_movement  4, 15, RocketHideout2ArrowMovement3
	map_coord_movement  4, 16, RocketHideout2ArrowMovement4
	map_coord_movement  4, 19, RocketHideout2ArrowMovement1
	map_coord_movement  4, 22, RocketHideout2ArrowMovement5
	map_coord_movement  5, 14, RocketHideout2ArrowMovement6
	map_coord_movement  6, 22, RocketHideout2ArrowMovement7
	map_coord_movement  6, 24, RocketHideout2ArrowMovement8
	map_coord_movement  8,  9, RocketHideout2ArrowMovement9
	map_coord_movement  8, 12, RocketHideout2ArrowMovement10
	map_coord_movement  8, 15, RocketHideout2ArrowMovement8
	map_coord_movement  8, 19, RocketHideout2ArrowMovement9
	map_coord_movement  8, 23, RocketHideout2ArrowMovement11
	map_coord_movement  9, 14, RocketHideout2ArrowMovement12
	map_coord_movement  9, 22, RocketHideout2ArrowMovement12
	map_coord_movement 10,  9, RocketHideout2ArrowMovement13
	map_coord_movement 10, 10, RocketHideout2ArrowMovement14
	map_coord_movement 10, 15, RocketHideout2ArrowMovement15
	map_coord_movement 10, 17, RocketHideout2ArrowMovement16
	map_coord_movement 10, 19, RocketHideout2ArrowMovement17
	map_coord_movement 10, 25, RocketHideout2ArrowMovement2
	map_coord_movement 11, 14, RocketHideout2ArrowMovement18
	map_coord_movement 11, 16, RocketHideout2ArrowMovement19
	map_coord_movement 11, 18, RocketHideout2ArrowMovement12
	map_coord_movement 12,  9, RocketHideout2ArrowMovement20
	map_coord_movement 12, 11, RocketHideout2ArrowMovement21
	map_coord_movement 12, 13, RocketHideout2ArrowMovement22
	map_coord_movement 12, 17, RocketHideout2ArrowMovement23
	map_coord_movement 13, 10, RocketHideout2ArrowMovement24
	map_coord_movement 13, 12, RocketHideout2ArrowMovement25
	map_coord_movement 13, 16, RocketHideout2ArrowMovement26
	map_coord_movement 13, 18, RocketHideout2ArrowMovement27
	map_coord_movement 13, 19, RocketHideout2ArrowMovement28
	map_coord_movement 13, 22, RocketHideout2ArrowMovement29
	map_coord_movement 13, 23, RocketHideout2ArrowMovement30
	map_coord_movement 14, 17, RocketHideout2ArrowMovement31
	map_coord_movement 15, 16, RocketHideout2ArrowMovement12
	map_coord_movement 16, 14, RocketHideout2ArrowMovement32
	map_coord_movement 16, 16, RocketHideout2ArrowMovement33
	map_coord_movement 16, 18, RocketHideout2ArrowMovement34
	map_coord_movement 17, 10, RocketHideout2ArrowMovement35
	map_coord_movement 17, 11, RocketHideout2ArrowMovement36
	db -1 ; end

;format: direction, count
;each list is read starting from the $FF and working backwards
RocketHideout2ArrowMovement1:
	db PAD_LEFT, 2
	db -1 ; end

RocketHideout2ArrowMovement2:
	db PAD_RIGHT, 4
	db -1 ; end

RocketHideout2ArrowMovement3:
	db PAD_UP, 4
	db PAD_RIGHT, 4
	db -1 ; end

RocketHideout2ArrowMovement4:
	db PAD_UP, 4
	db PAD_RIGHT, 4
	db PAD_UP, 1
	db -1 ; end

RocketHideout2ArrowMovement5:
	db PAD_LEFT, 2
	db PAD_UP, 3
	db -1 ; end

RocketHideout2ArrowMovement6:
	db PAD_DOWN, 2
	db PAD_RIGHT, 4
	db -1 ; end

RocketHideout2ArrowMovement7:
	db PAD_UP, 2
	db -1 ; end

RocketHideout2ArrowMovement8:
	db PAD_UP, 4
	db -1 ; end

RocketHideout2ArrowMovement9:
	db PAD_LEFT, 6
	db -1 ; end

RocketHideout2ArrowMovement10:
	db PAD_UP, 1
	db -1 ; end

RocketHideout2ArrowMovement11:
	db PAD_LEFT, 6
	db PAD_UP, 4
	db -1 ; end

RocketHideout2ArrowMovement12:
	db PAD_DOWN, 2
	db -1 ; end

RocketHideout2ArrowMovement13:
	db PAD_LEFT, 8
	db -1 ; end

RocketHideout2ArrowMovement14:
	db PAD_LEFT, 8
	db PAD_UP, 1
	db -1 ; end

RocketHideout2ArrowMovement15:
	db PAD_LEFT, 8
	db PAD_UP, 6
	db -1 ; end

RocketHideout2ArrowMovement16:
	db PAD_UP, 2
	db PAD_RIGHT, 4
	db -1 ; end

RocketHideout2ArrowMovement17:
	db PAD_UP, 2
	db PAD_RIGHT, 4
	db PAD_UP, 2
	db -1 ; end

RocketHideout2ArrowMovement18:
	db PAD_DOWN, 2
	db PAD_RIGHT, 4
	db PAD_DOWN, 2
	db -1 ; end

RocketHideout2ArrowMovement19:
	db PAD_DOWN, 2
	db PAD_RIGHT, 4
	db -1 ; end

RocketHideout2ArrowMovement20:
	db PAD_LEFT, 10
	db -1 ; end

RocketHideout2ArrowMovement21:
	db PAD_LEFT, 10
	db PAD_UP, 2
	db -1 ; end

RocketHideout2ArrowMovement22:
	db PAD_LEFT, 10
	db PAD_UP, 4
	db -1 ; end

RocketHideout2ArrowMovement23:
	db PAD_UP, 2
	db PAD_RIGHT, 2
	db -1 ; end

RocketHideout2ArrowMovement24:
	db PAD_RIGHT, 1
	db PAD_DOWN, 2
	db -1 ; end

RocketHideout2ArrowMovement25:
	db PAD_RIGHT, 1
	db -1 ; end

RocketHideout2ArrowMovement26:
	db PAD_DOWN, 2
	db PAD_RIGHT, 2
	db -1 ; end

RocketHideout2ArrowMovement27:
	db PAD_DOWN, 2
	db PAD_LEFT, 2
	db -1 ; end

RocketHideout2ArrowMovement28:
	db PAD_UP, 2
	db PAD_RIGHT, 4
	db PAD_UP, 2
	db PAD_LEFT, 3
	db -1 ; end

RocketHideout2ArrowMovement29:
	db PAD_DOWN, 2
	db PAD_LEFT, 4
	db -1 ; end

RocketHideout2ArrowMovement30:
	db PAD_LEFT, 6
	db PAD_UP, 4
	db PAD_LEFT, 5
	db -1 ; end

RocketHideout2ArrowMovement31:
	db PAD_UP, 2
	db -1 ; end

RocketHideout2ArrowMovement32:
	db PAD_UP, 1
	db -1 ; end

RocketHideout2ArrowMovement33:
	db PAD_UP, 3
	db -1 ; end

RocketHideout2ArrowMovement34:
	db PAD_UP, 5
	db -1 ; end

RocketHideout2ArrowMovement35:
	db PAD_RIGHT, 1
	db PAD_DOWN, 2
	db PAD_LEFT, 4
	db -1 ; end

RocketHideout2ArrowMovement36:
	db PAD_LEFT, 10
	db PAD_UP, 2
	db PAD_LEFT, 5
	db -1 ; end

RocketHideoutB2FGreenTriggerCoords:
	dbmapcoord 24, 18
	dbmapcoord 25, 18
	db -1 ; end

; From object at (21,22) toward player on trigger row (variant sets final east count).
RocketHideoutB2FGreenApproachFrom24:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

RocketHideoutB2FGreenApproachFrom25:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

RocketHideoutB2FGreenBattleScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	call RocketHideoutB2FGreenFacePlayer
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_ROCKETHIDEOUTB2F_GREEN_BATTLE_INTRO
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, RocketHideoutB2FGreenEndBattleText
	ld de, RocketHideoutB2FGreenPlayerLoseText
	call SaveEndBattleTextPointers
	ld a, [wPlayerStarter]
	cp STARTER1
	jr z, .picked_charmander
	cp STARTER2
	jr z, .picked_squirtle
	ld a, 3
	jr .got_team
.picked_charmander
	ld a, 1
	jr .got_team
.picked_squirtle
	ld a, 2
.got_team
	ld [wTrainerNo], a
	ld a, OPP_GREEN_ROCKET
	ld [wCurOpponent], a
	ld [wEnemyMonOrTrainerClass], a
	ld a, SCRIPT_ROCKETHIDEOUTB2F_GREEN_AFTER_BATTLE
	ld [wRocketHideoutB2FCurScript], a
	ld [wCurMapScript], a
	ld hl, wStatusFlags4
	set BIT_UNKNOWN_4_1, [hl]
	xor a
	ld [wJoyIgnore], a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ret

RocketHideoutB2FGreenAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, RocketHideoutB2FGreenBattleCancelled
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	call RocketHideoutB2FGreenFacePlayer
	SetEvent EVENT_BEAT_ROCKET_HIDEOUT_B2F_GREEN
	ld a, TEXT_ROCKETHIDEOUTB2F_GREEN_POST_BATTLE
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, [wRocketHideoutB2FGreenVariant]
	cp 1
	jr z, .greenExitFrom24
	cp 2
	jr z, .greenExitFrom25
	ld de, RocketHideoutB2FGreenExitFrom25
	jr .greenDoExit
.greenExitFrom24
	ld de, RocketHideoutB2FGreenExitFrom24
	jr .greenDoExit
.greenExitFrom25
	ld de, RocketHideoutB2FGreenExitFrom25
.greenDoExit
	ld a, ROCKETHIDEOUTB2F_GREEN
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_ROCKETHIDEOUTB2F_GREEN_EXIT
	ld [wRocketHideoutB2FCurScript], a
	ld [wCurMapScript], a
	ret

; After battle when triggered from (24,18)
RocketHideoutB2FGreenExitFrom24:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

; After battle when triggered from (25,18)
RocketHideoutB2FGreenExitFrom25:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

RocketHideoutB2FGreenBattleCancelled:
	xor a
	ld [wJoyIgnore], a
	ld [wRocketHideoutB2FCurScript], a
	ld [wCurMapScript], a
	ret

RocketHideoutB2FGreenExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, TOGGLE_ROCKET_HIDEOUT_B2F_GREEN
	ld [wToggleableObjectIndex], a
	predef HideObject
	xor a
	ld [wJoyIgnore], a
	call PlayDefaultMusic
	ld [wRocketHideoutB2FCurScript], a
	ld [wCurMapScript], a
	ret

RocketHideoutB2FGreenFacePlayer:
; Face the player using map coords (works from (21,22) and after scripted approach).
	ld hl, wSpriteStateData2
	ld a, ROCKETHIDEOUTB2F_GREEN
	swap a
	add l
	ld l, a
	ld a, h
	adc 0
	ld h, a
	ld de, SPRITESTATEDATA2_MAPY
	add hl, de
	ld a, [hl]
	sub 4
	ld b, a
	ld a, [wYCoord]
	cp b
	jr z, .greenFaceSameMapY
	jr c, .greenFacePlayerNorth
	ld a, SPRITE_FACING_DOWN
	jr RocketHideoutB2FGreenSetFacing
.greenFacePlayerNorth
	ld a, SPRITE_FACING_UP
	jr RocketHideoutB2FGreenSetFacing
.greenFaceSameMapY
	inc hl
	ld a, [hl]
	sub 4
	ld b, a
	ld a, [wXCoord]
	cp b
	jr z, .greenFaceSameTile
	jr c, .greenFacePlayerWest
	ld a, SPRITE_FACING_RIGHT
	jr RocketHideoutB2FGreenSetFacing
.greenFacePlayerWest
	ld a, SPRITE_FACING_LEFT
	jr RocketHideoutB2FGreenSetFacing
.greenFaceSameTile
	ld a, SPRITE_FACING_DOWN
RocketHideoutB2FGreenSetFacing:
	ldh [hSpriteFacingDirection], a
	ld a, ROCKETHIDEOUTB2F_GREEN
	ldh [hSpriteIndex], a
	jp SetSpriteFacingDirectionAndDelay

RocketHideoutB2FPlayerSpinningScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	jr nz, LoadSpinnerArrowTiles
	xor a
	ld [wJoyIgnore], a
	ld hl, wMovementFlags
	res BIT_SPINNING, [hl]
	ld a, SCRIPT_ROCKETHIDEOUTB2F_DEFAULT
	ld [wCurMapScript], a
	ld [wRocketHideoutB2FCurScript], a
	ret

INCLUDE "engine/overworld/spinners.asm"

RocketHideoutB2F_TextPointers:
	def_text_pointers
	dw_const RocketHideoutB2FRocketText, TEXT_ROCKETHIDEOUTB2F_ROCKET
	dw_const PickUpItemText,             TEXT_ROCKETHIDEOUTB2F_MOON_STONE
	dw_const PickUpItemText,             TEXT_ROCKETHIDEOUTB2F_NUGGET
	dw_const RocketHideoutB2FTM07ShadowBallText, TEXT_ROCKETHIDEOUTB2F_TM_SHADOW_BALL
	dw_const PickUpItemText,             TEXT_ROCKETHIDEOUTB2F_SUPER_POTION
	dw_const RocketHideoutB2FGreenPlaceholderText, TEXT_ROCKETHIDEOUTB2F_GREEN
	dw_const RocketHideoutB2FGreenPostBattleDisplayText, TEXT_ROCKETHIDEOUTB2F_GREEN_POST_BATTLE
	dw_const RocketHideoutB2FGreenBattleIntroText, TEXT_ROCKETHIDEOUTB2F_GREEN_BATTLE_INTRO

RocketHideout2TrainerHeaders:
	def_trainers
RocketHideout2TrainerHeader0:
	trainer EVENT_BEAT_ROCKET_HIDEOUT_2_TRAINER_0, 4, RocketHideoutB2FRocketBattleText, RocketHideoutB2FRocketEndBattleText, RocketHideoutB2FRocketAfterBattleText
	db -1 ; end

RocketHideoutB2FRocketText:
	text_asm
	ld hl, RocketHideout2TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

RocketHideoutB2FRocketBattleText:
	text_far _RocketHideoutB2FRocketBattleText
	text_end

RocketHideoutB2FRocketEndBattleText:
	text_far _RocketHideoutB2FRocketEndBattleText
	text_end

RocketHideoutB2FRocketAfterBattleText:
	text_far _RocketHideoutB2FRocketAfterBattleText
	text_end

RocketHideoutB2FTM07ShadowBallText:
	text_asm
	call EnableAutoTextBoxDrawing

	; Copy of engine/events/pick_up_item.asm::PickUpItem, but with custom found text
	ldh a, [hSpriteIndex]
	ld b, a
	ld hl, wToggleableObjectList
.toggleableObjectsListLoop
	ld a, [hli]
	cp $ff
	jp z, TextScriptEnd
	cp b
	jr z, .isToggleable
	inc hl
	jr .toggleableObjectsListLoop

.isToggleable
	ld a, [hl]
	ldh [hToggleableObjectIndex], a

	ld hl, wMapSpriteExtraData
	ldh a, [hSpriteIndex]
	dec a
	add a
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	ld b, a ; item
	ld c, 1 ; quantity
	call GiveItem
	jr nc, .BagFull

	ldh a, [hToggleableObjectIndex]
	ld [wToggleableObjectIndex], a
	predef HideObject
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, RocketHideoutB2FFoundTM07ShadowBallText
	jr .print

.BagFull
	ld hl, NoMoreRoomForItemText
.print
	call PrintText
	jp TextScriptEnd

RocketHideoutB2FFoundTM07ShadowBallText:
	text_far _RocketHideoutB2FFoundTM07ShadowBallText
	sound_get_item_1
	text_end

RocketHideoutB2FGreenPlaceholderText:
	text_asm
	jp TextScriptEnd

RocketHideoutB2FGreenBattleIntroText:
	text_asm
	call EnableAutoTextBoxDrawing
	ld hl, RocketHideoutB2FGreenBeforeBattleText
	call PrintText
	jp TextScriptEnd

RocketHideoutB2FGreenPostBattleDisplayText:
	text_far _RocketHideoutB2FGreenPostBattleText
	text_end

RocketHideoutB2FGreenBeforeBattleText:
	text_far _RocketHideoutB2FGreenBeforeBattleText
	text_end

RocketHideoutB2FGreenEndBattleText:
	text_far _RocketHideoutB2FGreenEndBattleText
	text_end

RocketHideoutB2FGreenPlayerLoseText:
	text_far _RocketHideoutB2FGreenPlayerLoseText
	text_end
