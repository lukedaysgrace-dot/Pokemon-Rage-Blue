IndigoPlateauLobby_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	call EnableAutoTextBoxDrawing
	ld hl, IndigoPlateauLobby_ScriptPointers
	ld a, [wCurMapScript]
	cp 5
	jr c, .script_ok
	xor a
	ld [wCurMapScript], a
.script_ok
	and a
	jr nz, .run_script
	call IndigoPlateauLobbyHideGreen
.run_script
	ld hl, IndigoPlateauLobby_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

IndigoPlateauLobbyHideGreen:
	ld a, INDIGOPLATEAULOBBY_GREEN
	swap a
	ldh [hCurrentSpriteOffset], a
	predef IsObjectHidden
	ldh a, [hIsToggleableObjectOff]
	and a
	ret nz
	ld a, TOGGLE_INDIGO_PLATEAU_LOBBY_GREEN
	ld [wToggleableObjectIndex], a
	predef_jump HideObject

IndigoPlateauLobby_ScriptPointers:
	def_script_pointers
	dw_const IndigoPlateauLobbyDefaultScript,          SCRIPT_INDIGOPLATEAULOBBY_DEFAULT
	dw_const IndigoPlateauLobbyGreenAppearsScript,     SCRIPT_INDIGOPLATEAULOBBY_GREEN_APPEARS
	dw_const IndigoPlateauLobbyGreenApproachScript,    SCRIPT_INDIGOPLATEAULOBBY_GREEN_APPROACH
	dw_const IndigoPlateauLobbyGreenAfterBattleScript, SCRIPT_INDIGOPLATEAULOBBY_GREEN_AFTER_BATTLE
	dw_const IndigoPlateauLobbyGreenExitScript,        SCRIPT_INDIGOPLATEAULOBBY_GREEN_EXIT

IndigoPlateauLobbyDefaultScript:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_2, [hl]
	res BIT_CUR_MAP_LOADED_2, [hl]
	jr z, .check_trigger
	ResetEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	; Reset Elite Four events if the player started challenging them before
	ld hl, wElite4Flags
	bit BIT_STARTED_ELITE_4, [hl]
	res BIT_STARTED_ELITE_4, [hl]
	jr z, .check_trigger
	ResetEventRange INDIGO_PLATEAU_EVENTS_START, EVENT_LANCES_ROOM_LOCK_DOOR
	; New run: allow passage to CHAMPIONS_ROOM after Lance until rival is beaten again
	ResetEvent EVENT_REMATCH_DEFEATED_RIVAL_CHAMPION

.check_trigger
	ld a, [wNumHoFTeams]
	and a
	jr nz, .suppress_green
	CheckEvent EVENT_BEAT_CHAMPION_RIVAL
	jr z, .check_green
.suppress_green
	SetEvent EVENT_BEAT_INDIGO_PLATEAU_GREEN
	ret

.check_green
	CheckEvent EVENT_BEAT_INDIGO_PLATEAU_GREEN
	ret nz
	ld hl, IndigoPlateauLobbyGreenTriggerCoords
	call ArePlayerCoordsInArray
	ret nc
	ld a, [wCoordIndex]
	ld [wSavedCoordIndex], a
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, SCRIPT_INDIGOPLATEAULOBBY_GREEN_APPEARS
	ld [wCurMapScript], a
	ret

IndigoPlateauLobbyGreenTriggerCoords:
	dbmapcoord  3, 2
	db -1

IndigoPlateauLobbyGreenAppearsScript:
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	call IndigoPlateauLobbySetGreenStartCoords
	ld a, TOGGLE_INDIGO_PLATEAU_LOBBY_GREEN
	ld [wToggleableObjectIndex], a
	predef ShowObject
	call IndigoPlateauLobbyGreenFacePlayer
	call UpdateSprites
	ld c, 12
	call DelayFrames
	xor a ; player sprite
	ld [wEmotionBubbleSpriteIndex], a
	ld [wWhichEmotionBubble], a ; EXCLAMATION_BUBBLE
	predef EmotionBubble
	call PlayGreenEncounterMusic
	ld de, IndigoPlateauLobbyGreenApproachMovement
	ld a, INDIGOPLATEAULOBBY_GREEN
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_INDIGOPLATEAULOBBY_GREEN_APPROACH
	ld [wCurMapScript], a
	ret

IndigoPlateauLobbyGreenApproachMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

IndigoPlateauLobbyGreenApproachScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	call IndigoPlateauLobbyGreenFacePlayer
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_INDIGOPLATEAULOBBY_GREEN_BATTLE_INTRO
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ld [wJoyIgnore], a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, IndigoPlateauLobbyGreenEndBattleText
	ld de, IndigoPlateauLobbyGreenPlayerLoseText
	call SaveEndBattleTextPointers
	ld a, OPP_GREEN
	ld [wCurOpponent], a
	ld [wEnemyMonOrTrainerClass], a
	ld a, [wPlayerStarter]
	cp STARTER1
	jr z, .pickedCharmander
	cp STARTER2
	jr z, .pickedSquirtle
	ld a, 12 ; player picked Bulbasaur, Green has Blastoise line
	jr .got_team
.pickedCharmander
	ld a, 10 ; player picked Charmander, Green has Venusaur line
	jr .got_team
.pickedSquirtle
	ld a, 11 ; player picked Squirtle, Green has Charizard line
.got_team
	ld [wTrainerNo], a
	ld hl, wStatusFlags4
	set BIT_UNKNOWN_4_1, [hl]
	ld a, SCRIPT_INDIGOPLATEAULOBBY_GREEN_AFTER_BATTLE
	ld [wCurMapScript], a
	ret

IndigoPlateauLobbyGreenAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, IndigoPlateauLobbyResetScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	call PlayGreenEncounterMusic
	call IndigoPlateauLobbyGreenFacePlayer
	SetEvent EVENT_BEAT_INDIGO_PLATEAU_GREEN
	ld a, TEXT_INDIGOPLATEAULOBBY_GREEN_AFTER_BATTLE
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld de, IndigoPlateauLobbyGreenExitMovement
	ld a, INDIGOPLATEAULOBBY_GREEN
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_INDIGOPLATEAULOBBY_GREEN_EXIT
	ld [wCurMapScript], a
	ret

IndigoPlateauLobbyGreenExitMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

IndigoPlateauLobbyGreenExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, TOGGLE_INDIGO_PLATEAU_LOBBY_GREEN
	ld [wToggleableObjectIndex], a
	predef HideObject
	call EndGreenEncounterMusic
	jp IndigoPlateauLobbyResetScript

IndigoPlateauLobbySetGreenStartCoords:
	ld a, INDIGOPLATEAULOBBY_GREEN
	ldh [hSpriteIndex], a
	ld hl, wSpriteStateData2
	swap a
	add l
	ld l, a
	ld a, h
	adc 0
	ld h, a
	ld de, SPRITESTATEDATA2_MAPY
	add hl, de
	; Start Green below the trigger so she walks up into the challenge.
	ld a, 6 + 4 ; map y 6
	ld [hli], a
	ld a, 3 + 4 ; map x 3
	ld [hl], a
	ret

IndigoPlateauLobbyGreenFacePlayer:
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	ld a, INDIGOPLATEAULOBBY_GREEN
	ldh [hSpriteIndex], a
	jp SetSpriteFacingDirectionAndDelay

IndigoPlateauLobbyResetScript:
	xor a
	ld [wJoyIgnore], a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld [wCurMapScript], a
	ret

IndigoPlateauLobby_TextPointers:
	def_text_pointers
	dw_const IndigoPlateauLobbyNurseText,            TEXT_INDIGOPLATEAULOBBY_NURSE
	dw_const IndigoPlateauLobbyGymGuideText,         TEXT_INDIGOPLATEAULOBBY_GYM_GUIDE
	dw_const IndigoPlateauLobbyCooltrainerFText,     TEXT_INDIGOPLATEAULOBBY_COOLTRAINER_F
	dw_const IndigoPlateauLobbyClerkText,            TEXT_INDIGOPLATEAULOBBY_CLERK
	dw_const IndigoPlateauLobbyLinkReceptionistText, TEXT_INDIGOPLATEAULOBBY_LINK_RECEPTIONIST
	dw_const IndigoPlateauLobbyGreenText,            TEXT_INDIGOPLATEAULOBBY_GREEN
	dw_const IndigoPlateauLobbyGreenBeforeBattleText, TEXT_INDIGOPLATEAULOBBY_GREEN_BATTLE_INTRO
	dw_const IndigoPlateauLobbyGreenAfterBattleText,  TEXT_INDIGOPLATEAULOBBY_GREEN_AFTER_BATTLE

IndigoPlateauLobbyNurseText:
	script_pokecenter_nurse

