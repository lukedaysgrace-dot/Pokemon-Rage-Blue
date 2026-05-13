PalletTown_Script:
	CheckEvent EVENT_GOT_POKEBALLS_FROM_OAK
	jr z, .next
	SetEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS
.next
	call PalletTownUpdateGreenVisibility
	call EnableAutoTextBoxDrawing
	ld hl, PalletTown_ScriptPointers
	ld a, [wPalletTownCurScript]
	jp CallFunctionInTable

PalletTown_ScriptPointers:
	def_script_pointers
	dw_const PalletTownDefaultScript,              SCRIPT_PALLETTOWN_DEFAULT
	dw_const PalletTownOakHeyWaitScript,           SCRIPT_PALLETTOWN_OAK_HEY_WAIT
	dw_const PalletTownOakWalksToPlayerScript,     SCRIPT_PALLETTOWN_OAK_WALKS_TO_PLAYER
	dw_const PalletTownOakNotSafeComeWithMeScript, SCRIPT_PALLETTOWN_OAK_NOT_SAFE_COME_WITH_ME
	dw_const PalletTownPlayerFollowsOakScript,     SCRIPT_PALLETTOWN_PLAYER_FOLLOWS_OAK
	dw_const PalletTownDaisyScript,                SCRIPT_PALLETTOWN_DAISY
	dw_const PalletTownNoopScript,                 SCRIPT_PALLETTOWN_NOOP
	dw_const PalletTownGreenAfterBattleScript,     SCRIPT_PALLETTOWN_GREEN_AFTER_BATTLE
	dw_const PalletTownGreenExitScript,            SCRIPT_PALLETTOWN_GREEN_EXIT

PalletTownDefaultScript:
	CheckEvent EVENT_FOLLOWED_OAK_INTO_LAB
	ret nz
	ld a, [wYCoord]
	cp 1 ; is player near north exit?
	ret nz
	xor a
	ldh [hJoyHeld], a
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, SFX_STOP_ALL_MUSIC
	call PlaySound
	ld a, BANK(Music_MeetProfOak)
	ld c, a
	ld a, MUSIC_MEET_PROF_OAK ; "oak appears" music
	call PlayMusic
	ld a, PAD_SELECT | PAD_START | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	SetEvent EVENT_OAK_APPEARED_IN_PALLET

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_OAK_HEY_WAIT
	ld [wPalletTownCurScript], a
	ret

PalletTownOakHeyWaitScript:
	xor a
	ld [wOakWalkedToPlayer], a
	ld a, TEXT_PALLETTOWN_OAK
	ldh [hTextID], a
	call DisplayTextID
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TOGGLE_PALLET_TOWN_OAK
	ld [wToggleableObjectIndex], a
	predef ShowObject

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_OAK_WALKS_TO_PLAYER
	ld [wPalletTownCurScript], a
	ret

PalletTownOakWalksToPlayerScript:
	ld a, PALLETTOWN_OAK
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	call Delay3
	ld a, 1
	ld [wYCoord], a
	ld a, 1
	ldh [hNPCPlayerRelativePosPerspective], a
	ld a, 1
	swap a
	ldh [hNPCSpriteOffset], a
	predef CalcPositionOfPlayerRelativeToNPC
	ld hl, hNPCPlayerYDistance
	dec [hl]
	predef FindPathToPlayer ; load Oak's movement into wNPCMovementDirections2
	ld de, wNPCMovementDirections2
	ld a, PALLETTOWN_OAK
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_OAK_NOT_SAFE_COME_WITH_ME
	ld [wPalletTownCurScript], a
	ret

PalletTownOakNotSafeComeWithMeScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a ; ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, TRUE
	ld [wOakWalkedToPlayer], a
	ld a, PAD_SELECT | PAD_START | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_PALLETTOWN_OAK
	ldh [hTextID], a
	call DisplayTextID
