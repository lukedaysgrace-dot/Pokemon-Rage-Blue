CinnabarIsland_Script:
	call EnableAutoTextBoxDrawing
	ld hl, wCurrentMapScriptFlags
	set BIT_CUR_MAP_LOADED_1, [hl]
	ResetEvent EVENT_MANSION_SWITCH_ON
	ResetEvent EVENT_LAB_STILL_REVIVING_FOSSIL
	call CinnabarIslandMaybeShowBlueCloak
	ld hl, CinnabarIsland_ScriptPointers
	ld a, [wCinnabarIslandCurScript]
	jp CallFunctionInTable

CinnabarIslandMaybeShowBlueCloak:
	CheckEvent EVENT_BEAT_VIRIDIAN_BLUE_CLOAK
	ret nz
	CheckEvent EVENT_BEAT_PALLET_TOWN_GREEN
	ret z
	ld a, TOGGLE_CINNABAR_ISLAND_BLUE_CLOAK
	ld [wToggleableObjectIndex], a
	predef ShowObject
	ret

CinnabarIsland_ScriptPointers:
	def_script_pointers
	dw_const CinnabarIslandDefaultScript,            SCRIPT_CINNABARISLAND_DEFAULT
	dw_const CinnabarIslandPlayerMovingScript,       SCRIPT_CINNABARISLAND_PLAYER_MOVING
	dw_const CinnabarIslandBlueCloakAfterBattleScript, SCRIPT_CINNABARISLAND_BLUE_CLOAK_AFTER_BATTLE

CinnabarIslandBlueCloakAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .blueCloakBattleDone
	xor a
	ld [wCinnabarIslandCurScript], a
	ret
.blueCloakBattleDone
	CheckEvent EVENT_BEAT_VIRIDIAN_BLUE_CLOAK
	jp nz, .blueCloakEndingAlreadyDone
	CheckEvent EVENT_BEAT_CINNABAR_ISLAND_BLUE_CLOAK
	jr nz, .cinnabarBlueCloakEndTrainerAlreadyDone
	call EndTrainerBattle
.cinnabarBlueCloakEndTrainerAlreadyDone
	SetEvent EVENT_BEAT_VIRIDIAN_BLUE_CLOAK
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_CINNABARISLAND_BLUE_CLOAK_AFTER_WIN
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TOGGLE_CINNABAR_ISLAND_BLUE_CLOAK
	ld [wToggleableObjectIndex], a
	predef HideObject
	ld a, [wLetterPrintingDelayFlags]
	push af
	predef CreditsRollOnly
	pop af
	ld [wLetterPrintingDelayFlags], a
	ld hl, wStatusFlags7
	res BIT_NO_MAP_MUSIC, [hl]
	ld a, SCRIPT_CINNABARISLAND_DEFAULT
	ld [wCinnabarIslandCurScript], a
	ld [wCurMapScript], a
	ld a, PALLET_TOWN
	ld [wLastBlackoutMap], a
	ld [wDestinationMap], a
	ld hl, wStatusFlags6
	set BIT_FLY_OR_DUNGEON_WARP, [hl]
	farcall PrepareForSpecialWarp
	homecall LoadMapHeader
	farcall SaveGameData
	ld b, 5
.blueCloakCreditsDelayLoop
	ld c, 600 / 5
	call DelayFrames
	dec b
	jr nz, .blueCloakCreditsDelayLoop
	call WaitForTextScrollButtonPress
	jp Init
.blueCloakEndingAlreadyDone
	ld a, TOGGLE_CINNABAR_ISLAND_BLUE_CLOAK
	ld [wToggleableObjectIndex], a
	predef HideObject
	ld a, SCRIPT_CINNABARISLAND_DEFAULT
	ld [wCinnabarIslandCurScript], a
	ld [wCurMapScript], a
	ret

CinnabarIslandDefaultScript:
	ld b, SECRET_KEY
	call IsItemInBag
	ret nz
	ld a, [wYCoord]
	cp 4
	ret nz
	ld a, [wXCoord]
	cp 18
	ret nz
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, TEXT_CINNABARISLAND_DOOR_IS_LOCKED
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, PAD_DOWN
	ld [wSimulatedJoypadStatesEnd], a
	call StartSimulatingJoypadStates
	xor a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld [wJoyIgnore], a
	ld a, SCRIPT_CINNABARISLAND_PLAYER_MOVING
	ld [wCinnabarIslandCurScript], a
	ret

CinnabarIslandPlayerMovingScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	ld a, SCRIPT_CINNABARISLAND_DEFAULT
	ld [wJoyIgnore], a
	ld [wCinnabarIslandCurScript], a
	ret