IndigoPlateauLobbyGymGuideText:
	text_far _IndigoPlateauLobbyGymGuideText
	text_end

IndigoPlateauLobbyCooltrainerFText:
	text_far _IndigoPlateauLobbyCooltrainerFText
	text_end

IndigoPlateauLobbyLinkReceptionistText:
	script_cable_club_receptionist

IndigoPlateauLobbyGreenText:
	text_asm
	jp TextScriptEnd

IndigoPlateauLobbyGreenBeforeBattleText:
	text "Hey! There you"
	line "are."

	para "I heard someone"
	line "tore through"
	cont "VICTORY ROAD"
	cont "like a TAUROS"
	cont "stampede."

	para "Figured it had"
	line "to be you."
	cont "Hehe."

	para "Not bad."
	line "Seriously."

	para "You've gotten"
	line "a lot stronger"
	cont "since we left"
	cont "PALLET TOWN."

	para "And honestly?"
	line "It's good seeing"
	cont "you again."

	para "Things got weird"
	line "for a while"
	cont "after TEAM"
	cont "ROCKET."

	para "After everything"
	line "in CINNABAR..."
	cont "I couldn't stop"
	cont "thinking about"
	cont "MEW."

	para "Back in the"
	line "ROCKET HIDEOUT,"
	cont "I found old"
	cont "files about it."

	para "At first I"
	line "thought TEAM"
	cont "ROCKET was just"
	cont "chasing another"
	cont "legend."

	para "But after"
	line "CINNABAR?"
	cont "Hehe... no way."

	para "A #MON so"
	line "rare most people"
	cont "think it's a"
	cont "myth..."

	para "And strong"
	line "enough for TEAM"
	cont "ROCKET to try"
	cont "cloning it into"
	cont "something else."

	para "MEWTWO..."

	para "Even now, that"
	line "place gives me"
	cont "chills."

	para "But then I found"
	line "ARTICUNO."

	para "And ZAPDOS."

	para "And MOLTRES."

	para "The legendary"
	line "birds are real."

	para "Which means MEW"
	line "has to be too."

	para "So now I just"
	line "want answers."

	para "Where is it now?"
	line "And what else"
	cont "did TEAM ROCKET"
	cont "discover before"
	cont "they vanished?"

	para "But enough"
	line "about that."

	para "You didn't climb"
	line "all the way here"
	cont "to hear me"
	cont "ramble."

	para "I want to see"
	line "how far you've"
	cont "come."

	para "One battle."
	line "Right here,"
	cont "right now."

	para "And don't think"
	line "I'm going easy"
	cont "just because the"
	cont "ELITE FOUR are"
	cont "waiting upstairs."

	para "If you're really"
	line "ready to become"
	cont "CHAMPION..."

	para "Then prove it"
	line "to me."
	done

IndigoPlateauLobbyGreenEndBattleText:
	text "Not even the"
	line "legendary birds"
	cont "could slow"
	cont "you down.."
	prompt

IndigoPlateauLobbyGreenPlayerLoseText:
	text "Heh, keep"
	line "pushing!"
	done

IndigoPlateauLobbyGreenAfterBattleText:
	text "Hehe. Guess I"
	line "talked a big"
	cont "game for nothing."

	para "And here I"
	line "thought showing"
	cont "up with all"
	cont "three legendary"
	cont "birds would make"
	cont "for a dramatic"
	cont "entrance."

	para "You kinda"
	line "ruined that."

	para "But... I'm glad"
	line "you're the one"
	cont "standing here."

	para "Most people"
	line "would've turned"
	cont "around after"
	cont "everything we"
	cont "saw."

	para "TEAM ROCKET."
	line "CINNABAR."
	cont "MEWTWO..."

	para "Honestly, part"
	line "of me wishes we"
	cont "never learned"
	cont "any of it."

	para "But another"
	line "part of me can't"
	cont "stop chasing the"
	cont "answers."

	para "And knowing you?"
	line "Hehe..."
	cont "you're probably"
	cont "the same."

	para "One way or"
	line "another... I'm"
	cont "going to find"
	cont "MEW."

	para "I don't care"
	line "how long it"
	cont "takes or where"
	cont "the trail leads."

	para "The ELITE FOUR"
	line "are waiting."

	para "So go on."

	para "And hey..."
	line "when this is all"
	cont "over, come find"
	cont "me."

	para "I've got a"
	line "feeling our"
	cont "journey's not"
	cont "ending at the"
	cont "INDIGO PLATEAU."
	cont "Hehe."
	done