; set up movement script that causes the player to follow Oak to his lab
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, PALLETTOWN_OAK
	ld [wSpriteIndex], a
	xor a
	ld [wNPCMovementScriptFunctionNum], a
	ld a, 1
	ld [wNPCMovementScriptPointerTableNum], a
	ldh a, [hLoadedROMBank]
	ld [wNPCMovementScriptBank], a

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_PLAYER_FOLLOWS_OAK
	ld [wPalletTownCurScript], a
	ret

PalletTownPlayerFollowsOakScript:
	ld a, [wNPCMovementScriptPointerTableNum]
	and a ; is the movement script over?
	ret nz

	; trigger the next script
	ld a, SCRIPT_PALLETTOWN_DAISY
	ld [wPalletTownCurScript], a
	ret

PalletTownDaisyScript:
	CheckEvent EVENT_DAISY_WALKING
	jr nz, .next
	CheckBothEventsSet EVENT_GOT_TOWN_MAP, EVENT_ENTERED_BLUES_HOUSE, 1
	jr nz, .next
	SetEvent EVENT_DAISY_WALKING
	ld a, TOGGLE_DAISY_SITTING
	ld [wToggleableObjectIndex], a
	predef HideObject
	ld a, TOGGLE_DAISY_WALKING
	ld [wToggleableObjectIndex], a
	predef_jump ShowObject
.next
	CheckEvent EVENT_GOT_POKEBALLS_FROM_OAK
	ret z
	SetEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS_2
PalletTownNoopScript:
	ret

PalletTownGreenAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jr z, .reset
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_PALLET_TOWN_GREEN
	ld a, TEXT_PALLETTOWN_GREEN
	ldh [hTextID], a
	call DisplayTextID
	ld a, TOGGLE_PALLET_TOWN_MEW
	ld [wToggleableObjectIndex], a
	predef ShowObject
	call UpdateSprites
	ld a, TEXT_PALLETTOWN_MEW_CRY
	ldh [hTextID], a
	call DisplayTextID
	ld a, MEW
	call PlayCry
	call WaitForSoundToFinish
	ld a, TOGGLE_PALLET_TOWN_MEW
	ld [wToggleableObjectIndex], a
	predef HideObject
	call UpdateSprites
	ld a, TEXT_PALLETTOWN_GREEN_AFTER_MEW
	ldh [hTextID], a
	call DisplayTextID
	ld de, PalletTownGreenExitMovementDefault
	ld a, [wYCoord]
	cp 13
	jr nz, .checkAboveTile
	ld a, [wXCoord]
	cp 5
	jr nz, .checkAboveTile
	ld de, PalletTownGreenExitMovementFromRight
	jr .gotExitMovement
.checkAboveTile
	ld a, [wYCoord]
	cp 12
	jr nz, .gotExitMovement
	ld a, [wXCoord]
	cp 4
	jr nz, .gotExitMovement
	ld de, PalletTownGreenExitMovementFromAbove
.gotExitMovement
	ld a, PALLETTOWN_GREEN
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_PALLETTOWN_GREEN_EXIT
	ld [wPalletTownCurScript], a
	ret
.reset
	xor a ; SCRIPT_PALLETTOWN_DEFAULT
	ld [wJoyIgnore], a
	ld [wPalletTownCurScript], a
	ret

PalletTownGreenExitMovementDefault:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

PalletTownGreenExitMovementFromRight:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

PalletTownGreenExitMovementFromAbove:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

PalletTownGreenExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, TOGGLE_PALLET_TOWN_GREEN
	ld [wToggleableObjectIndex], a
	predef HideObject
.reset
	xor a ; SCRIPT_PALLETTOWN_DEFAULT
	ld [wJoyIgnore], a
	ld [wPalletTownCurScript], a
	ret

PalletTownUpdateGreenVisibility:
	call PalletTownShouldShowGreen
	ld d, a
	ld a, PALLETTOWN_GREEN
	swap a
	ldh [hCurrentSpriteOffset], a
	predef IsObjectHidden
	ld a, d
	and a
	jr z, .hide
.show
	ldh a, [hIsToggleableObjectOff]
	and a
	ret z
	ld a, TOGGLE_PALLET_TOWN_GREEN
	ld [wToggleableObjectIndex], a
	predef_jump ShowObject
