PokemonMansionB1F_Script:
	call MansionB1FCheckReplaceSwitchDoorBlocks
	call EnableAutoTextBoxDrawing
	ld hl, Mansion4TrainerHeaders
	ld de, PokemonMansionB1F_ScriptPointers
	ld a, [wPokemonMansionB1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPokemonMansionB1FCurScript], a
	ret

PokemonMansionB1FDefaultScript:
	ld hl, PokemonMansionB1FPlantBlockerCoords
	call ArePlayerCoordsInArray
	jr nc, .checkGreenTrigger
	call PokemonMansionB1FStartPlantBlockerPushback
	ld a, SCRIPT_POKEMONMANSIONB1F_PLANT_BLOCKER_PUSHBACK
	ret
.checkGreenTrigger
	CheckEvent EVENT_BEAT_MANSION_B1F_GREEN
	jp nz, CheckFightingMapTrainers
	ld hl, PokemonMansionB1FGreenTriggerCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	ld a, [wCoordIndex]
	ld [wSavedCoordIndex], a
	jp PokemonMansionB1FGreenAppearsScript

PokemonMansionB1FGreenTriggerCoords:
	dbmapcoord  5, 12
	dbmapcoord  4, 12
	db -1

PokemonMansionB1FPlantBlockerCoords:
	dbmapcoord  1, 10
	dbmapcoord  1, 11
	dbmapcoord  1, 12
	dbmapcoord  1, 13
	dbmapcoord  1, 14
	dbmapcoord  1, 15
	dbmapcoord  8, 10
	dbmapcoord  8, 11
	dbmapcoord  8, 12
	dbmapcoord  8, 13
	dbmapcoord  8, 14
	dbmapcoord  8, 15
	db -1

PokemonMansionB1FStartPlantBlockerPushback:
	xor a
	ldh [hJoyHeld], a
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_DOWN
	jr z, .pushUp
	cp SPRITE_FACING_UP
	jr z, .pushDown
	cp SPRITE_FACING_LEFT
	jr z, .pushRight
	ld a, PAD_LEFT
	jr .startPushback
.pushUp
	ld a, PAD_UP
	jr .startPushback
.pushDown
	ld a, PAD_DOWN
	jr .startPushback
.pushRight
	ld a, PAD_RIGHT
