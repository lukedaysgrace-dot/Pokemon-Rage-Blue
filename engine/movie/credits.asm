HallOfFamePC:
	farcall AnimateHallOfFame
	call ClearSprites
	jp CreditsRollOnly

; Entry for scripts that want scrolling credits only (no Hall of Fame party sequence).
; Keep Cinnabar's player sprite during the introduction; Credits hides it
; when the credit words begin.
CreditsRollOnly:
	ld a, $ff ; $ff freezes the OAM buffer as is (0 would hide every sprite)
	ld [wUpdateSpritesEnabled], a
	call ClearScreen
	ld c, 100
	call DelayFrames
	call LoadFontTilePatterns
	call LoadTextBoxTilePatterns
	call DisableLCD
	ld hl, vFont
	ld bc, ($80 tiles) / 2
	call ShiftFontColorIndex
	ld hl, vChars2 tile $60
	ld bc, ($20 tiles) / 2
	call ShiftFontColorIndex
	ld hl, vChars2 tile $7e
	ld bc, TILE_SIZE
	ld a, $ff ; solid black
	call FillMemory
	hlcoord 0, 0
	call FillFourRowsWithBlack
	hlcoord 0, 14
	call FillFourRowsWithBlack
	ld a, %11000000
	ldh [rBGP], a
	call EnableLCD
	ld a, SFX_STOP_ALL_MUSIC
	call PlaySoundWaitForCurrent
	call PlayCreditsMusic
	ld c, 128
	call DelayFrames
	xor a
	ld [wUnusedCreditsByte], a ; not read
	ld [wNumCreditsMonsDisplayed], a
	jp Credits

; Cinnabar Island ending: keep only the player's sprite for the introduction,
; preserving its overworld screen position and facing after the battle.
CreditsKeepPlayerSprite::
	call UpdateSprites
	call DelayFrame
	ld a, $ff ; freeze the OAM buffer: no more overworld sprite updates
	ld [wUpdateSpritesEnabled], a
; hide every OBJ except the player's four (wShadowOAMSprite00-03)
	xor a
	ld hl, wShadowOAMSprite04
	ld b, (OAM_COUNT - 4) * OBJ_SIZE
.clearLoop
	ld [hli], a
	dec b
	jr nz, .clearLoop
	ret

PlayCreditsMusic:
; Music IDs are full, so initialize bank 2 with a 3-channel song ID,
; then point the active music channels at the credits data.
	ld c, BANK(Music_Credits_Ch1)
	ld a, MUSIC_DEFEATED_GYM_LEADER
	call PlayMusic
	ld hl, wChannelCommandPointers + CHAN1 * 2
	ld de, Music_Credits_Ch1
	call .setChannelPointer
	ld hl, wChannelCommandPointers + CHAN2 * 2
	ld de, Music_Credits_Ch2
	call .setChannelPointer
	ld hl, wChannelCommandPointers + CHAN3 * 2
	ld de, Music_Credits_Ch3
	call .setChannelPointer
	ret

.setChannelPointer
	ld [hl], e
	inc hl
	ld [hl], d
	ret

FadeInCredits:
	ld hl, HoFGBPalettes
	ld b, 4
.loop
	ld a, [hli]
	ldh [rBGP], a
	ld c, 5
	call DelayFrames
	dec b
	jr nz, .loop
	ret

DisplayCreditsMon:
	xor a
	ldh [hAutoBGTransferEnabled], a
	call SaveScreenTilesToBuffer1
	call FillMiddleOfScreenWithWhite

	; display the next monster from CreditsMons
	ld hl, wNumCreditsMonsDisplayed
	ld c, [hl] ; how many monsters have we displayed so far?
	inc [hl]
	ld b, 0
	ld hl, CreditsMons
	add hl, bc ; go that far in the list of monsters and get the next one
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	hlcoord 8, 6
	call GetMonHeader
	call LoadFrontSpriteByMonIndex
	ld hl, vBGMap0 + $c
	call CreditsCopyTileMapToVRAM
	xor a
	ldh [hAutoBGTransferEnabled], a
	call LoadScreenTilesFromBuffer1
	ld hl, vBGMap0
	call CreditsCopyTileMapToVRAM
	ld a, $A7
	ldh [rWX], a
	ld hl, vBGMap1
	call CreditsCopyTileMapToVRAM
	call FillMiddleOfScreenWithWhite
	ld a, %11111100 ; make the mon a black silhouette
	ldh [rBGP], a

; scroll the mon left by one tile 7 times
	ld bc, 7
.scrollLoop1
	call ScrollCreditsMonLeft
	dec c
	jr nz, .scrollLoop1

; scroll the mon left by one tile 20 times
; This time, we have to move the window left too in order to hide the text that
; is wrapping around to the right side of the screen.
	ld c, 20
