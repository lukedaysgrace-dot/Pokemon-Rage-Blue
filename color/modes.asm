; Runtime adapter for Shin's enhanced overworld palette and tile data.
; Uses Rage Blue's existing GBC transfers, scrolling, fades, and WRAM buffers.
SECTION "Color Modes", ROMX

INCLUDE "color/data/shin_palettes.asm"
; Returns HL pointing at Shin's eight palettes. WRAM bank 1 must be selected.
GetShinOverworldPalettes::
	ld hl, ShinGBCEnhancedOverworldPalettes
	ld a, [wCurMap]
	cp SEAFOAM_ISLANDS_1F
	jr z, .cold
	cp SEAFOAM_ISLANDS_B1F
	jr c, .checkDark
	cp SEAFOAM_ISLANDS_B4F + 1
	jr nc, .checkDark
.cold
	ld hl, ShinGBCEnhancedOverworldPalettes_ColdCavern
.checkDark
	ld a, [wMapPalOffset]
	cp 6
	ret nz
	ld hl, ShinGBCEnhancedOverworldPalettes_DarkCavern
	ret

; Called with WRAM bank 1 selected. Returns with WRAM bank 1 selected.
LoadShinSpritePalettes::
	call GetShinOverworldPalettes
	ld a, 2
	ldh [rWBK], a
	ld de, W2_SprPaletteData
	ld bc, 64
	call CopyData
	ld a, 1
	ld [W2_ForceOBPUpdate], a
	xor a
	ldh [rWBK], a
	ret

; Called with WRAM bank 1 selected. Preserves all registers and WRAM bank.
LoadShinTilesetPalette::
	push af
	push bc
	push de
	push hl
	call GetShinOverworldPalettes
	ld a, 2
	ldh [rWBK], a
	ld de, W2_BgPaletteData
	ld bc, 64
	call CopyData
	xor a
	ldh [rWBK], a
	ld a, [wCurMapTileset]
	ld c, a
	ld b, 0
	ld hl, ShinOverworldTilePalPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld a, [wCurMap]
	ld b, ShinPAL_ENH_OVW_BROWN
	cp SAFFRON_CITY + 1
	jr nc, .gotTownColor
	ld c, a
	ld b, 0
	ld hl, ShinPalSettings_TownSpecialPal
	add hl, bc
	ld b, [hl]
.gotTownColor
	pop hl
	ld a, 2
	ldh [rWBK], a
	ld a, COLOR_MODE_SHIN
	ld [W2_ColorMode], a
	ld a, 1
	ld [W2_TileBasedPalettes], a
	ld de, W2_TilesetPaletteMap
	ld c, TILESET_SIZE
.tileLoop
	ld a, [hli]
	cp 8
	jr c, .storeTile
	ld a, b
.storeTile
	ld [de], a
	inc de
	dec c
	jr nz, .tileLoop
	; Shin uses gray for the font, borders, and other non-overworld tiles.
	ld c, $100 - TILESET_SIZE
	ld a, ShinPAL_ENH_OVW_GRAY
.fontLoop
	ld [de], a
	inc de
	dec c
	jr nz, .fontLoop
	xor a
	ldh [rWBK], a
	pop hl
	pop de
	pop bc
	pop af
	ret
