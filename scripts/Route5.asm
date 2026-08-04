Route5_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route5_ScriptPointers
	ld a, [wCurMapScript]
	cp 3
	jr c, .script_ok
	xor a
	ld [wCurMapScript], a
.script_ok
	jp CallFunctionInTable

Route5_ScriptPointers:
	def_script_pointers
	dw_const Route5DefaultScript,     SCRIPT_ROUTE5_DEFAULT
	dw_const Route5AfterBattleScript, SCRIPT_ROUTE5_AFTER_BATTLE
	dw_const Route5GreenExitScript,   SCRIPT_ROUTE5_GREEN_EXIT

Route5ResetScript:
	xor a ; SCRIPT_ROUTE5_DEFAULT
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

Route5DefaultScript:
	ret

Route5AfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route5ResetScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	call PlayGreenEncounterMusic
	SetEvent EVENT_BEAT_ROUTE5_GREEN
	ld a, TEXT_ROUTE5_GREEN
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, ROUTE5_GREEN
	ldh [hSpriteIndex], a
	ld de, Route5GreenExitMovement
	call MoveSprite
	ld a, SCRIPT_ROUTE5_GREEN_EXIT
	ld [wCurMapScript], a
	ret

Route5GreenExitMovement:
	db NPC_MOVEMENT_UP
	db -1 ; end

Route5GreenExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld de, TOGGLE_ROUTE_5_GREEN
	predef HideObject
	call EndGreenEncounterMusic
	jp Route5ResetScript

Route5_TextPointers:
	def_text_pointers
	dw_const Route5GreenText,               TEXT_ROUTE5_GREEN
	dw_const Route5UndergroundPathSignText, TEXT_ROUTE5_UNDERGROUND_PATH_SIGN

Route5GreenText:
	text_asm
	CheckEvent EVENT_BEAT_ROUTE5_GREEN
	jr z, .before_battle
	ld hl, Route5GreenAfterBattleText
	call PrintText
	jr .done
.before_battle
	call PlayGreenEncounterMusic
	ld hl, Route5GreenBeforeBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, Route5GreenEndBattleText
	ld de, Route5GreenPlayerLoseText
	call SaveEndBattleTextPointers
	ld a, OPP_GREEN
	ld [wCurOpponent], a
	ld a, [wPlayerStarter]
	cp STARTER1
	jr z, .picked_charmander
	cp STARTER2
	jr z, .picked_squirtle
	ld a, 3 ; player picked Bulbasaur, Green has Squirtle
	jr .got_team
.picked_charmander
	ld a, 1 ; player picked Charmander, Green has Bulbasaur
	jr .got_team
.picked_squirtle
	ld a, 2 ; player picked Squirtle, Green has Charmander
.got_team
	ld [wTrainerNo], a
	ld a, SCRIPT_ROUTE5_AFTER_BATTLE
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

Route5GreenBeforeBattleText:
	text_far _Route5GreenBeforeBattleText
	text_end

Route5GreenEndBattleText:
	text_far _Route5GreenEndBattleText
	text_end

Route5GreenPlayerLoseText:
	text_far _Route5GreenPlayerLoseText
	text_end

Route5GreenAfterBattleText:
	text_far _Route5GreenAfterBattleText
	text_end

Route5UndergroundPathSignText:
	text_far _Route5UndergroundPathSignText
	text_end
