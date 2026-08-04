CeruleanCaveB1F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, CeruleanCaveB1FTrainerHeaders
	ld de, CeruleanCaveB1F_ScriptPointers
	ld a, [wCeruleanCaveB1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeruleanCaveB1FCurScript], a
	ret

IF DEF(_BLUE)
CeruleanCaveB1FDefaultScript:
	CheckEvent EVENT_BEAT_EXILE_BRUNO
	jp nz, CheckFightingMapTrainers
	ld hl, CeruleanCaveB1FExileBrunoTriggerCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, SCRIPT_CERULEANCAVEB1F_EXILE_BRUNO_APPEARS
	ld [wCeruleanCaveB1FCurScript], a
	ld [wCurMapScript], a
	ret

CeruleanCaveB1FExileBrunoTriggerCoords:
	dbmapcoord 21, 8
	db -1

CeruleanCaveB1FExileBrunoAppearsScript:
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld de, TOGGLE_CERULEANCAVEB1F_EXILE_BRUNO
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
	call CeruleanCaveB1FExileBrunoAllowWalk
	ld de, CeruleanCaveB1FExileBrunoApproachMovement
	ld a, CERULEANCAVEB1F_EXILE_BRUNO
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_CERULEANCAVEB1F_EXILE_BRUNO_APPROACH
	ld [wCeruleanCaveB1FCurScript], a
	ld [wCurMapScript], a
	ret

CeruleanCaveB1FExileBrunoApproachMovement:
	db NPC_MOVEMENT_DOWN
	db -1 ; end

CeruleanCaveB1FExileBrunoAllowWalk:
	call GetSpriteMovementByte2Pointer
	ld [hl], ANY_DIR
	ret

CeruleanCaveB1FExileBrunoApproachScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	call CeruleanCaveB1FExileBrunoFacePlayer
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_CERULEANCAVEB1F_EXILE_BRUNO_BEFORE
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, ExileBrunoEndBattleText
	ld de, ExileBrunoEndBattleText
	call SaveEndBattleTextPointers
	ld a, CERULEANCAVEB1F_EXILE_BRUNO
	ldh [hSpriteIndex], a
	ld [wSpriteIndex], a
	call EngageMapTrainer
	ld a, 1
	ld [wEngagedTrainerSet], a
	call InitBattleEnemyParameters
	ld a, 1
	ld [wGymLeaderNo], a
	ld hl, wStatusFlags4
	set BIT_UNKNOWN_4_1, [hl]
	ld a, SCRIPT_CERULEANCAVEB1F_EXILE_BRUNO_AFTER_BATTLE
	ld [wCeruleanCaveB1FCurScript], a
	ld [wCurMapScript], a
	xor a
	ld [wJoyIgnore], a
	ret

CeruleanCaveB1FExileBrunoAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, CeruleanCaveB1FExileBrunoBattleCancelled
	xor a
	ld [wGymLeaderNo], a
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	call CeruleanCaveB1FExileBrunoFacePlayer
	SetEvent EVENT_BEAT_EXILE_BRUNO
	ld a, TEXT_CERULEANCAVEB1F_EXILE_BRUNO_AFTER
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld de, CeruleanCaveB1FExileBrunoExitMovement
	ld a, CERULEANCAVEB1F_EXILE_BRUNO
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, SCRIPT_CERULEANCAVEB1F_EXILE_BRUNO_EXIT
	ld [wCeruleanCaveB1FCurScript], a
	ld [wCurMapScript], a
	ret

CeruleanCaveB1FExileBrunoExitMovement:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

CeruleanCaveB1FExileBrunoExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld de, TOGGLE_CERULEANCAVEB1F_EXILE_BRUNO
	predef HideObject
	xor a
	ld [wJoyIgnore], a
	ld [wCeruleanCaveB1FCurScript], a
	ld [wCurMapScript], a
	ret

