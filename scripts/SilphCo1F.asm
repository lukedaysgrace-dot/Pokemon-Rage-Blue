SilphCo1F_Script:
	call EnableAutoTextBoxDrawing
	ld de, SilphCo1F_ScriptPointers
	ld a, [wSilphCo1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSilphCo1FCurScript], a
	ret

SilphCo1F_ScriptPointers:
	def_script_pointers
	dw_const SilphCo1FDefaultScript,           SCRIPT_SILPHCO1F_DEFAULT
	dw_const SilphCo1FPetrelBattleScript,      SCRIPT_SILPHCO1F_PETREL_BATTLE
	dw_const SilphCo1FPetrelAfterBattleScript, SCRIPT_SILPHCO1F_PETREL_AFTER_BATTLE
	dw_const SilphCo1FPetrelExitScript,        SCRIPT_SILPHCO1F_PETREL_EXIT

SilphCo1FDefaultScript:
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	jr z, .check_petrel
	CheckAndSetEvent EVENT_SILPH_CO_RECEPTIONIST_AT_DESK
	jr nz, .check_petrel
	ld a, TOGGLE_SILPH_CO_1F_RECEPTIONIST
	ld [wToggleableObjectIndex], a
	predef ShowObject
.check_petrel
	CheckEvent EVENT_BEAT_SILPH_CO_1F_PETREL
	jp nz, .hide_petrel
	ld hl, .PetrelTriggerCoords
	call ArePlayerCoordsInArray
	jp nc, .hide_petrel
	ld a, [wCoordIndex]
	ld [wSavedCoordIndex], a
	xor a
	ldh [hJoyHeld], a
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_SILPHCO1F_PETREL_HOLD_IT
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
	xor a
	ld [wEmotionBubbleSpriteIndex], a ; player
	ld [wWhichEmotionBubble], a ; EXCLAMATION_BUBBLE
	predef EmotionBubble
	ld a, TOGGLE_SILPH_CO_1F_PETREL
	ld [wToggleableObjectIndex], a
	predef ShowObject
	ld a, SILPHCO1F_PETREL
	ldh [hSpriteIndex], a
	ld de, .PetrelApproachMovementLeftEntrance
	ld a, [wSavedCoordIndex]
	cp 2
	jr nz, .got_petrel_movement
	ld de, .PetrelApproachMovementRightEntrance
.got_petrel_movement
	call MoveSprite
	ld a, SCRIPT_SILPHCO1F_PETREL_BATTLE
	jp SilphCo1FSetCurScript
.hide_petrel
	ld a, TOGGLE_SILPH_CO_1F_PETREL
	ld [wToggleableObjectIndex], a
	predef_jump HideObject

.PetrelTriggerCoords:
	dbmapcoord 10, 16
	dbmapcoord 11, 16
	db -1 ; end

.PetrelApproachMovementLeftEntrance:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

.PetrelApproachMovementRightEntrance:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

SilphCo1FSetCurScript:
	ld [wSilphCo1FCurScript], a
	ld [wCurMapScript], a
	ret

SilphCo1FResetCurScript:
	xor a
	ld [wJoyIgnore], a
	jr SilphCo1FSetCurScript

SilphCo1FPetrelBattleScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	ld a, SILPHCO1F_PETREL
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	ld a, TEXT_SILPHCO1F_PETREL
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, SilphCo1FPetrelEndBattleText
	ld de, SilphCo1FPetrelEndBattleText
	call SaveEndBattleTextPointers
	ld a, 2
	ld [wTrainerNo], a
	ld a, OPP_PETREL
	ld [wCurOpponent], a
	ld [wEnemyMonOrTrainerClass], a
	ld a, SCRIPT_SILPHCO1F_PETREL_AFTER_BATTLE
	ld [wSilphCo1FCurScript], a
	ld [wCurMapScript], a
	ld hl, wStatusFlags7
	set BIT_USE_CUR_MAP_SCRIPT, [hl]
	xor a
	ld [wJoyIgnore], a
	ldh [hJoyHeld], a
	ret

SilphCo1FPetrelAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SilphCo1FResetCurScript
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_SILPH_CO_1F_PETREL
	ld a, TEXT_SILPHCO1F_PETREL_AFTER_BATTLE
	ldh [hTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, SILPHCO1F_PETREL
	ldh [hSpriteIndex], a
	ld de, .PetrelExitMovement
	call MoveSprite
	ld a, SCRIPT_SILPHCO1F_PETREL_EXIT
	jp SilphCo1FSetCurScript

.PetrelExitMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

SilphCo1FPetrelExitScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	ld a, TOGGLE_SILPH_CO_1F_PETREL
	ld [wToggleableObjectIndex], a
	predef HideObject
	xor a
	ld [wJoyIgnore], a
	jp SilphCo1FSetCurScript

SilphCo1F_TextPointers:
	def_text_pointers
	dw_const SilphCo1FLinkReceptionistText, TEXT_SILPHCO1F_LINK_RECEPTIONIST
	dw_const SilphCo1FPetrelText,           TEXT_SILPHCO1F_PETREL
	dw_const SilphCo1FPetrelAfterBattleText, TEXT_SILPHCO1F_PETREL_AFTER_BATTLE
	dw_const SilphCo1FPetrelHoldItText,     TEXT_SILPHCO1F_PETREL_HOLD_IT

SilphCo1FLinkReceptionistText:
	text_far _SilphCo1FLinkReceptionistText
	text_end

SilphCo1FPetrelText:
	text_far _SilphCo1FPetrelText
	text_end

SilphCo1FPetrelHoldItText:
	text_far _SilphCo1FPetrelHoldItText
	text_end

SilphCo1FPetrelEndBattleText:
	text_far _SilphCo1FPetrelEndBattleText
	text_end

SilphCo1FPetrelAfterBattleText:
	text_far _SilphCo1FPetrelAfterBattleText
	text_end
