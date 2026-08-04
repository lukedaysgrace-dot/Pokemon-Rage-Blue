MtMoonB2F_Script:
	call EnableAutoTextBoxDrawing
IF DEF(_RED)
	ld a, [wMtMoonB2FCurScript]
	and a
	jr nz, .skipEarlyFossilWarn
	call MtMoonB2FCheckFossilWarnTiles
.skipEarlyFossilWarn
ENDC
	ld hl, MtMoon3TrainerHeaders
	ld de, MtMoonB2F_ScriptPointers
	ld a, [wMtMoonB2FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wMtMoonB2FCurScript], a
	CheckEvent EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	ret z
	ld hl, MtMoonB2FFossilAreaCoords
	call ArePlayerCoordsInArray
	jr nc, .enable_battles
	ld hl, wStatusFlags4
	set BIT_NO_BATTLES, [hl]
	ret
.enable_battles
	ld hl, wStatusFlags4
	res BIT_NO_BATTLES, [hl]
	ret

MtMoonB2FFossilAreaCoords:
	dbmapcoord 11,  5
	dbmapcoord 12,  5
	dbmapcoord 13,  5
	dbmapcoord 14,  5
	dbmapcoord 11,  6
	dbmapcoord 12,  6
	dbmapcoord 13,  6
	dbmapcoord 14,  6
	dbmapcoord 11,  7
	dbmapcoord 12,  7
	dbmapcoord 13,  7
	dbmapcoord 14,  7
	dbmapcoord 11,  8
	dbmapcoord 12,  8
	dbmapcoord 13,  8
	dbmapcoord 14,  8
	db -1 ; end

MtMoonB2FResetScripts:
	xor a ; SCRIPT_MTMOONB2F_DEFAULT
	ld [wJoyIgnore], a
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoonB2F_ScriptPointers:
	def_script_pointers
	dw_const MtMoonB2FDefaultScript,                   SCRIPT_MTMOONB2F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle,    SCRIPT_MTMOONB2F_START_BATTLE
	dw_const EndTrainerBattle,                         SCRIPT_MTMOONB2F_END_BATTLE
	dw_const MtMoonB2FDefeatedSuperNerdScript,         SCRIPT_MTMOONB2F_DEFEATED_SUPER_NERD
	dw_const MtMoonB2FMoveSuperNerdScript,             SCRIPT_MTMOONB2F_MOVE_SUPER_NERD
	dw_const MtMoonB2FSuperNerdTakesOtherFossilScript, SCRIPT_MTMOONB2F_SUPER_NERD_TAKES_OTHER_FOSSIL
IF DEF(_RED)
	dw_const MtMoonB2FFossilApproachScript,          SCRIPT_MTMOONB2F_FOSSIL_APPROACH
	dw_const MtMoonB2FFossilApproachTextScript,      SCRIPT_MTMOONB2F_FOSSIL_APPROACH_TEXT
ENDC

MtMoonB2FDefaultScript:
	CheckEvent EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	jp nz, MtMoonB2FCheckGotAFossil
	ld a, [wYCoord]
	cp 8
	jp nz, MtMoonB2FCheckGotAFossil
	ld a, [wXCoord]
	cp 13
	jp nz, MtMoonB2FCheckGotAFossil
	xor a
	ldh [hJoyHeld], a
	ld a, TEXT_MTMOONB2F_SUPER_NERD
	ldh [hTextID], a
	jp DisplayTextID

MtMoonB2FCheckGotAFossil:
	CheckEitherEventSet EVENT_GOT_DOME_FOSSIL, EVENT_GOT_HELIX_FOSSIL
	jp z, CheckFightingMapTrainers
	ret

IF DEF(_RED)
MtMoonB2FCheckFossilWarnTiles:
	CheckEvent EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	ret z
	CheckEvent EVENT_GOT_MT_MOON_SUPER_NERD_FOSSIL
	ret nz
	CheckEitherEventSet EVENT_GOT_DOME_FOSSIL, EVENT_GOT_HELIX_FOSSIL
	ret z
	CheckEvent EVENT_MT_MOON_SUPER_NERD_FOUR_FOSSIL_TOLD
	jr nz, .checkSellWarning
	ld hl, MtMoonB2FPlayerFirstWarnCoords
	call ArePlayerCoordsInArray
	ret nc
	call MtMoonB2FLockPlayerOnTriggerTile
	ld a, SCRIPT_MTMOONB2F_FOSSIL_APPROACH
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	scf
	ret

.checkSellWarning
	CheckEvent EVENT_MT_MOON_SUPER_NERD_SELL_WARNING
	ret nz
	ld hl, MtMoonB2FPlayerSellWarnCoords
	call ArePlayerCoordsInArray
	ret nc
	call MtMoonB2FLockPlayerOnTriggerTile
	ld a, TEXT_MTMOONB2F_SUPER_NERD_SELL_WARNING
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_MT_MOON_SUPER_NERD_SELL_WARNING
	xor a
	ld [wJoyIgnore], a
	scf
	ret

MtMoonB2FLockPlayerOnTriggerTile:
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ret

MtMoonB2FPlayerFirstWarnCoords:
	dbmapcoord 12,  5
	dbmapcoord 13,  5
	db -1 ; end

MtMoonB2FPlayerSellWarnCoords:
	dbmapcoord 12,  4
	dbmapcoord 13,  4
	db -1 ; end

MtMoonB2FFossilApproachScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	call MtMoonB2FLockPlayerOnTriggerTile
	ld a, MTMOONB2F_SUPER_NERD
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wXCoord]
	cp 12
	jr z, .approachDomeSide
	ld de, MtMoonB2FNerdApproachHelixPlayerMovement
	jr .approachMove
.approachDomeSide
	ld de, MtMoonB2FNerdApproachDomePlayerMovement
.approachMove
	ld a, MTMOONB2F_SUPER_NERD
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MTMOONB2F_FOSSIL_APPROACH_TEXT
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoonB2FNerdApproachDomePlayerMovement:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_UP
	db -1 ; end

MtMoonB2FNerdApproachHelixPlayerMovement:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db -1 ; end

MtMoonB2FFossilApproachTextScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	call MtMoonB2FLockPlayerOnTriggerTile
	ld a, TEXT_MTMOONB2F_SUPER_NERD_FOUR_FOSSILS
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_MT_MOON_SUPER_NERD_FOUR_FOSSIL_TOLD
	xor a
	ld [wJoyIgnore], a
	ld a, SCRIPT_MTMOONB2F_DEFAULT
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoonB2FSuperNerdFourFossilsText:
	text_far _MtMoonB2FSuperNerdFourFossilsText
	text_end

MtMoonB2FSuperNerdSellWarningText:
	text_far _MtMoonB2FSuperNerdSellWarningText
	text_end
ENDC

MtMoonB2FDefeatedSuperNerdScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, MtMoonB2FResetScripts
	call UpdateSprites
	call Delay3
	SetEvent EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	xor a
	ld [wJoyIgnore], a
	ld a, SCRIPT_MTMOONB2F_DEFAULT
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoonB2FMoveSuperNerdScript:
	ld a, MTMOONB2F_SUPER_NERD
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld hl, MtMoonB2FPlayerNearDomeFossilCoords
	call ArePlayerCoordsInArray
	jr c, .player_near_dome_fossil
	ld hl, MtMoonB2FPlayerNearHelixFossilCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	ld de, MtMoon3FSuperNerdMoveUpMovementData
	jr .continue
.player_near_dome_fossil
	ld de, MtMoon3FSuperNerdMoveRightMovementData
.continue
	ld a, MTMOONB2F_SUPER_NERD
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_MTMOONB2F_SUPER_NERD_TAKES_OTHER_FOSSIL
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoonB2FPlayerNearDomeFossilCoords:
	dbmapcoord 12,  7
	dbmapcoord 11,  6
	dbmapcoord 12,  5
	db -1 ; end

