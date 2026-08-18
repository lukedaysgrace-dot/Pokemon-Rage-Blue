; Field HM prompts (A button / boulder / town map fly) with:
; - matching vanilla badge gates (except Flash: none)
; - matching HM item in bag
; - any party #MON that can learn the move (TM/HM table), without teaching it

TryTownMapFlyEligibility::
	ld a, [wObtainedBadges]
	bit BIT_THUNDERBADGE, a
	jr z, .no
	ld b, HM_FLY
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	jr z, .no
	ld a, HM02_MOVE
	call PartyAnyCanLearnMove
	ret
.no
	and a
	ret

PartyAnyCanLearnMove::
; a = move id. Returns carry if at least one party member can learn it.
	ld [wMoveNum], a
	ld hl, wPartySpecies
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
.loop
	ld a, [hl]
	ld [wCurPartySpecies], a
	push hl
	push bc
	predef CanLearnTM
	ld a, c
	pop bc
	pop hl
	inc hl
	and a
	scf
	ret nz
	inc b
	ld a, b
	cp c
	jr nz, .loop
	and a
	ret

FindFirstPartyMonIndexCanLearnMove::
; wMoveNum = move id. Returns index in a, or $ff if none.
	ld hl, wPartySpecies
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
.loop
	ld a, [hl]
	ld [wCurPartySpecies], a
	push hl
	push bc
	predef CanLearnTM
	ld a, c
	pop bc
	pop hl
	and a
	jr nz, .found
	inc hl
	inc b
	ld a, b
	cp c
	jr nz, .loop
	ld a, $ff
	ret
.found
	ld a, b
	ret

VerifyCutAllowFromPartyMenu::
	ld a, [wObtainedBadges]
	bit BIT_CASCADEBADGE, a
	jp z, FieldHMPrintNeedBadgeText
	ld b, HM_CUT
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	jp z, FieldHMPrintNeedHMText
	ld a, HM01_MOVE
	call PartyAnyCanLearnMove
	jp nc, FieldHMPrintNeedHMText
	scf
	ret

VerifySurfAllowFromPartyMenu::
	ld a, [wObtainedBadges]
	bit BIT_SOULBADGE, a
	jp z, FieldHMPrintNeedBadgeText
	ld b, HM_SURF
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	jp z, FieldHMPrintNeedHMText
	ld a, HM03_MOVE
	call PartyAnyCanLearnMove
	jp nc, FieldHMPrintNeedHMText
	scf
	ret

VerifyStrengthAllowFromPartyMenu::
	ld a, [wObtainedBadges]
	bit BIT_RAINBOWBADGE, a
	jp z, FieldHMPrintNeedBadgeText
	ld b, HM_STRENGTH
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	jp z, FieldHMPrintNeedHMText
	ld a, HM04_MOVE
	call PartyAnyCanLearnMove
	jp nc, FieldHMPrintNeedHMText
	scf
	ret

VerifyFlashAllowFromPartyMenu::
	ld b, HM_FLASH
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	jp z, FieldHMPrintNeedHMText
	ld a, HM05_MOVE
	call PartyAnyCanLearnMove
	jp nc, FieldHMPrintNeedHMText
	scf
	ret

VerifyFlyAllowFromPartyMenu::
	ld a, [wObtainedBadges]
	bit BIT_THUNDERBADGE, a
	jp z, FieldHMPrintNeedBadgeText
	ld b, HM_FLY
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	jp z, FieldHMPrintNeedHMText
	ld a, HM02_MOVE
	call PartyAnyCanLearnMove
	jp nc, FieldHMPrintNeedHMText
	scf
	ret

FieldHMPrintNeedBadgeText::
	ld hl, NewBadgeRequiredText
	call PrintText
	and a
	ret

FieldHMPrintNeedHMText::
	ld hl, NeedHMOrCompatibleMonText
	call PrintText
	and a
	ret

NewBadgeRequiredText::
	text_far _NewBadgeRequiredText
	text_end

NeedHMOrCompatibleMonText::
	text_far _NeedHMOrCompatibleMonText
	text_end

