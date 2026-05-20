Route1_Script:
	; Do not hide Oak while the post-battle walk runs (EVENT_BEAT_ROUTE1_OAK is set
	; only after he leaves; hiding early breaks MoveSprite and locks the player).
	ld a, [wCurMapScript]
	cp SCRIPT_ROUTE1_AFTER_BATTLE
	jr z, .skipOakVisibility
	cp SCRIPT_ROUTE1_OAK_EXIT
	jr z, .skipOakVisibility
	call Route1UpdateOakVisibility
.skipOakVisibility
	call EnableAutoTextBoxDrawing
	ld hl, Route1_ScriptPointers
	ld a, [wCurMapScript]
	cp 3
	jr c, .script_ok
	xor a
	ld [wCurMapScript], a
.script_ok
	jp CallFunctionInTable

Route1_ScriptPointers:
	def_script_pointers
	dw_const Route1DefaultScript,     SCRIPT_ROUTE1_DEFAULT
	dw_const Route1AfterBattleScript, SCRIPT_ROUTE1_AFTER_BATTLE
	dw_const Route1OakExitScript,     SCRIPT_ROUTE1_OAK_EXIT

Route1ResetScript:
	xor a ; SCRIPT_ROUTE1_DEFAULT
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

Route1DefaultScript:
	ret

Route1AfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route1ResetScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	; Set before DisplayTextID — Route1OakText checks this flag and would
	; start another fight if it is still clear (see Route5GreenText).
	SetEvent EVENT_BEAT_ROUTE1_OAK
	ld a, TEXT_ROUTE1_OAK
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld de, Route1OakExitMovementDefault
	ld a, [wYCoord]
	cp 29 ; tile directly below Oak (11, 28)
	jr nz, .gotExitMovement
	ld a, [wXCoord]
	cp 11
	jr nz, .gotExitMovement
	ld de, Route1OakExitMovementFromBelow
.gotExitMovement
	ld a, ROUTE1_OAK
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_ROUTE1_OAK_EXIT
	ld [wCurMapScript], a
	ret

Route1OakExitMovementDefault:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

Route1OakExitMovementFromBelow:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

Route1OakExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, TOGGLE_ROUTE_1_OAK
	ld [wToggleableObjectIndex], a
	predef HideObject
	jp Route1ResetScript

Route1UpdateOakVisibility:
	CheckEvent EVENT_BEAT_ROUTE1_OAK
	jr nz, .hideOak
	call Route1DexComplete151
	jr nc, .hideOak
.showOak
	ld a, ROUTE1_OAK
	swap a
	ldh [hCurrentSpriteOffset], a
	predef IsObjectHidden
	ldh a, [hIsToggleableObjectOff]
	and a
	ret z
	ld a, TOGGLE_ROUTE_1_OAK
	ld [wToggleableObjectIndex], a
	predef_jump ShowObject
.hideOak
	ld a, ROUTE1_OAK
	swap a
	ldh [hCurrentSpriteOffset], a
	predef IsObjectHidden
	ldh a, [hIsToggleableObjectOff]
	and a
	ret nz
	ld a, TOGGLE_ROUTE_1_OAK
	ld [wToggleableObjectIndex], a
	predef_jump HideObject

; Own all 151 Kanto dex entries (#1–#151), including MEW.
Route1DexComplete151:
	ld c, 0
.loop
	push bc
	ld b, FLAG_TEST
	ld hl, wPokedexOwned
	ld a, c
	ld c, a
	predef FlagActionPredef
	ld a, c
	pop bc
	and a
	jr z, .incomplete
	inc c
	ld a, c
	cp DEX_MEW
	jr c, .loop
	scf
	ret
.incomplete
	and a
	ret

Route1_TextPointers:
	def_text_pointers
	dw_const Route1Youngster1Text, TEXT_ROUTE1_YOUNGSTER1
	dw_const Route1Youngster2Text, TEXT_ROUTE1_YOUNGSTER2
	dw_const Route1OakText,        TEXT_ROUTE1_OAK
	dw_const Route1SignText,       TEXT_ROUTE1_SIGN

Route1Youngster1Text:
	text_asm
	CheckAndSetEvent EVENT_GOT_POTION_SAMPLE
	jr nz, .got_item
	ld hl, .MartSampleText
	call PrintText
	lb bc, POTION, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .GotPotionText
	jr .done
.bag_full
	ld hl, .NoRoomText
	jr .done
.got_item
	ld hl, .AlsoGotPokeballsText
.done
	call PrintText
	jp TextScriptEnd

.MartSampleText:
	text_far _Route1Youngster1MartSampleText
	text_end

.GotPotionText:
	text_far _Route1Youngster1GotPotionText
	sound_get_item_1
	text_end

.AlsoGotPokeballsText:
	text_far _Route1Youngster1AlsoGotPokeballsText
	text_end

.NoRoomText:
	text_far _Route1Youngster1NoRoomText
	text_end

Route1Youngster2Text:
	text_far _Route1Youngster2Text
	text_end

Route1SignText:
	text_far _Route1SignText
	text_end

Route1OakText:
	text_asm
	CheckEvent EVENT_BEAT_ROUTE1_OAK
	jr z, .beforeBattle
	ld hl, Route1OakAfterBattleText
	call PrintText
	jr .done
.beforeBattle
	ld a, BANK(Music_MeetProfOak)
	ld c, a
	ld a, MUSIC_MEET_PROF_OAK
	call PlayMusic
	ld hl, Route1OakBeforeBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, Route1OakEndBattleText
	ld de, Route1OakPlayerLoseText
	call SaveEndBattleTextPointers
	ld a, OPP_PROF_OAK
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, SCRIPT_ROUTE1_AFTER_BATTLE
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

Route1OakBeforeBattleText:
	text_far _Route1OakBeforeBattleText
	text_end

Route1OakEndBattleText:
	text_far _Route1OakEndBattleText
	text_end

Route1OakPlayerLoseText:
	text_far _Route1OakPlayerLoseText
	text_end

Route1OakAfterBattleText:
	text_far _Route1OakAfterBattleText
	text_end