MtMoonB2FPlayerNearHelixFossilCoords:
	dbmapcoord 13,  7
	dbmapcoord 14,  6
	dbmapcoord 14,  5
	db -1 ; end

MtMoon3FSuperNerdMoveRightMovementData:
	db NPC_MOVEMENT_RIGHT
MtMoon3FSuperNerdMoveUpMovementData:
	db NPC_MOVEMENT_UP
	db -1 ; end

MtMoonB2FSuperNerdTakesOtherFossilScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, TEXT_MTMOONB2F_SUPER_NERD_THEN_THIS_IS_MINE
	ldh [hTextID], a
	call DisplayTextID
	CheckEvent EVENT_GOT_DOME_FOSSIL
	jr z, .got_dome_fossil
	ld de, TOGGLE_MT_MOON_B2F_FOSSIL_2
	jr .continue
.got_dome_fossil
	ld de, TOGGLE_MT_MOON_B2F_FOSSIL_1
.continue
	predef HideObject
	xor a
	ld [wJoyIgnore], a
	ld a, SCRIPT_MTMOONB2F_DEFAULT
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoonB2F_TextPointers:
	def_text_pointers
	dw_const MtMoonB2FSuperNerdText,               TEXT_MTMOONB2F_SUPER_NERD
	dw_const MtMoonB2FRocket1Text,                 TEXT_MTMOONB2F_ROCKET1
	dw_const MtMoonB2FRocket2Text,                 TEXT_MTMOONB2F_ROCKET2
	dw_const MtMoonB2FRocket3Text,                 TEXT_MTMOONB2F_ROCKET3
	dw_const MtMoonB2FRocket4Text,                 TEXT_MTMOONB2F_ROCKET4
	dw_const MtMoonB2FDomeFossilText,              TEXT_MTMOONB2F_DOME_FOSSIL
	dw_const MtMoonB2FHelixFossilText,             TEXT_MTMOONB2F_HELIX_FOSSIL
	dw_const PickUpItemText,                       TEXT_MTMOONB2F_HP_UP
	dw_const PickUpItemText,                       TEXT_MTMOONB2F_CLAW_FOSSIL
	dw_const PickUpItemText,                       TEXT_MTMOONB2F_TM_MEGA_PUNCH
	dw_const PickUpItemText,                       TEXT_MTMOONB2F_SKULL_FOSSIL
	dw_const MtMoonB2FSuperNerdThenThisIsMineText, TEXT_MTMOONB2F_SUPER_NERD_THEN_THIS_IS_MINE
IF DEF(_RED)
	dw_const MtMoonB2FSuperNerdFourFossilsText,   TEXT_MTMOONB2F_SUPER_NERD_FOUR_FOSSILS
	dw_const MtMoonB2FSuperNerdSellWarningText,   TEXT_MTMOONB2F_SUPER_NERD_SELL_WARNING
ENDC

MtMoon3TrainerHeaders:
	def_trainers 2
MtMoon3TrainerHeader0:
	trainer EVENT_BEAT_MT_MOON_3_TRAINER_0, 4, MtMoonB2FRocket1BattleText, MtMoonB2FRocket1EndBattleText, MtMoonB2FRocket1AfterBattleText
MtMoon3TrainerHeader1:
	trainer EVENT_BEAT_MT_MOON_3_TRAINER_1, 4, MtMoonB2FRocket2BattleText, MtMoonB2FRocket2EndBattleText, MtMoonB2FRocket2AfterBattleText
MtMoon3TrainerHeader2:
	trainer EVENT_BEAT_MT_MOON_3_TRAINER_2, 4, MtMoonB2FRocket3BattleText, MtMoonB2FRocket3EndBattleText, MtMoonB2FRocket3AfterBattleText
MtMoon3TrainerHeader3:
	trainer EVENT_BEAT_MT_MOON_3_TRAINER_3, 4, MtMoonB2FRocket4BattleText, MtMoonB2FRocket4EndBattleText, MtMoonB2FRocket4AfterBattleText
	db -1 ; end