FieldHMBeforePrintText::
; Overworld keeps hAutoBGTransferEnabled off; PrintText only updates WRAM unless
; we run the same setup as DisplayTextID (font, one VRAM sync, window, transfer on).
; DisplayTextIDInit uses hTextID==0 for the START menu text box layout; field HM
; runs with hTextID 0 (no NPC), so force a non-zero value for the standard dialog box.
; Do not set BIT_NO_AUTO_TEXT_BOX here — that skips TextBoxBorder and leaves text
; drawing at the wrong coordinates.
	ldh a, [hTextID]
	push af
	ld a, 1
	ldh [hTextID], a
	ld a, [wAutoTextBoxDrawingControl]
	push af
	xor a
	ld [wAutoTextBoxDrawingControl], a
	farcall DisplayTextIDInit
	pop af
	ld [wAutoTextBoxDrawingControl], a
	pop af
	ldh [hTextID], a
	ret

TryFieldHMInteraction::
	xor a
	ld [wFieldHMInteractionResult], a
	predef GetTileAndCoordsInFrontOfPlayer
	ld a, [wWalkBikeSurfState]
	cp 2
	call z, TryPromptStopSurfingIfPossible
	ld a, [wFieldHMInteractionResult]
	and a
	ret nz
	call TryPromptCutOnTile
	ld a, [wFieldHMInteractionResult]
	and a
	ret nz
	call TryPromptSurfFromShore
	ld a, [wFieldHMInteractionResult]
	and a
	ret nz
	call TryPromptFlashInDark
	ret

TryPromptStopSurfingIfPossible::
	xor a
	ldh [hSpriteIndex], a
	ld d, 16
	call IsSpriteInFrontOfPlayer2
	res BIT_FACE_PLAYER, [hl]
	ldh a, [hSpriteIndex]
	and a
	ret nz
	ld hl, TilePairCollisionsWater
	call CheckForTilePairCollisions2
	ret c
	ld hl, wTilesetCollisionPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wTileInFrontOfPlayer]
	ld b, a
.passLoop
	ld a, [hli]
	cp b
	jr z, .ask
	cp $ff
	jr nz, .passLoop
	ret
.ask
	call FieldHMBeforePrintText
	ld hl, StopSurfingPromptText
	call PrintText
	call YesNoChoice
	jr c, .stopSurfNo
	ld a, SURFBOARD
	ld [wCurItem], a
	ld [wPseudoItemID], a
	call UseItem
	ld a, [wActionResultOrTookBattleTurn]
	and a
	jr z, .stopSurfNo
	ld a, 1
	ld [wFieldHMInteractionResult], a
	call CloseFieldHMAfterText
	ret
.stopSurfNo
	call CloseFieldHMAfterText
	ret

TryPromptCutOnTile::
	ld a, [wWalkBikeSurfState]
	cp 2
	ret z
	xor a
	ld [wActionResultOrTookBattleTurn], a
	ld a, [wCurMapTileset]
	and a ; OVERWORLD
	jr z, .overworld
	cp GYM
	ret nz
	ld a, [wTileInFrontOfPlayer]
	cp $50
	jr z, .checkGate
	ret
.overworld
	ld a, [wTileInFrontOfPlayer]
	cp $3d
	jr z, .checkGate
	cp $52
	ret nz
.checkGate
	ld a, [wObtainedBadges]
	bit BIT_CASCADEBADGE, a
	ret z
	ld b, HM_CUT
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	ret z
	ld a, HM01_MOVE
	ld [wMoveNum], a
	call PartyAnyCanLearnMove
	ret nc
; Same as choosing Pokémon from the Start menu: save overworld before HM UI so
; UsedCut's RestoreScreenTilesAndReloadTilePatterns -> LoadScreenTilesFromBuffer2
; matches party menu (start_menu.asm SaveScreenTilesToBuffer2).
	call SaveScreenTilesToBuffer2
	call FieldHMBeforePrintText
	ld hl, UseCutPromptText
	call PrintText
	call YesNoChoice
	jr c, .cutNo
	call FindFirstPartyMonIndexCanLearnMove
	cp $ff
	jr z, .cutNo
	ld [wWhichPokemon], a
	ld a, 1
	ld [wFieldHMCutSkipPalWhiteout], a
	predef UsedCut
	xor a
	ld [wFieldHMCutSkipPalWhiteout], a
	ld a, [wActionResultOrTookBattleTurn]
	and a
	jr z, .cutNo
	ld a, 1
	ld [wFieldHMInteractionResult], a
