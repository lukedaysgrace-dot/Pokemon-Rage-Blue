Route10_Script:
	call EnableAutoTextBoxDrawing
	ld a, [wRoute10CurScript]
	cp SCRIPT_ROUTE10_GREEN_AFTER_BATTLE
	jr z, .skipGreenVisibility
	cp SCRIPT_ROUTE10_GREEN_EXIT
	jr z, .skipGreenVisibility
	call Route10UpdateGreenVisibility
.skipGreenVisibility
	ld hl, Route10TrainerHeaders
	ld de, Route10_ScriptPointers
	ld a, [wRoute10CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute10CurScript], a
	ret

Route10_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_ROUTE10_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_ROUTE10_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_ROUTE10_END_BATTLE
	dw_const Route10GreenAfterBattleScript,         SCRIPT_ROUTE10_GREEN_AFTER_BATTLE
	dw_const Route10GreenExitScript,                SCRIPT_ROUTE10_GREEN_EXIT

Route10_TextPointers:
	def_text_pointers
	dw_const Route10SuperNerd1Text,     TEXT_ROUTE10_SUPER_NERD1
	dw_const Route10Hiker1Text,         TEXT_ROUTE10_HIKER1
	dw_const Route10SuperNerd2Text,     TEXT_ROUTE10_SUPER_NERD2
	dw_const Route10CooltrainerF1Text,  TEXT_ROUTE10_COOLTRAINER_F1
	dw_const Route10Hiker2Text,         TEXT_ROUTE10_HIKER2
	dw_const Route10CooltrainerF2Text,  TEXT_ROUTE10_COOLTRAINER_F2
	dw_const Route10GreenText,          TEXT_ROUTE10_GREEN
	dw_const Route10RockTunnelSignText, TEXT_ROUTE10_ROCKTUNNEL_NORTH_SIGN
	dw_const PokeCenterSignText,        TEXT_ROUTE10_POKECENTER_SIGN
	dw_const Route10RockTunnelSignText, TEXT_ROUTE10_ROCKTUNNEL_SOUTH_SIGN
	dw_const Route10PowerPlantSignText, TEXT_ROUTE10_POWERPLANT_SIGN
	dw_const Route10GreenAfterBattleText, TEXT_ROUTE10_GREEN_AFTER_BATTLE

Route10TrainerHeaders:
	def_trainers
Route10TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_10_TRAINER_0, 4, Route10SuperNerd1BattleText, Route10SuperNerd1EndBattleText, Route10SuperNerd1AfterBattleText
Route10TrainerHeader1:
	trainer EVENT_BEAT_ROUTE_10_TRAINER_1, 3, Route10Hiker1BattleText, Route10Hiker1EndBattleText, Route10Hiker1AfterBattleText
Route10TrainerHeader2:
	trainer EVENT_BEAT_ROUTE_10_TRAINER_2, 4, Route10SuperNerd2BattleText, Route10SuperNerd2EndBattleText, Route10SuperNerd2AfterBattleText
Route10TrainerHeader3:
	trainer EVENT_BEAT_ROUTE_10_TRAINER_3, 3, Route10CooltrainerF1BattleText, Route10CooltrainerF1EndBattleText, Route10CooltrainerF1AfterBattleText
Route10TrainerHeader4:
	trainer EVENT_BEAT_ROUTE_10_TRAINER_4, 2, Route10Hiker2BattleText, Route10Hiker2EndBattleText, Route10Hiker2AfterBattleText
Route10TrainerHeader5:
	trainer EVENT_BEAT_ROUTE_10_TRAINER_5, 2, Route10CooltrainerF2BattleText, Route10CooltrainerF2EndBattleText, Route10CooltrainerF2AfterBattleText
	db -1 ; end

Route10SuperNerd1Text:
	text_asm
	ld hl, Route10TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route10SuperNerd1BattleText:
	text_far _Route10SuperNerd1BattleText
	text_end

Route10SuperNerd1EndBattleText:
	text_far _Route10SuperNerd1EndBattleText
	text_end

Route10SuperNerd1AfterBattleText:
	text_far _Route10SuperNerd1AfterBattleText
	text_end

Route10Hiker1Text:
	text_asm
	ld hl, Route10TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route10Hiker1BattleText:
	text_far _Route10Hiker1BattleText
	text_end

Route10Hiker1EndBattleText:
	text_far _Route10Hiker1EndBattleText
	text_end

Route10Hiker1AfterBattleText:
	text_far _Route10Hiker1AfterBattleText
	text_end

Route10SuperNerd2Text:
	text_asm
	ld hl, Route10TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route10SuperNerd2BattleText:
	text_far _Route10SuperNerd2BattleText
	text_end

Route10SuperNerd2EndBattleText:
	text_far _Route10SuperNerd2EndBattleText
	text_end

Route10SuperNerd2AfterBattleText:
	text_far _Route10SuperNerd2AfterBattleText
	text_end

Route10CooltrainerF1Text:
	text_asm
	ld hl, Route10TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route10CooltrainerF1BattleText:
	text_far _Route10CooltrainerF1BattleText
	text_end

Route10CooltrainerF1EndBattleText:
	text_far _Route10CooltrainerF1EndBattleText
	text_end

Route10CooltrainerF1AfterBattleText:
	text_far _Route10CooltrainerF1AfterBattleText
	text_end

Route10Hiker2Text:
	text_asm
	ld hl, Route10TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route10Hiker2BattleText:
	text_far _Route10Hiker2BattleText
	text_end

Route10Hiker2EndBattleText:
	text_far _Route10Hiker2EndBattleText
	text_end