MtMoonB2FSuperNerdText:
	text_asm
	CheckEvent EVENT_BEAT_MT_MOON_EXIT_SUPER_NERD
	jr z, .beat_super_nerd
	CheckEvent EVENT_GOT_MT_MOON_SUPER_NERD_FOSSIL
	jr nz, .got_reward_fossil
	CheckEitherEventSet EVENT_GOT_DOME_FOSSIL, EVENT_GOT_HELIX_FOSSIL, 1
	jr nz, .check_all_fossils
	ld hl, MtMoonB2fSuperNerdEachTakeOneText
	call PrintText
	jr .done
.beat_super_nerd
	ld hl, MtMoonB2FSuperNerdTheyreBothMineText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, MtMoonB2FSuperNerdOkIllShareText
	ld de, MtMoonB2FSuperNerdOkIllShareText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, SCRIPT_MTMOONB2F_DEFEATED_SUPER_NERD
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
	jr .done
.check_all_fossils
	call MtMoonB2FCheckHasAllOtherFossils
	jr z, .got_a_fossil
	ld hl, MtMoonB2FSuperNerdFoundThemAllText
	call PrintText
	call MtMoonB2FGiveSuperNerdFossil
	jr .done
.got_a_fossil
	ld hl, MtMoonB2FSuperNerdTheresAPokemonLabText
	call PrintText
	jr .done
.got_reward_fossil
	ld hl, MtMoonB2FSuperNerdAfterRewardText
	call PrintText
.done
	jp TextScriptEnd

MtMoonB2FRocket1Text:
	text_asm
	ld hl, MtMoon3TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

MtMoonB2FRocket2Text:
	text_asm
	ld hl, MtMoon3TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

MtMoonB2FRocket3Text:
	text_asm
	ld hl, MtMoon3TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

MtMoonB2FRocket4Text:
	text_asm
	ld hl, MtMoon3TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

MtMoonB2FDomeFossilText:
	text_asm
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, .YouWantText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done
	lb bc, DOME_FOSSIL, 1
	call GiveItem
	jp nc, MtMoonB2FYouHaveNoRoomText
	call MtMoonB2FReceivedFossilText
	ld de, TOGGLE_MT_MOON_B2F_FOSSIL_1
	predef HideObject
	SetEvent EVENT_GOT_DOME_FOSSIL
	ld a, SCRIPT_MTMOONB2F_MOVE_SUPER_NERD
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

.YouWantText:
	text_far _MtMoonB2FDomeFossilYouWantText
	text_end

MtMoonB2FHelixFossilText:
	text_asm
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, .YouWantText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done
	lb bc, HELIX_FOSSIL, 1
	call GiveItem
	jp nc, MtMoonB2FYouHaveNoRoomText
	call MtMoonB2FReceivedFossilText
	ld de, TOGGLE_MT_MOON_B2F_FOSSIL_2
	predef HideObject
	SetEvent EVENT_GOT_HELIX_FOSSIL
	ld a, SCRIPT_MTMOONB2F_MOVE_SUPER_NERD
	ld [wMtMoonB2FCurScript], a
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

.YouWantText:
	text_far _MtMoonB2FHelixFossilYouWantText
	text_end

MtMoonB2FReceivedFossilText:
	ld hl, .Text
	jp PrintText

.Text:
	text_far _MtMoonB2FReceivedFossilText
	sound_get_key_item
	text_waitbutton
	text_end

MtMoonB2FYouHaveNoRoomText:
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text_far _MtMoonB2FYouHaveNoRoomText
	text_waitbutton
	text_end

MtMoonB2FCheckHasAllOtherFossils:
	ld b, ARMOR_FOSSIL
	call IsItemInBag
	ret z
	ld b, CLAW_FOSSIL
	call IsItemInBag
	ret z
	ld b, SKULL_FOSSIL
	call IsItemInBag
	ret z
	ld b, ROOT_FOSSIL
	call IsItemInBag
	ret

IF DEF(_RED)
MtMoonB2FTakeRequiredFossils:
	ld hl, MtMoonB2FRequiredFossils