.hide
	ldh a, [hIsToggleableObjectOff]
	and a
	ret nz
	ld a, TOGGLE_PALLET_TOWN_GREEN
	ld [wToggleableObjectIndex], a
	predef_jump HideObject

PalletTownShouldShowGreen:
	CheckEvent EVENT_REMATCH_DEFEATED_RIVAL_CHAMPION
	jr z, .hide
	CheckEvent EVENT_BEAT_PALLET_TOWN_GREEN
	jr nz, .hide
	call PalletTownOriginal150PokedexComplete
	jr nc, .hide
	ld a, TRUE
	ret
.hide
	xor a
	ret

; Returns carry if the original 150 Pokédex entries are owned.
; Mew (#151, bit 6 of byte 18) is intentionally ignored.
PalletTownOriginal150PokedexComplete:
	ld hl, wPokedexOwned
	ld b, 18
.checkFullBytes
	ld a, [hli]
	cp $ff
	jr nz, .notComplete
	dec b
	jr nz, .checkFullBytes
	ld a, [hl]
	and %00111111
	cp %00111111
	jr nz, .notComplete
	scf
	ret
.notComplete
	and a
	ret

PalletTown_TextPointers:
	def_text_pointers
	dw_const PalletTownOakText,              TEXT_PALLETTOWN_OAK
	dw_const PalletTownGirlText,             TEXT_PALLETTOWN_GIRL
	dw_const PalletTownFisherText,           TEXT_PALLETTOWN_FISHER
	dw_const PalletTownGreenText,            TEXT_PALLETTOWN_GREEN
	dw_const PalletTownMewText,              TEXT_PALLETTOWN_MEW
	dw_const PalletTownOaksLabSignText,      TEXT_PALLETTOWN_OAKSLAB_SIGN
	dw_const PalletTownSignText,             TEXT_PALLETTOWN_SIGN
	dw_const PalletTownPlayersHouseSignText, TEXT_PALLETTOWN_PLAYERSHOUSE_SIGN
	dw_const PalletTownRivalsHouseSignText,  TEXT_PALLETTOWN_RIVALSHOUSE_SIGN
	dw_const PalletTownMewCryText,           TEXT_PALLETTOWN_MEW_CRY
	dw_const PalletTownGreenAfterMewText,    TEXT_PALLETTOWN_GREEN_AFTER_MEW

PalletTownOakText:
	text_asm
	ld a, [wOakWalkedToPlayer]
	and a
	jr nz, .next
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, .HeyWaitDontGoOutText
	jr .done
.next
	ld hl, .ItsUnsafeText
.done
	call PrintText
	jp TextScriptEnd

.HeyWaitDontGoOutText:
	text_far _PalletTownOakHeyWaitDontGoOutText
	text_asm
	ld c, 10
	call DelayFrames
	xor a
	ld [wEmotionBubbleSpriteIndex], a ; player's sprite
	ld [wWhichEmotionBubble], a ; EXCLAMATION_BUBBLE
	predef EmotionBubble
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	jp TextScriptEnd

.ItsUnsafeText:
	text_far _PalletTownOakItsUnsafeText
	text_end

PalletTownGirlText:
	text_far _PalletTownGirlText
	text_end

PalletTownFisherText:
	text_far _PalletTownFisherText
	text_end

PalletTownGreenText:
	text_asm
	CheckEvent EVENT_BEAT_PALLET_TOWN_GREEN
	jr z, .beforeBattle
	ld hl, PalletTownGreenAfterBattleText
	call PrintText
	jr .done
.beforeBattle
	call PlayGreenEncounterMusic
	ld hl, PalletTownGreenBeforeBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, PalletTownGreenEndBattleText
	ld de, PalletTownGreenPlayerLoseText
	call SaveEndBattleTextPointers
	ld a, OPP_GREEN
	ld [wCurOpponent], a
	ld a, 16
	ld [wTrainerNo], a
	ld a, SCRIPT_PALLETTOWN_GREEN_AFTER_BATTLE
	ld [wPalletTownCurScript], a
.done
	jp TextScriptEnd

PalletTownGreenBeforeBattleText:
	text "I had a feeling"
	line "you'd come back"
	cont "here eventually."

	para "Funny, isn't it?"

	para "After everything"
	line "that happened..."
	cont "we ended up"
	cont "right back in"
	cont "PALLET TOWN."

	para "Back where this"
	line "all started."

	para "I've been"
	line "waiting for you."

	para "And all that"
	line "searching finally"
	cont "paid off."

	para "Hehe... yeah."

	para "I found it."

	para "MEW."

	para "Turns out"
	line "chasing legends"
	cont "across KANTO,"
	cont "diving into"
	cont "ruins, and"
	cont "nearly getting"
	cont "myself killed..."

	para "Actually paid"
	line "off."

	para "But the funny"
	line "thing?"

	para "The legendary"
	line "birds never"
	cont "mattered."

	para "ARTICUNO,"
	line "ZAPDOS,"
	cont "MOLTRES..."
	cont "I let them"
	cont "all go."

	para "At some point"
	line "I realized I"
	cont "wasn't catching"
	cont "them because it"
	cont "meant something."

	para "I was just"
	line "hoping they'd"
	cont "lead me to"
	cont "answers."

	para "To MEW."

	para "And in the"
	line "end... MEW was"
	cont "never something"
	cont "I could force."

	para "You understand"
	line "that, don't you?"

	para "It's not like"
	line "MEWTWO."

	para "It doesn't"
	line "belong in a lab."
	cont "Or a cage."

	para "Hehe..."
	line "honestly, I"
	cont "think it chose"
	cont "to appear"
	cont "because it"
	cont "wanted to."

	para "And after"
	line "everything we've"
	cont "both been"
	cont "through..."

	para "I think it"
	line "wanted to meet"
	cont "the trainer who"
	cont "changed KANTO."

	para "So."

	para "One last battle."

	para "No distractions."
	line "No ELITE FOUR"
	cont "standing behind"
	cont "us."

	para "Just you and me."
	done

PalletTownGreenEndBattleText:
	text "I can't believe"
	line "it... even with"
	cont "MEW by my side."
	prompt

PalletTownGreenPlayerLoseText:
	text "Come back when"
	line "you're ready."
	done

PalletTownGreenAfterBattleText:
	text "So that's my"
	line "answer."

	para "Even with MEW"
	line "at my side..."
	cont "I still"
	cont "couldn't"
	cont "beat you."

	para "But honestly?"

	para "I think I"
	line "understand now."

	para "MEW was never"
	line "meant to belong"
	cont "to anyone."

	para "It's too free"
	line "for that."

	para "Too curious."

	para "Too... alive."

	para "Hehe..."
	line "maybe that's"
	cont "why it came"
	cont "willingly in"
	cont "the first"
	cont "place."

	para "Not to be"
	line "caught."

	para "Just to see us."

	para "To see how far"
	line "two kids from"
	cont "PALLET TOWN"
	cont "would go."

	para "...I think it's"
	line "time."

	para "Go on, MEW."

	para "You don't have"
	line "to stay anymore."
	done

PalletTownOaksLabSignText:
	text_far _PalletTownOaksLabSignText
	text_end

PalletTownSignText:
	text_far _PalletTownSignText
	text_end

PalletTownPlayersHouseSignText:
	text_far _PalletTownPlayersHouseSignText
	text_end

PalletTownRivalsHouseSignText:
	text_far _PalletTownRivalsHouseSignText
	text_end

PalletTownMewText:
	text_asm
	jp TextScriptEnd

PalletTownMewCryText:
	text "Mew!"
	done

PalletTownGreenAfterMewText:
	text "Guess some"
	line "legends aren't"
	cont "supposed to be"
	cont "kept."

	para "But I'm glad I"
	line "got to meet it."

	para "And I'm glad you"
	line "were here to see"
	cont "the end of this"
	cont "journey with me."

	para "...Look."

	para "It's flying"
	line "east."

	para "I wonder what's"
	line "waiting for it"
	cont "out there."

	para "I'll see you"
	line "around, <PLAYER>."
	done