CinnabarIsland_TextPointers:
	def_text_pointers
	dw_const CinnabarIslandGirlText,           TEXT_CINNABARISLAND_GIRL
	dw_const CinnabarIslandGamblerText,        TEXT_CINNABARISLAND_GAMBLER
	dw_const CinnabarIslandBlueCloakText,      TEXT_CINNABARISLAND_BLUE_CLOAK
	dw_const CinnabarIslandBlueCloakAfterWinText, TEXT_CINNABARISLAND_BLUE_CLOAK_AFTER_WIN
	dw_const CinnabarIslandSignText,           TEXT_CINNABARISLAND_SIGN
	dw_const MartSignText,                     TEXT_CINNABARISLAND_MART_SIGN
	dw_const PokeCenterSignText,               TEXT_CINNABARISLAND_POKECENTER_SIGN
	dw_const CinnabarIslandPokemonLabSignText, TEXT_CINNABARISLAND_POKEMONLAB_SIGN
	dw_const CinnabarIslandGymSignText,        TEXT_CINNABARISLAND_GYM_SIGN
	dw_const CinnabarIslandDoorIsLockedText,   TEXT_CINNABARISLAND_DOOR_IS_LOCKED

CinnabarIslandTrainerHeaders:
	def_trainers
CinnabarIslandBlueCloakTrainerHeader:
	trainer EVENT_BEAT_CINNABAR_ISLAND_BLUE_CLOAK, 1, CinnabarIslandBlueCloakHeaderBeforeText, CinnabarIslandBlueCloakDefeatedText, CinnabarIslandBlueCloakHeaderAfterText
	db -1 ; end

CinnabarIslandDoorIsLockedText:
	text_far _CinnabarIslandDoorIsLockedText
	text_end

CinnabarIslandGirlText:
	text_far _CinnabarIslandGirlText
	text_end

CinnabarIslandGamblerText:
	text_far _CinnabarIslandGamblerText
	text_end

CinnabarIslandSignText:
	text_far _CinnabarIslandSignText
	text_end

CinnabarIslandPokemonLabSignText:
	text_far _CinnabarIslandPokemonLabSignText
	text_end

CinnabarIslandGymSignText:
	text_far _CinnabarIslandGymSignText
	text_end

CinnabarIslandBlueCloakHeaderBeforeText:
	text_far _CinnabarIslandBlueCloakPreBattleText1
	text_end

CinnabarIslandBlueCloakHeaderAfterText:
	text_far _CinnabarIslandBlueCloakAfterBeatShortText
	text_end

CinnabarIslandBlueCloakNotYetText:
	text_far _ViridianCityBlueCloakNotYetText
	text_end

CinnabarIslandBlueCloakPreBattleText1:
	text_far _CinnabarIslandBlueCloakPreBattleText1
	text_end

CinnabarIslandBlueCloakPreBattleText2:
	text_far _CinnabarIslandBlueCloakPreBattleText2
	text_end

CinnabarIslandBlueCloakDefeatedText:
	text_far _CinnabarIslandBlueCloakDefeatedText
	text_end

CinnabarIslandBlueCloakVictoryText:
	text_far _ViridianCityBlueCloakVictoryText
	text_end

CinnabarIslandBlueCloakAfterBeatShortText:
	text_far _CinnabarIslandBlueCloakAfterBeatShortText
	text_end

CinnabarIslandBlueCloakText:
	text_asm
	CheckEvent EVENT_BEAT_VIRIDIAN_BLUE_CLOAK
	jp nz, .alreadyFinished
	CheckEvent EVENT_BEAT_CINNABAR_ISLAND_BLUE_CLOAK
	jr z, .needAllRematches
	ld a, SCRIPT_CINNABARISLAND_BLUE_CLOAK_AFTER_BATTLE
	ld [wCinnabarIslandCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd
.needAllRematches
	CheckEvent EVENT_BEAT_PALLET_TOWN_GREEN
	jp z, .notYet
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
	ld c, BANK(Music_BlueCloakStart)
	ld a, MUSIC_BLUE_CLOAK_START
	call PlayMusic
	ld hl, CinnabarIslandBlueCloakPreBattleText1
	call PrintText
	ld hl, CinnabarIslandBlueCloakPreBattleText2
	call PrintText
	ld hl, CinnabarIslandBlueCloakTrainerHeader
	call StoreTrainerHeaderPointer
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, CinnabarIslandBlueCloakDefeatedText
	ld de, CinnabarIslandBlueCloakVictoryText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	ld a, [wRivalStarter]
	cp STARTER2
	jr nz, .blueCloakNotSquirtle
	ld a, 1
	jr .blueCloakTrainerNoDone
.blueCloakNotSquirtle
	cp STARTER3
	jr nz, .blueCloakNotBulbasaur
	ld a, 2
	jr .blueCloakTrainerNoDone
.blueCloakNotBulbasaur
	ld a, 3
.blueCloakTrainerNoDone
	ld [wEngagedTrainerSet], a
	call InitBattleEnemyParameters
	xor a
	ld [wGymLeaderNo], a
	ld a, SCRIPT_CINNABARISLAND_BLUE_CLOAK_AFTER_BATTLE
	ld [wCinnabarIslandCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd
.notYet
	ld hl, CinnabarIslandBlueCloakNotYetText
	call PrintText
	jp TextScriptEnd
.alreadyFinished
	ld hl, CinnabarIslandBlueCloakAfterBeatShortText
	call PrintText
	jp TextScriptEnd

CinnabarIslandBlueCloakAfterWinText:
	text_far _CinnabarIslandBlueCloakAfterBeatText
	text_end