; Party .cut: jp CloseTextDisplay (start_sub_menus.asm). Stack needs push af for pop af.
	ldh a, [hLoadedROMBank]
	push af
	jp CloseTextDisplay
.cutNo
	call CloseFieldHMAfterText
	ret

TryPromptSurfFromShore::
	ld a, [wWalkBikeSurfState]
	cp 2
	ret z
	farcall IsSurfingAllowed
	ld hl, wStatusFlags1
	bit BIT_SURF_ALLOWED, [hl]
	res BIT_SURF_ALLOWED, [hl]
	ret z
	ld a, [wObtainedBadges]
	bit BIT_SOULBADGE, a
	ret z
	ld b, HM_SURF
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	ret z
	ld a, HM03_MOVE
	call PartyAnyCanLearnMove
	ret nc
	farcall IsNextTileShoreOrWater
	ret c
	ld hl, TilePairCollisionsWater
	call CheckForTilePairCollisions2
	ret c
	call SaveScreenTilesToBuffer2
	call FieldHMBeforePrintText
	ld hl, UseSurfPromptText
	call PrintText
	call YesNoChoice
	jr c, .surfNo
	ld a, HM03_MOVE
	ld [wMoveNum], a
	call FindFirstPartyMonIndexCanLearnMove
	cp $ff
	jr z, .surfNo
	ld [wWhichPokemon], a
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld a, SURFBOARD
	ld [wCurItem], a
	ld [wPseudoItemID], a
	call UseItem
	ld a, [wWalkBikeSurfState]
	cp 2
	jr z, .surfSuccess
	ld a, [wActionResultOrTookBattleTurn]
	and a
	jr z, .surfFailed
.surfSuccess
	ld a, 1
	ld [wFieldHMInteractionResult], a
; Party .surf: GBPalWhiteOutWithDelay3, goBackToMap (RestoreScreenTiles...),
; CloseTextDisplay (start_sub_menus.asm).
	ldh a, [hLoadedROMBank]
	push af
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	xor a
	ldh [hAutoBGTransferEnabled], a
	call DelayFrame
	call RestoreScreenTilesAndReloadTilePatterns
	ld a, $01
	ldh [hAutoBGTransferEnabled], a
	jp CloseTextDisplay
.surfFailed
.surfNo
	call CloseFieldHMAfterText
	ret

TryPromptFlashInDark::
	ld a, [wWalkBikeSurfState]
	cp 2
	ret z
	ld a, [wMapPalOffset]
	and a
	ret z
	ld b, HM_FLASH
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	ret z
	ld a, HM05_MOVE
	call PartyAnyCanLearnMove
	ret nc
	call SaveScreenTilesToBuffer2
	call FieldHMBeforePrintText
	ld hl, UseFlashPromptText
	call PrintText
	call YesNoChoice
	jr c, .flashNo
	xor a
	ld [wMapPalOffset], a
	ld hl, FlashLightsAreaText
	call PrintText
	ld a, 1
	ld [wFieldHMInteractionResult], a
	jr .flashAfterText
.flashNo
	xor a
	ld [wFieldHMInteractionResult], a
.flashAfterText
	ldh a, [hLoadedROMBank]
	push af
	call GBPalWhiteOutWithDelay3
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	xor a
	ldh [hAutoBGTransferEnabled], a
	call DelayFrame
	call RestoreScreenTilesAndReloadTilePatterns
	ld a, $01
	ldh [hAutoBGTransferEnabled], a
	jp CloseTextDisplay

FlashLightsAreaText::
	text_far _FlashLightsAreaText
	text_end

FieldHM_ReprimeScriptedPlayerStepAfterText::
; ItemUseSurfboard queues a one-step simulated pad press. Text/cleanup may
; clear BIT_SCRIPTED before we get here — if we're surfing, always re-arm it.
	ld a, [wWalkBikeSurfState]
	cp 2
	jr z, .setScriptedAndQueue
	ld a, [wStatusFlags5]
	bit BIT_SCRIPTED_MOVEMENT_STATE, a
	ret z
	jr .queuePad
.setScriptedAndQueue
	ld hl, wStatusFlags5
	set BIT_SCRIPTED_MOVEMENT_STATE, [hl]