.scrollLoop2
	call ScrollCreditsMonLeft
	ldh a, [rWX]
	sub 8
	ldh [rWX], a
	dec c
	jr nz, .scrollLoop2

	xor a
	ldh [hWY], a
	ld a, %11000000
	ldh [rBGP], a
	ret

INCLUDE "data/credits/credits_mons.asm"

ScrollCreditsMonLeft:
	ld h, b
	ld l, $20
	call ScrollCreditsMonLeft_SetSCX
	ld h, $0
; Reset SCX below the mon (pic rows end at line 103). The vanilla split line $70
; falls inside the GBC color code's LYC=$6E interrupt (lines ~110-115), so the
; exact-LY wait in ScrollCreditsMonLeft_SetSCX never saw it and the credits hung.
	ld l, $68
	call ScrollCreditsMonLeft_SetSCX
	ld a, b
	add $8
	ld b, a
	ret

ScrollCreditsMonLeft_SetSCX:
	ldh a, [rLY]
	cp l
	jr nz, ScrollCreditsMonLeft_SetSCX
	ld a, h
	ldh [rSCX], a
.loop
	ldh a, [rLY]
	cp h
	jr z, .loop
	ret

HoFGBPalettes:
	dc 3, 0, 0, 0
	dc 3, 1, 0, 0
	dc 3, 2, 0, 0
	dc 3, 3, 0, 0

CreditsCopyTileMapToVRAM:
	ld a, l
	ldh [hAutoBGTransferDest], a
	ld a, h
	ldh [hAutoBGTransferDest + 1], a
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	jp Delay3

ShiftFontColorIndex:
; Zero every second byte at hl, writing a total of bc bytes.
; When used on VRAM font characters that contain only black and white shades,
; it shifts the color index: black -> light gray, allowing palette-controlled
; text fade-in during the Credits roll, while the black bars remain solid.
	ld [hl], 0
	inc hl
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, ShiftFontColorIndex
	ret

FillFourRowsWithBlack:
	ld bc, SCREEN_WIDTH * 4
	ld a, $7e
	jp FillMemory

FillMiddleOfScreenWithWhite:
	hlcoord 0, 4
	ld bc, SCREEN_WIDTH * 10
	ld a, ' '
	jp FillMemory

Credits:
	call ClearSprites
	farcall SetPal_Credits
	ld hl, vBGMap0
	call CreditsCopyTileMapToVRAM
	ld de, CreditsOrder
	push de
.nextCreditsScreen
	pop de
	hlcoord 9, 6
	push hl
	call FillMiddleOfScreenWithWhite
	pop hl
.nextCreditsCommand
	ld a, [de]
	inc de
	push de
	cp CRED_TEXT_FADE_MON
	jr z, .fadeInTextAndShowMon
	cp CRED_TEXT_MON
	jr z, .showTextAndShowMon
	cp CRED_TEXT_FADE
	jr z, .fadeInText
	cp CRED_TEXT
	jr z, .showText
	cp CRED_COPYRIGHT
	jr z, .showCopyrightText
	cp CRED_THE_END
	jr z, .showTheEnd
	push hl
	push hl
	ld hl, CreditsTextPointers
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [de]
	inc de
	ld c, a
	ld b, -1
	pop hl
	add hl, bc
	call PlaceString
	pop hl
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	pop de
	jr .nextCreditsCommand
.fadeInTextAndShowMon
	call FadeInCredits
	ld c, 90
	jr .next1
.showTextAndShowMon
	ld c, 110
.next1
	call DelayFrames
	call DisplayCreditsMon
	jr .nextCreditsScreen
.fadeInText
	call FadeInCredits
	ld c, 120
	jr .next2
.showText
	ld c, 140
.next2
	call DelayFrames
	jr .nextCreditsScreen
.showCopyrightText
	push de
	farcall LoadCopyrightTiles
	pop de
	pop de
	jr .nextCreditsCommand
.showTheEnd
	ld c, 16
	call DelayFrames
	call FillMiddleOfScreenWithWhite
	pop de
	ld de, TheEndGfx
	ld hl, vChars2 tile $60
	lb bc, BANK(TheEndGfx), (TheEndGfxEnd - TheEndGfx) / TILE_SIZE
	call CopyVideoData
	hlcoord 4, 8
	ld de, TheEndTextString
	call PlaceString
	hlcoord 4, 9
	inc de
	call PlaceString
	jp FadeInCredits

TheEndTextString:
; "T H E  E N D"
	db $60," ",$62," ",$64,"  ",$64," ",$66," ",$68,"@"
	db $61," ",$63," ",$65,"  ",$65," ",$67," ",$69,"@"

INCLUDE "data/credits/credits_order.asm"

INCLUDE "data/credits/credits_text.asm"

TheEndGfx:
	INCBIN "gfx/credits/the_end.2bpp"
TheEndGfxEnd:
