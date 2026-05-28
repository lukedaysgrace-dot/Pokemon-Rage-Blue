IndigoPlateau_Script:
	call EnableAutoTextBoxDrawing
	ld hl, IndigoPlateau_ScriptPointers
	ld a, [wCurMapScript]
	cp 3
	jr c, .script_ok
	xor a
	ld [wCurMapScript], a
.script_ok
	jp CallFunctionInTable

IndigoPlateau_ScriptPointers:
	def_script_pointers
	dw_const IndigoPlateauDefaultScript,      SCRIPT_INDIGOPLATEAU_DEFAULT
	dw_const IndigoPlateauGrampsBlockScript,  SCRIPT_INDIGOPLATEAU_GRAMPS_BLOCK
	dw_const IndigoPlateauPlayerBackScript,   SCRIPT_INDIGOPLATEAU_PLAYER_BACK

IndigoPlateauDefaultScript:
	call IndigoPlateauUpdateGrampsVisibility
	call IndigoPlateauShouldShowGramps
	and a
	ret z
	ld hl, IndigoPlateauGrampsTriggerCoords
	call ArePlayerCoordsInArray
	ret nc
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	call IndigoPlateauMoveGrampsInFrontOfPlayer
	ld a, SCRIPT_INDIGOPLATEAU_GRAMPS_BLOCK
	ld [wCurMapScript], a
	ret

IndigoPlateauGrampsTriggerCoords:
	dbmapcoord  9,  7
	dbmapcoord 10,  7
	db -1 ; end

IndigoPlateauMoveGrampsInFrontOfPlayer:
	ld a, INDIGOPLATEAU_GRAMPS
	ldh [hSpriteIndex], a
	ld a, SPRITESTATEDATA2_MAPX
	ldh [hSpriteDataOffset], a
	call GetPointerWithinSpriteStateData2
	ld a, [wXCoord]
	cp 10
	jr z, .rightDoor
	ld a, [hl]
	cp 9 + 4
	ret z
	ld de, IndigoPlateauGrampsMoveLeft
	jr .move
.rightDoor
	ld a, [hl]
	cp 10 + 4
	ret z
	ld de, IndigoPlateauGrampsMoveRight
.move
	ld a, INDIGOPLATEAU_GRAMPS
	ldh [hSpriteIndex], a
	jp MoveSprite

IndigoPlateauGrampsMoveLeft:
	db NPC_MOVEMENT_LEFT
	db -1 ; end

IndigoPlateauGrampsMoveRight:
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

IndigoPlateauGrampsBlockScript:
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_NPC_MOVEMENT, a
	ret nz
	xor a ; SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	ld a, INDIGOPLATEAU_GRAMPS
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	ld a, TEXT_INDIGOPLATEAU_GRAMPS
	ldh [hTextID], a
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a
	call DisplayTextID
	call IndigoPlateauKickPlayerDown
	ld a, SCRIPT_INDIGOPLATEAU_PLAYER_BACK
	ld [wCurMapScript], a
	ret

IndigoPlateauKickPlayerDown:
	ld a, PAD_BUTTONS | PAD_CTRL_PAD
	ld [wJoyIgnore], a
	xor a
	ld [wPlayerJumpingYScreenCoordsIndex], a
	ld hl, wMovementFlags
	set BIT_LEDGE_OR_FISHING, [hl]
	call StartSimulatingJoypadStates
	ld a, PAD_DOWN
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSimulatedJoypadStatesEnd + 1], a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, $2
	ld [wSimulatedJoypadStatesIndex], a
	farcall LoadHoppingShadowOAM
	ld a, SFX_PUSH_BOULDER
	jp PlaySound

IndigoPlateauPlayerBackScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	ld a, [wMovementFlags]
	bit BIT_LEDGE_OR_FISHING, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

IndigoPlateauUpdateGrampsVisibility:
	call IndigoPlateauShouldShowGramps
	and a
	jr z, IndigoPlateauHideGramps
	ld a, INDIGOPLATEAU_GRAMPS
	swap a
	ldh [hCurrentSpriteOffset], a
	predef IsObjectHidden
	ldh a, [hIsToggleableObjectOff]
	and a
	ret z
	ld a, TOGGLE_INDIGO_PLATEAU_GRAMPS
	ld [wToggleableObjectIndex], a
	predef_jump ShowObject

IndigoPlateauHideGramps:
	ld a, INDIGOPLATEAU_GRAMPS
	swap a
	ldh [hCurrentSpriteOffset], a
	predef IsObjectHidden
	ldh a, [hIsToggleableObjectOff]
	and a
	ret nz
	ld a, TOGGLE_INDIGO_PLATEAU_GRAMPS
	ld [wToggleableObjectIndex], a
	predef_jump HideObject

IndigoPlateauShouldShowGramps:
	ld a, [wNumHoFTeams]
	and a
	jr z, .hide
	CheckEvent EVENT_REMATCH_DEFEATED_BROCK
	jr z, .show
	CheckEvent EVENT_REMATCH_DEFEATED_MISTY
	jr z, .show
	CheckEvent EVENT_REMATCH_DEFEATED_LT_SURGE
	jr z, .show
	CheckEvent EVENT_REMATCH_DEFEATED_ERIKA
	jr z, .show
	CheckEvent EVENT_REMATCH_DEFEATED_KOGA
	jr z, .show
	CheckEvent EVENT_REMATCH_DEFEATED_SABRINA
	jr z, .show
	CheckEvent EVENT_REMATCH_DEFEATED_BLAINE
	jr z, .show
	CheckEvent EVENT_REMATCH_DEFEATED_GIOVANNI
	jr z, .show
.hide
	xor a
	ret
.show
	ld a, TRUE
	ret

IndigoPlateau_TextPointers:
	def_text_pointers
	dw_const IndigoPlateauGrampsText, TEXT_INDIGOPLATEAU_GRAMPS

IndigoPlateauGrampsText:
	text "Hohoho, the"
	line "ELITE FOUR are"
	cont "currently"
	cont "training, kid."

	para "Come back after"
	line "you've managed"
	cont "to beat all of"
	cont "KANTO's GYM"
	cont "LEADERS at their"
	cont "full strength."
	done
