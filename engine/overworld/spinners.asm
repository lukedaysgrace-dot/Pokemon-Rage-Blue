LoadSpinnerArrowTiles::
; 60fps - This ties the spin frame update to an external counter.
; It only updates every 4 overworld updates, and CopyVideoData only runs 1 time
; per update, supplanting 1 DelayFrame in OverworldLoop (see CheckForSpinAndDelay).
; Now there are no wasted frames when this runs, and spin movement is at full speed.
	ld a, [wSpinnerTileFrameCount]
	cp 5
	jr nc, .resetCount	; out of range, reset
	cp 1
	jr nc, .countOK
.resetCount
	ld a, 4
	ld [wSpinnerTileFrameCount], a
.countOK
	ld a, [wSpinnerTileFrameCount]
	dec a
	ld [wSpinnerTileFrameCount], a
	ret nz
	ld a, [wSpritePlayerStateData1ImageIndex]
	srl a
	srl a
	ld hl, SpinnerPlayerFacingDirections
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	ld [wSpritePlayerStateData1ImageIndex], a
	ld a, [wCurMapTileset]
	cp FACILITY
	ld hl, FacilitySpinnerArrows
	jr z, .gotSpinnerArrows
	ld hl, GymSpinnerArrows
.gotSpinnerArrows
	ld a, [wSimulatedJoypadStatesIndex]
	bit 0, a ; even or odd?
	jr nz, .alternateGraphics
	ld de, 6 * 4
	add hl, de
.alternateGraphics
	ld a, $4
	ld bc, $0
.loop
	push af
	push hl
	push bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CopyVideoData
	pop bc
	ld a, $6
	add c
	ld c, a
	pop hl
	pop af
	dec a
	jr nz, .loop
	ret

INCLUDE "data/tilesets/spinner_tiles.asm"

SpinnerPlayerFacingDirections:
; This isn't the order of the facing directions.  Rather, it's a list of
; the facing directions that come next. For example, when the player is
; facing down (00), the next facing direction is left (08).
	db $08 ; down -> left
	db $0C ; up -> right
	db $04 ; left -> up
	db $00 ; right -> down

; these tiles are the animation for the tiles that push the player in dungeons like Rocket HQ
SpinnerArrowAnimTiles:
	INCBIN "gfx/overworld/spinners.2bpp"