Route10Hiker2AfterBattleText:
	text_far _Route10Hiker2AfterBattleText
	text_end

Route10CooltrainerF2Text:
	text_asm
	ld hl, Route10TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route10CooltrainerF2BattleText:
	text_far _Route10CooltrainerF2BattleText
	text_end

Route10CooltrainerF2EndBattleText:
	text_far _Route10CooltrainerF2EndBattleText
	text_end

Route10CooltrainerF2AfterBattleText:
	text_far _Route10CooltrainerF2AfterBattleText
	text_end

Route10RockTunnelSignText:
	text_far _Route10RockTunnelSignText
	text_end

Route10PowerPlantSignText:
	text_far _Route10PowerPlantSignText
	text_end

Route10UpdateGreenVisibility:
	call Route10ShouldShowGreen
	and a
	jr z, .hideGreen
	ld a, ROUTE10_GREEN
	swap a
	ldh [hCurrentSpriteOffset], a
	predef IsObjectHidden
	ldh a, [hIsToggleableObjectOff]
	and a
	ret z
	ld de, TOGGLE_ROUTE_10_GREEN
	predef_jump ShowObject
.hideGreen
	ld a, ROUTE10_GREEN
	swap a
	ldh [hCurrentSpriteOffset], a
	predef IsObjectHidden
	ldh a, [hIsToggleableObjectOff]
	and a
	ret nz
	ld de, TOGGLE_ROUTE_10_GREEN
	predef_jump HideObject

Route10ShouldShowGreen:
	CheckEvent EVENT_BEAT_ROUTE_10_GREEN
	jr nz, .hide
	CheckEvent EVENT_BEAT_ROUTE5_GREEN
	jr z, .hide
	ld a, TRUE
	ret
.hide
	xor a
	ret

Route10GreenAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route10ResetJoyAndMapScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	call PlayGreenEncounterMusic
	call Route10GreenFacePlayer
	SetEvent EVENT_BEAT_ROUTE_10_GREEN
	ld a, TEXT_ROUTE10_GREEN_AFTER_BATTLE
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, SPRITE_FACING_UP
	call Route10GreenSetFacingDirection
	ld de, Route10GreenExitMovement
	call MoveSprite
	ld a, SCRIPT_ROUTE10_GREEN_EXIT
	ld [wRoute10CurScript], a
	ld [wCurMapScript], a
	ret

Route10GreenExitMovement:
	db NPC_MOVEMENT_UP
	db -1 ; end

Route10GreenExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld de, TOGGLE_ROUTE_10_GREEN
	predef HideObject
	call EndGreenEncounterMusic

Route10ResetJoyAndMapScript:
	xor a
	ld [wJoyIgnore], a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld [wRoute10CurScript], a
	ld [wCurMapScript], a
	ret

Route10GreenText:
	text_asm
	call Route10GreenExclamation
	call Route10GreenFacePlayer
	CheckEvent EVENT_BEAT_ROUTE_10_GREEN
	jr z, .before_battle
	ld hl, Route10GreenAfterBattleText
	call PrintText
	jr .done
.before_battle
	call PlayGreenEncounterMusic
	ld hl, Route10GreenBeforeBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, Route10GreenEndBattleText
	ld de, Route10GreenPlayerLoseText
	call SaveEndBattleTextPointers
	ld a, OPP_GREEN
	ld [wCurOpponent], a
	ld a, [wPlayerStarter]
	cp STARTER1
	jr z, .picked_charmander
	cp STARTER2
	jr z, .picked_squirtle
	ld a, 6 ; player picked Bulbasaur, Green has Squirtle
	jr .got_team
.picked_charmander
	ld a, 4 ; player picked Charmander, Green has Bulbasaur
	jr .got_team
.picked_squirtle
	ld a, 5 ; player picked Squirtle, Green has Charmander
.got_team
	ld [wTrainerNo], a
	ld a, SCRIPT_ROUTE10_GREEN_AFTER_BATTLE
	ld [wRoute10CurScript], a
	ld [wCurMapScript], a
	ld hl, wStatusFlags7
	set BIT_USE_CUR_MAP_SCRIPT, [hl]
.done
	jp TextScriptEnd

Route10GreenFacePlayer:
	ld a, [wXCoord]
	cp 8
	jr c, .face_left
	jr nz, .face_right
	ld a, [wYCoord]
	cp 18
	jr c, .face_up
	ld a, SPRITE_FACING_DOWN
	jr .set_facing
.face_up
	ld a, SPRITE_FACING_UP
	jr .set_facing
.face_left
	ld a, SPRITE_FACING_LEFT
	jr .set_facing
.face_right
	ld a, SPRITE_FACING_RIGHT
.set_facing
	jp Route10GreenSetFacingDirection

Route10GreenSetFacingDirection:
	ldh [hSpriteFacingDirection], a
	ld a, ROUTE10_GREEN
	ldh [hSpriteIndex], a
	jp SetSpriteFacingDirectionAndDelay

Route10GreenExclamation:
	ld a, ROUTE10_GREEN
	ld [wEmotionBubbleSpriteIndex], a
	xor a ; EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	call ReloadMapSpriteTilePatterns
	ret

Route10GreenBeforeBattleText:
	text_far _Route10GreenBeforeBattleText
	text_end

Route10GreenEndBattleText:
	text_far _Route10GreenEndBattleText
	text_end

Route10GreenPlayerLoseText:
	text_far _Route10GreenPlayerLoseText
	text_end

Route10GreenAfterBattleText:
	text_far _Route10GreenAfterBattleText
	text_end
