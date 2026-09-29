AerodactylFossil:
	ld de, FossilAerodactylPic
	lb bc, BANK(FossilAerodactylPic), $77
	call DisplayFossilFrontSpriteInBox
	call EnableAutoTextBoxDrawing
	tx_pre AerodactylFossilText
	ret

AerodactylFossilText::
	text_far _AerodactylFossilText
	text_end

KabutopsFossil:
	ld de, FossilKabutopsPic
	lb bc, BANK(FossilKabutopsPic), $66
	call DisplayFossilFrontSpriteInBox
	call EnableAutoTextBoxDrawing
	tx_pre KabutopsFossilText
	ret

KabutopsFossilText::
	text_far _KabutopsFossilText
	text_end

DisplayMonFrontSpriteInBox:
; Displays a pokemon's front sprite in a pop-up window.
	call PrepareFrontSpritePopup
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetMonHeader
	jr DisplayFrontSpriteInBoxFromHeader

DisplayFossilFrontSpriteInBox:
; Displays a museum fossil without assigning it a pokemon species ID.
; de = front sprite, b = sprite bank, c = dimensions
	push bc
	push de
	call PrepareFrontSpritePopup
	pop de
	pop bc
	ld hl, wMonHSpriteDim
	ld [hl], c
	inc hl
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, b
	ld [wMonHPicBank], a

DisplayFrontSpriteInBoxFromHeader:
	ld de, vChars1 tile $31
	call LoadMonFrontSprite
	ld a, $80
	ldh [hStartTileID], a
	hlcoord 10, 11
	predef AnimateSendingOutMon
	call WaitForTextScrollButtonPress
	call LoadScreenTilesFromBuffer1
	call Delay3
	ld a, $90
	ldh [hWY], a
	ret

PrepareFrontSpritePopup:
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	xor a
	ldh [hWY], a
	call SaveScreenTilesToBuffer1
	ld a, MON_SPRITE_POPUP
	ld [wTextBoxID], a
	call DisplayTextBoxID
	call UpdateSprites
	ret