.queuePad
	ld a, [wPlayerDirection]
	bit PLAYER_DIR_BIT_UP, a
	ld b, PAD_UP
	jr nz, .storePad
	bit PLAYER_DIR_BIT_DOWN, a
	ld b, PAD_DOWN
	jr nz, .storePad
	bit PLAYER_DIR_BIT_LEFT, a
	ld b, PAD_LEFT
	jr nz, .storePad
	ld b, PAD_RIGHT
.storePad
	ld a, b
	ld [wSimulatedJoypadStatesEnd], a
	xor a
	ld [wUnusedSimulatedJoypadStatesMask], a
	inc a
	ld [wSimulatedJoypadStatesIndex], a
	ret

CloseFieldHMAfterText::
; Used when the player declines HM text or for stop-surf cleanup (not field Flash;
; Flash uses SaveScreenTilesToBuffer2 + RestoreScreenTilesAndReloadTilePatterns
; + CloseTextDisplay like party Flash / Surf success).
; Surf/Cut success use the party-menu tail: RestoreScreenTilesAndReloadTilePatterns
; and jp CloseTextDisplay (FieldHMBeforePrintText runs DisplayTextIDInit, which
; fills OrigFacingDirection like NPC dialogue).
; ROMX: use farcall InitMapSprites, never raw call across banks.
	call GBPalWhiteOutWithDelay3
	ldh a, [hLoadedROMBank]
	push af
; Do NOT call SwitchToMapRomBank here: this routine runs from ROMX, so remapping
; $4000-$7fff makes its `ret` land in the map's bank and execute map data.
; Nothing below needs the map bank - LoadCurrentMapView banks itself from
; wTilesetBank, InitMapSprites is a farcall, and the rest is ROM0.
	ld a, $90
	ldh [hWY], a
	call DelayFrame
	call LoadGBPal
	xor a
	ldh [hAutoBGTransferEnabled], a
; Same order as CloseTextDisplay (after text): InitMapSprites while font tiles
; may still be in VRAM, then clear BIT_FONT_LOADED. Do not use DisableLCD /
; wSpriteSetID=0 / LoadFontTilePatterns here — mirroring ReloadMapSpriteTilePatterns
; mid-overworld corrupted sprite VRAM (garbled player, door hang, cut crash).
	farcall InitMapSprites
	ld hl, wFontLoaded
	res BIT_FONT_LOADED, [hl]
	ld a, [wStatusFlags6]
	bit BIT_FLY_WARP, a
	call z, LoadPlayerSpriteGraphics
	call LoadCurrentMapView
	pop af
	ldh [hLoadedROMBank], a
	ld [rROMB], a
	ld a, 1
	ld [wUpdateSpritesEnabled], a
	call UpdateSprites
	call FieldHM_ReprimeScriptedPlayerStepAfterText
	xor a
	ld [wJoyIgnore], a
	ret

UseCutPromptText::
	text_far _UseCutPromptText
	text_end

UseSurfPromptText::
	text_far _UseSurfPromptText
	text_end

UseFlashPromptText::
	text_far _UseFlashPromptText
	text_end

StopSurfingPromptText::
	text_far _StopSurfingPromptText
	text_end

FieldStrengthFromBoulderDialogue::
	xor a
	ld [wFieldHMInteractionResult], a
	call GetSpriteMovementByte2Pointer
	ld a, [hl]
	cp BOULDER_MOVEMENT_BYTE_2
	ret nz
	ld a, [wStatusFlags1]
	bit BIT_STRENGTH_ACTIVE, a
	ret nz
	ld a, [wObtainedBadges]
	bit BIT_RAINBOWBADGE, a
	ret z
	ld b, HM_STRENGTH
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	ret z
	ld a, HM04_MOVE
	call PartyAnyCanLearnMove
	ret nc
	call FieldHMBeforePrintText
	ld hl, UseStrengthPromptText
	call PrintText
	call YesNoChoice
	ret c
	ld a, HM04_MOVE
	ld [wMoveNum], a
	call FindFirstPartyMonIndexCanLearnMove
	cp $ff
	ret z
	ld [wWhichPokemon], a
	call PrepareStrengthMonNameAndSpecies
	predef PrintStrengthText
	ld a, 1
	ld [wFieldHMInteractionResult], a
	ret

PrepareStrengthMonNameAndSpecies::
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld a, [wWhichPokemon]
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a
	ret

UseStrengthPromptText::
	text_far _UseStrengthPromptText
	text_end