.loop
	ld a, [hli]
	cp -1
	ret z
	ldh [hItemToRemoveID], a
	push hl
	farcall RemoveItemByID
	pop hl
	jr .loop

MtMoonB2FRequiredFossils:
	db ARMOR_FOSSIL
	db CLAW_FOSSIL
	db SKULL_FOSSIL
	db ROOT_FOSSIL
	db -1
ENDC

MtMoonB2FGiveSuperNerdFossil:
	CheckEvent EVENT_GOT_DOME_FOSSIL
	jr z, .give_dome
	lb bc, HELIX_FOSSIL, 1
	call GiveItem
	jr nc, .bag_full
	call MtMoonB2FReceivedFossilText
	SetEvent EVENT_GOT_MT_MOON_SUPER_NERD_FOSSIL
IF DEF(_RED)
	call MtMoonB2FTakeRequiredFossils
ENDC
	ret
.give_dome
	lb bc, DOME_FOSSIL, 1
	call GiveItem
	jr nc, .bag_full
	call MtMoonB2FReceivedFossilText
	SetEvent EVENT_GOT_MT_MOON_SUPER_NERD_FOSSIL
IF DEF(_RED)
	call MtMoonB2FTakeRequiredFossils
ENDC
	ret
.bag_full
	ld hl, .NoRoomText
	call PrintText
	ret

.NoRoomText:
	text_far _MtMoonB2FYouHaveNoRoomText
	text_waitbutton
	text_end

MtMoonB2FSuperNerdTheyreBothMineText:
	text_far _MtMoonB2FSuperNerdTheyreBothMineText
	text_end

MtMoonB2FSuperNerdOkIllShareText:
	text_far _MtMoonB2FSuperNerdOkIllShareText
	text_end

MtMoonB2fSuperNerdEachTakeOneText:
	text_far _MtMoonB2fSuperNerdEachTakeOneText
	text_end

MtMoonB2FSuperNerdTheresAPokemonLabText:
	text_far _MtMoonB2FSuperNerdTheresAPokemonLabText
	text_end

MtMoonB2FSuperNerdFoundThemAllText:
	text_far _MtMoonB2FSuperNerdFoundThemAllText
	text_end

MtMoonB2FSuperNerdAfterRewardText:
	text_far _MtMoonB2FSuperNerdAfterRewardText
	text_end

MtMoonB2FSuperNerdThenThisIsMineText:
	text_far _MtMoonB2FSuperNerdThenThisIsMineText
	sound_get_key_item
	text_end

MtMoonB2FRocket1BattleText:
	text_far _MtMoonB2FRocket1BattleText
	text_end

MtMoonB2FRocket1EndBattleText:
	text_far _MtMoonB2FRocket1EndBattleText
	text_end

MtMoonB2FRocket1AfterBattleText:
	text_far _MtMoonB2FRocket1AfterBattleText
	text_end

MtMoonB2FRocket2BattleText:
	text_far _MtMoonB2FRocket2BattleText
	text_end

MtMoonB2FRocket2EndBattleText:
	text_far _MtMoonB2FRocket2EndBattleText
	text_end

MtMoonB2FRocket2AfterBattleText:
	text_far _MtMoonB2FRocket2AfterBattleText
	text_end

MtMoonB2FRocket3BattleText:
	text_far _MtMoonB2FRocket3BattleText
	text_end

MtMoonB2FRocket3EndBattleText:
	text_far _MtMoonB2FRocket3EndBattleText
	text_end

MtMoonB2FRocket3AfterBattleText:
	text_far _MtMoonB2FRocket3AfterBattleText
	text_end

MtMoonB2FRocket4BattleText:
	text_far _MtMoonB2FRocket4BattleText
	text_end

MtMoonB2FRocket4EndBattleText:
	text_far _MtMoonB2FRocket4EndBattleText
	text_end

MtMoonB2FRocket4AfterBattleText:
	text_far _MtMoonB2FRocket4AfterBattleText
	text_end