CeruleanCaveB1FExileBrunoBattleCancelled:
	xor a
	ld [wJoyIgnore], a
	ld [wGymLeaderNo], a
	ld [wCeruleanCaveB1FCurScript], a
	ld [wCurMapScript], a
	ret

CeruleanCaveB1FExileBrunoFacePlayer:
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	ld a, CERULEANCAVEB1F_EXILE_BRUNO
	ldh [hSpriteIndex], a
	jp SetSpriteFacingDirectionAndDelay
ENDC

CeruleanCaveB1F_ScriptPointers:
	def_script_pointers
IF DEF(_BLUE)
	dw_const CeruleanCaveB1FDefaultScript,                 SCRIPT_CERULEANCAVEB1F_DEFAULT
ELSE
	dw_const CheckFightingMapTrainers,                     SCRIPT_CERULEANCAVEB1F_DEFAULT
ENDC
	dw_const DisplayEnemyTrainerTextAndStartBattle,        SCRIPT_CERULEANCAVEB1F_START_BATTLE
	dw_const EndTrainerBattle,                             SCRIPT_CERULEANCAVEB1F_END_BATTLE
IF DEF(_BLUE)
	dw_const CeruleanCaveB1FExileBrunoAppearsScript,       SCRIPT_CERULEANCAVEB1F_EXILE_BRUNO_APPEARS
	dw_const CeruleanCaveB1FExileBrunoApproachScript,      SCRIPT_CERULEANCAVEB1F_EXILE_BRUNO_APPROACH
	dw_const CeruleanCaveB1FExileBrunoAfterBattleScript,  SCRIPT_CERULEANCAVEB1F_EXILE_BRUNO_AFTER_BATTLE
	dw_const CeruleanCaveB1FExileBrunoExitScript,         SCRIPT_CERULEANCAVEB1F_EXILE_BRUNO_EXIT
ENDC

CeruleanCaveB1F_TextPointers:
	def_text_pointers
IF DEF(_BLUE)
	dw_const CeruleanCaveB1FExileBrunoText,          TEXT_CERULEANCAVEB1F_EXILE_BRUNO
ENDC
	dw_const CeruleanCaveB1FMewtwoText,              TEXT_CERULEANCAVEB1F_MEWTWO
	dw_const PickUpItemText,                         TEXT_CERULEANCAVEB1F_ULTRA_BALL
	dw_const PickUpItemText,                         TEXT_CERULEANCAVEB1F_MAX_REVIVE
IF DEF(_BLUE)
	dw_const ExileBrunoBeforeBattleText,             TEXT_CERULEANCAVEB1F_EXILE_BRUNO_BEFORE
	dw_const ExileBrunoAfterBattleText,              TEXT_CERULEANCAVEB1F_EXILE_BRUNO_AFTER
ENDC

CeruleanCaveB1FTrainerHeaders:
	def_trainers
MewtwoTrainerHeader:
	trainer EVENT_BEAT_MEWTWO, 0, MewtwoBattleText, MewtwoBattleText, MewtwoBattleText
	db -1 ; end

IF DEF(_BLUE)
CeruleanCaveB1FExileBrunoText:
	text_asm
	CheckEvent EVENT_BEAT_EXILE_BRUNO
	jp nz, TextScriptEnd
	ld a, TEXT_CERULEANCAVEB1F_EXILE_BRUNO_BEFORE
	ldh [hTextID], a
	jp DisplayTextID

ExileBrunoBeforeBattleText:
	text_far _ExileBrunoBeforeBattleText
	text_end

ExileBrunoEndBattleText:
	text_far _ExileBrunoEndBattleText
	text_end

ExileBrunoAfterBattleText:
	text_far _ExileBrunoAfterBattleText
	text_end
ENDC

CeruleanCaveB1FMewtwoText:
	text_asm
	ld hl, MewtwoTrainerHeader
	call TalkToTrainer
	jp TextScriptEnd

MewtwoBattleText:
	text_far _MewtwoBattleText
	text_asm
	ld a, MEWTWO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