.startPushback
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, SCRIPT_POKEMONMANSIONB1F_PLANT_BLOCKER_PUSHBACK
	ld [wPokemonMansionB1FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonMansionB1FPlantBlockerPushbackScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld [wPokemonMansionB1FCurScript], a
	ld [wCurMapScript], a
	ret

MansionB1FCheckReplaceSwitchDoorBlocks:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	ret z
	CheckEvent EVENT_MANSION_SWITCH_ON
	jr nz, .switchTurnedOn
	ld a, $e
	lb bc, 8, 13
	call Mansion2ReplaceBlock
	ld a, $e
	lb bc, 11, 6
	call Mansion2ReplaceBlock
	ld a, $5f
	lb bc, 3, 4
	call Mansion2ReplaceBlock
	ld a, $54
	lb bc, 8, 8
	call Mansion2ReplaceBlock
	ret
.switchTurnedOn
	ld a, $2d
	lb bc, 8, 13
	call Mansion2ReplaceBlock
	ld a, $5f
	lb bc, 11, 6
	call Mansion2ReplaceBlock
	ld a, $e
	lb bc, 3, 4
	call Mansion2ReplaceBlock
	ld a, $e
	lb bc, 8, 8
	call Mansion2ReplaceBlock
	ret

Mansion4Script_Switches::
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	ret nz
	xor a
	ldh [hJoyHeld], a
	ld a, TEXT_POKEMONMANSIONB1F_SWITCH
	ldh [hTextID], a
	jp DisplayTextID

PokemonMansionB1FGreenAppearsScript:
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	call PokemonMansionB1FSetGreenStartCoords
	ld de, TOGGLE_POKEMON_MANSION_B1F_GREEN
	predef ShowObject
	call UpdateSprites
	ld c, 12
	call DelayFrames
	xor a ; player sprite
	ld [wEmotionBubbleSpriteIndex], a
	ld [wWhichEmotionBubble], a ; EXCLAMATION_BUBBLE
	predef EmotionBubble
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	call Delay3
	call PlayGreenEncounterMusic
	ld de, PokemonMansionB1FGreenApproachMovement
	ld a, POKEMONMANSIONB1F_GREEN
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_POKEMONMANSIONB1F_GREEN_APPROACH
	ld [wPokemonMansionB1FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonMansionB1FGreenApproachMovement:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

PokemonMansionB1FGreenApproachScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	jr z, .movementDone
	call PokemonMansionB1FGreenReachedApproachTile
	ret nz
	call PokemonMansionB1FClearGreenMovement
.movementDone
	call PokemonMansionB1FGreenFacePlayer
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_POKEMONMANSIONB1F_GREEN_BATTLE_INTRO
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, PokemonMansionB1FGreenEndBattleText
	ld de, PokemonMansionB1FGreenEndBattleText
	call SaveEndBattleTextPointers
	ld a, OPP_GREEN
	ld [wCurOpponent], a
	ld [wEnemyMonOrTrainerClass], a
	ld a, [wPlayerStarter]
	cp STARTER1
	jr z, .pickedCharmander
	cp STARTER2
	jr z, .pickedSquirtle
	ld a, 9 ; player picked Bulbasaur, Green has Squirtle
	jr .gotTeam
.pickedCharmander
	ld a, 7 ; player picked Charmander, Green has Bulbasaur
	jr .gotTeam
.pickedSquirtle
	ld a, 8 ; player picked Squirtle, Green has Charmander
.gotTeam
	ld [wTrainerNo], a
	ld a, SCRIPT_POKEMONMANSIONB1F_GREEN_AFTER_BATTLE
	ld [wPokemonMansionB1FCurScript], a
	ld [wCurMapScript], a
	ld hl, wStatusFlags4
	set BIT_UNKNOWN_4_1, [hl]
	xor a
	ld [wJoyIgnore], a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ret

PokemonMansionB1FGreenAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, PokemonMansionB1FGreenBattleCancelled
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	call PlayGreenEncounterMusic
	call PokemonMansionB1FGreenFacePlayer
	SetEvent EVENT_BEAT_MANSION_B1F_GREEN
	ld a, TEXT_POKEMONMANSIONB1F_GREEN_AFTER_BATTLE
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, SCRIPT_POKEMONMANSIONB1F_MEW_APPROACH
	ld [wPokemonMansionB1FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonMansionB1FMewApproachScript:
	call PokemonMansionB1FClearGreenMovement
	ld de, PokemonMansionB1FGreenExitMovement
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	ld a, POKEMONMANSIONB1F_GREEN
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	call PokemonMansionB1FAllowGreenAnyDirection
	call MoveSprite
	ld a, SCRIPT_POKEMONMANSIONB1F_GREEN_EXIT
	ld [wPokemonMansionB1FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonMansionB1FGreenReactToMewMovement:
	db NPC_MOVEMENT_LEFT
	db -1 ; end

PokemonMansionB1FGreenReactToMewReverseMovement:
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

PokemonMansionB1FGreenReactsToMewScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	ld a, POKEMONMANSIONB1F_GREEN
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_POKEMONMANSIONB1F_GREEN_MEW_APPEARS
	ldh [hTextID], a
	call DisplayTextID
	ld a, MEW
	call PlayCry
	call WaitForSoundToFinish
	ld a, TEXT_POKEMONMANSIONB1F_MEW_CRY
	ldh [hTextID], a
	call DisplayTextID
	ld a, TEXT_POKEMONMANSIONB1F_GREEN_FRIEND_MEW
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	ld a, POKEMONMANSIONB1F_GREEN
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld de, TOGGLE_POKEMON_MANSION_B1F_MEW
	predef HideObject
	ld de, TOGGLE_POKEMON_MANSION_B1F_BALL
	predef ShowObject
	call UpdateSprites
	ld de, PokemonMansionB1FBallMovement
	ld a, POKEMONMANSIONB1F_BALL
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_POKEMONMANSIONB1F_BALL_MOVING
	ld [wPokemonMansionB1FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonMansionB1FBallMovement:
	db NPC_MOVEMENT_UP
	db -1 ; end

PokemonMansionB1FBallMovingScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld de, TOGGLE_POKEMON_MANSION_B1F_BALL
	predef HideObject
	call UpdateSprites
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_POKEMONMANSIONB1F_GREEN_CAUGHT_MEW
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, POKEMONMANSIONB1F_GREEN
	ld [wEmotionBubbleSpriteIndex], a
	xor a
	ld [wWhichEmotionBubble], a ; EXCLAMATION_BUBBLE
	predef EmotionBubble
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	ld a, POKEMONMANSIONB1F_GREEN
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	call PokemonMansionB1FSetMewAndBallCaptureCoords
	ld de, TOGGLE_POKEMON_MANSION_B1F_MEW
	predef ShowObject
	call UpdateSprites
	ld c, 12
	call DelayFrames
	ld a, SCRIPT_POKEMONMANSIONB1F_MEW_APPROACH
	ld [wPokemonMansionB1FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonMansionB1FGreenExitMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

PokemonMansionB1FGreenExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld de, TOGGLE_POKEMON_MANSION_B1F_GREEN
	predef HideObject
	xor a
	ld [wJoyIgnore], a
	call EndGreenEncounterMusic
	ld [wPokemonMansionB1FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonMansionB1FGreenBattleCancelled:
	xor a
	ld [wJoyIgnore], a
	ld [wPokemonMansionB1FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonMansionB1FSetGreenStartCoords:
	ld a, POKEMONMANSIONB1F_GREEN
	ldh [hSpriteIndex], a
	call PokemonMansionB1FGetSpriteMapCoords
	ld a, 12 ; map y 8 + 4
	ld [hli], a
	ld a, [wSavedCoordIndex]
	cp 2
	jr z, .reverseGreen
	ld a, 9 ; map x 5 + 4
	jr .setGreenX
.reverseGreen
	ld a, 8 ; map x 4 + 4
.setGreenX
	ld [hl], a
	ret

PokemonMansionB1FAllowGreenAnyDirection:
	call GetSpriteMovementByte2Pointer
	ld [hl], ANY_DIR
	ret

PokemonMansionB1FSetMewAndBallCaptureCoords:
	ld a, [wSavedCoordIndex]
	cp 2
	jr z, .reverse
	ld b, 8 ; map x 4 + 4
	jr .gotX
.reverse
	ld b, 9 ; map x 5 + 4
.gotX
	ld a, POKEMONMANSIONB1F_MEW
	ldh [hSpriteIndex], a
	call PokemonMansionB1FGetSpriteMapCoords
	ld a, 14 ; map y 10 + 4
	ld [hli], a
	ld a, b
	ld [hl], a
	ld a, POKEMONMANSIONB1F_BALL
	ldh [hSpriteIndex], a
	call PokemonMansionB1FGetSpriteMapCoords
	ld a, 15 ; map y 11 + 4
	ld [hli], a
	ld a, b
	ld [hl], a
	ret

PokemonMansionB1FGetSpriteMapCoords:
	ld hl, wSpriteStateData2
	ldh a, [hSpriteIndex]
	swap a
	add l
	ld l, a
	ld a, h
	adc 0
	ld h, a
	ld de, SPRITESTATEDATA2_MAPY
	add hl, de
	ret

PokemonMansionB1FGreenReachedApproachTile:
	ld hl, wSpriteStateData2
	ld a, POKEMONMANSIONB1F_GREEN
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
	cp 12
	ret

PokemonMansionB1FClearGreenMovement:
	ld hl, wStatusFlags5
	res BIT_SCRIPTED_NPC_MOVEMENT, [hl]
	ld a, POKEMONMANSIONB1F_GREEN
	ldh [hSpriteIndex], a
	call GetSpriteMovementByte1Pointer
	ld [hl], STAY
	xor a
	ld [wSimulatedJoypadStatesIndex], a
	ld [wUnusedOverrideSimulatedJoypadStatesIndex], a
	ret

PokemonMansionB1FGreenFacePlayer:
	ld hl, wSpriteStateData2
	ld a, POKEMONMANSIONB1F_GREEN
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
	jr z, .sameMapY
	jr c, .faceNorth
	ld a, SPRITE_FACING_DOWN
	jr .setFacing
.faceNorth
	ld a, SPRITE_FACING_UP
	jr .setFacing
.sameMapY
	inc hl
	ld a, [hl]
	sub 4
	ld b, a
	ld a, [wXCoord]
	cp b
	jr z, .sameTile
	jr c, .faceWest
	ld a, SPRITE_FACING_RIGHT
	jr .setFacing
.faceWest
	ld a, SPRITE_FACING_LEFT
	jr .setFacing
.sameTile
	ld a, SPRITE_FACING_DOWN
.setFacing
	ldh [hSpriteFacingDirection], a
	ld a, POKEMONMANSIONB1F_GREEN
	ldh [hSpriteIndex], a
	jp SetSpriteFacingDirectionAndDelay

PokemonMansionB1F_ScriptPointers:
	def_script_pointers
	dw_const PokemonMansionB1FDefaultScript,        SCRIPT_POKEMONMANSIONB1F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_POKEMONMANSIONB1F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_POKEMONMANSIONB1F_END_BATTLE
	dw_const PokemonMansionB1FGreenAppearsScript,   SCRIPT_POKEMONMANSIONB1F_GREEN_APPEARS
	dw_const PokemonMansionB1FGreenApproachScript,  SCRIPT_POKEMONMANSIONB1F_GREEN_APPROACH
	dw_const PokemonMansionB1FGreenAfterBattleScript, SCRIPT_POKEMONMANSIONB1F_GREEN_AFTER_BATTLE
	dw_const PokemonMansionB1FMewApproachScript,    SCRIPT_POKEMONMANSIONB1F_MEW_APPROACH
	dw_const PokemonMansionB1FGreenReactsToMewScript, SCRIPT_POKEMONMANSIONB1F_GREEN_REACTS_TO_MEW
	dw_const PokemonMansionB1FBallMovingScript,     SCRIPT_POKEMONMANSIONB1F_BALL_MOVING
	dw_const PokemonMansionB1FGreenExitScript,      SCRIPT_POKEMONMANSIONB1F_GREEN_EXIT
	dw_const PokemonMansionB1FPlantBlockerPushbackScript, SCRIPT_POKEMONMANSIONB1F_PLANT_BLOCKER_PUSHBACK

PokemonMansionB1F_TextPointers:
	def_text_pointers
	dw_const PokemonMansionB1FBurglarText,   TEXT_POKEMONMANSIONB1F_BURGLAR
	dw_const PokemonMansionB1FScientistText, TEXT_POKEMONMANSIONB1F_SCIENTIST
	dw_const PickUpItemText,                 TEXT_POKEMONMANSIONB1F_RARE_CANDY
	dw_const PickUpItemText,                 TEXT_POKEMONMANSIONB1F_FULL_RESTORE
	dw_const PickUpItemText,                 TEXT_POKEMONMANSIONB1F_TM_BLIZZARD
	dw_const PickUpItemText,                 TEXT_POKEMONMANSIONB1F_TM_SOLARBEAM
	dw_const PokemonMansionB1FDiaryText,     TEXT_POKEMONMANSIONB1F_DIARY
	dw_const PokemonMansionB1FSecretKeyText, TEXT_POKEMONMANSIONB1F_SECRET_KEY
	dw_const PokemonMansionB1FGreenText,     TEXT_POKEMONMANSIONB1F_GREEN
	dw_const PokemonMansionB1FMewText,       TEXT_POKEMONMANSIONB1F_MEW
	dw_const PokemonMansionB1FBallText,      TEXT_POKEMONMANSIONB1F_BALL
	dw_const PokemonMansion2FSwitchText,     TEXT_POKEMONMANSIONB1F_SWITCH ; This switch uses the text script from the 2F.
	dw_const PokemonMansionB1FGreenBeforeBattleText, TEXT_POKEMONMANSIONB1F_GREEN_BATTLE_INTRO
	dw_const PokemonMansionB1FGreenAfterBattleText,  TEXT_POKEMONMANSIONB1F_GREEN_AFTER_BATTLE
	dw_const PokemonMansionB1FGreenText,             TEXT_POKEMONMANSIONB1F_MEW_CRY
	dw_const PokemonMansionB1FGreenText,             TEXT_POKEMONMANSIONB1F_GREEN_MEW_APPEARS
	dw_const PokemonMansionB1FGreenText,             TEXT_POKEMONMANSIONB1F_GREEN_FRIEND_MEW
	dw_const PokemonMansionB1FGreenText,             TEXT_POKEMONMANSIONB1F_GREEN_CAUGHT_MEW

Mansion4TrainerHeaders:
	def_trainers
Mansion4TrainerHeader0:
	trainer EVENT_BEAT_MANSION_4_TRAINER_0, 0, PokemonMansionB1FBurglarBattleText, PokemonMansionB1FBurglarEndBattleText, PokemonMansionB1FBurglarAfterBattleText
Mansion4TrainerHeader1:
	trainer EVENT_BEAT_MANSION_4_TRAINER_1, 3, PokemonMansionB1FScientistBattleText, PokemonMansionB1FScientistEndBattleText, PokemonMansionB1FScientistAfterBattleText
	db -1 ; end

PokemonMansionB1FBurglarText:
	text_asm
	ld hl, Mansion4TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

PokemonMansionB1FScientistText:
	text_asm
	ld hl, Mansion4TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

PokemonMansionB1FBurglarBattleText:
	text_far _PokemonMansionB1FBurglarBattleText
	text_end

PokemonMansionB1FBurglarEndBattleText:
	text_far _PokemonMansionB1FBurglarEndBattleText
	text_end

PokemonMansionB1FBurglarAfterBattleText:
	text_far _PokemonMansionB1FBurglarAfterBattleText
	text_end

PokemonMansionB1FScientistBattleText:
	text_far _PokemonMansionB1FScientistBattleText
	text_end

PokemonMansionB1FScientistEndBattleText:
	text_far _PokemonMansionB1FScientistEndBattleText
	text_end

PokemonMansionB1FScientistAfterBattleText:
	text_far _PokemonMansionB1FScientistAfterBattleText
	text_end

PokemonMansionB1FDiaryText:
	text_far _PokemonMansionB1FDiaryText
	text_end

PokemonMansionB1FSecretKeyText:
	text_asm
	predef PickUpItem
	jp TextScriptEnd

PokemonMansionB1FGreenText:
PokemonMansionB1FMewText:
PokemonMansionB1FBallText:
	text_asm
	jp TextScriptEnd

PokemonMansionB1FGreenBeforeBattleText:
	text "Oh? If it isn't"
	line "you again,"
	cont "<PLAYER>."
	cont "Fancy running"
	cont "into you here..."

	para "You've been"
	line "poking around"
	cont "too, haven't you?"

	para "Hehe... I get it."
	line "This place is"
	cont "impossible to"
	cont "ignore."

	para "All of these"
	line "journals, the"
	cont "experiments..."

	para "I've been "
	line "reading"
	cont "everything I"
	cont "can find."

	para "MEW... the"
	line "original"
	cont "#MON..."

	para "They actually"
	line "created MEWTWO"
	cont "from it here."

	para "Isn't that"
	line "insane? Imagine"
	cont "that power."

	para "...And imagine"
	line "what someone"
	cont "evil could"
	cont "do with it."

	para "Oh... don't look"
	line "at me like that!"

	para "I'm just curious,"
	line "that's all!"

	para "Still... I've"
	line "learned a lot in"
	cont "this creepy lab."

	para "Enough to know"
	line "I shouldn't"
	cont "underestimate"
	cont "you anymore."

	para "So how about it?"
	line "Let's see if all"
	cont "that exploring"
	cont "made you"
	cont "stronger?"
	done

PokemonMansionB1FGreenEndBattleText:
	text "You really"
	line "just keep"
	cont "training nonstop"
	cont "don't you? Hehe."

	para "I really do"
	line "admire that"
	cont "strength."
	prompt

PokemonMansionB1FGreenAfterBattleText:
	text "Still just as"
	line "tough as ever."
	cont "Hehe."

	para "But you know"
	line "what's been stuck"
	cont "in my head?"

	para "All these notes"
	line "about MEW..."

	para "The way they"
	line "describe it..."
	cont "playful,"
	cont "intelligent..."

	para "Like it's always"
	line "just out of"
	cont "reach."

	para "...I'd love to"
	line "meet it."

	para "Not like those"
	line "scientists did..."
	cont "using its DNA"
	cont "to create such"
	cont "a monster."

	para "Just... see it"
	line "for myself."

	para "#MON should"
	line "never be used"
	cont "for experiments."

	para "Seems like a"
	line "#MON with a"
	cont "truly gentle"
	cont "soul."

	para "I'm going to get"
	line "out of this awful"
	cont "place, <PLAYER>."

	para "I'll see you"
	line "later!"
	done
