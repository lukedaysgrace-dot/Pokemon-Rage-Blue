; Handles sprite attributes

DEF ATK_PAL_GREY    EQU 0
DEF ATK_PAL_BLUE    EQU 1
DEF ATK_PAL_RED     EQU 2
DEF ATK_PAL_BROWN   EQU 3
DEF ATK_PAL_YELLOW  EQU 4
DEF ATK_PAL_GREEN   EQU 5
DEF ATK_PAL_ICE     EQU 6
DEF ATK_PAL_PURPLE  EQU 7
; 8: color based on attack type
; 9: don't change color palette (assume it's already set properly from elsewhere)


DEF SPR_PAL_ORANGE  EQU 0
DEF SPR_PAL_BLUE    EQU 1
DEF SPR_PAL_GREEN   EQU 2
DEF SPR_PAL_BROWN   EQU 3
DEF SPR_PAL_PURPLE  EQU 4
DEF SPR_PAL_EMOJI   EQU 5
DEF SPR_PAL_OW_DEEP_BLUE EQU 5 ; slot 5 = PAL_OW_MINT peach + blue + black (female Mint)
DEF SPR_PAL_TREE    EQU 6
DEF SPR_PAL_ROCK    EQU 7
DEF SPR_PAL_RANDOM  EQU 8

LoadOverworldSpritePalettes:
	ldh a, [rWBK]
	ld b, a
	xor a
	ldh [rWBK], a
	push bc
	; Does the map we're on use dark/night palettes?
	; Load the matching Object Pals if so
	ld a, [wCurMapTileset]
	ld hl, SpritePalettesNite
	cp CAVERN
	jr z, .gotPaletteList
	; If it is the Pokemon Center, load different pals for the Heal Machine to flash
	ld hl, SpritePalettesPokecenter
	cp POKECENTER
	jr z, .gotPaletteList
	ld a, [wCurMap]
	cp INDIGO_PLATEAU_LOBBY
	jr z, .gotPaletteList
	; If not, load the normal Object Pals
	ld hl, SpritePalettes
.gotPaletteList
	pop bc
	ld a, b
	ldh [rWBK], a
	jr LoadSpritePaletteData

LoadAttackSpritePalettes:
	ld hl, AttackSpritePalettes

LoadSpritePaletteData:
	ldh a, [rWBK]
	ld b, a
	ld a, 2
	ldh [rWBK], a
	push bc

	ld de, W2_SprPaletteData
	ld b, $40
.sprCopyLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .sprCopyLoop
	ld a, 1
	ld [W2_ForceOBPUpdate], a

	pop af
	ldh [rWBK], a
	ret

; Set an overworld sprite's colors
; On entering, A contains the flags (without a color palette) and de is the destination.
; This is called in the middle of a loop in engine/overworld/oam.asm, once per sprite.
ColorOverworldSprite::
	push af
	push bc
	push de
	and $f8
	ld b, a

	ldh a, [hSpriteOffset2]
	ld e, a
	ld d, wSpriteStateData1 >> 8
	ld a, [de] ; Load A with picture ID
	dec a

	ld de, SpritePaletteAssignments
	add e
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
	ld a, [de] ; Get the picture ID's palette
	ld c, a

	; Female Mint player: deep blue OW palette (slot 5), not orange (Red).
	ldh a, [hSpriteOffset2]
	and a
	jr nz, .notMintPlayerOW
	ld a, [wPlayerGender]
	and a
	jr z, .notMintPlayerOW
	ld a, c
	cp SPR_PAL_ORANGE
	jr nz, .notMintPlayerOW
	ld c, SPR_PAL_OW_DEEP_BLUE
.notMintPlayerOW:
	ld a, c

	; If it's 8, that means no particular palette is assigned
	cp SPR_PAL_RANDOM
	jr nz, .norandomColor

	; Bill is always brown
	ld a, [wCurMap]
	cp BILLS_HOUSE
	ld a, SPR_PAL_BROWN
	jr z, .norandomColor

	; This is a (somewhat) random but consistent color
	ldh a, [hSpriteOffset2]
	swap a
	and 3

.norandomColor

	pop de
	or b
	ld [de], a
	inc hl
	inc e
	pop bc
	pop af
	ret

; This is called whenever [wUpdateSpritesEnabled] != 1 (overworld sprites not enabled?).
;
; This sometimes does occur on the overworld, such as when exclamation marks appear, and
; when trees are being cut or boulders are being moved. Though, when in the overworld,
; W2_SpritePaletteMap is all blanked out (set to 9) except for the exclamation mark tile,
; so this function usually won't do anything.
;
; This colorizes: attack sprites, party menu, exclamation mark, trades, perhaps more?
ColorNonOverworldSprites::
	ld a, 2
	ldh [rWBK], a

	ld hl, wShadowOAM
	ld b, 40

.spriteLoop
	inc hl
	inc hl
	ld a, [hli] ; tile
	ld e, a
	ld d, W2_SpritePaletteMap >> 8
	ld a, [de]
	cp 8 ; if 8, colorize based on attack type
	jr z, .getAttackType
	; Map 9: overworld = unchanged. In battle, trainer OAM often omits attr (garbage=pal 7=purple).
	cp 9
	jr nz, .notMap9
	xor a
	ldh [rWBK], a
	ld a, [wIsInBattle]
	and a
	jr z, .map9NotBattleOam
	ld a, 2
	ldh [rWBK], a
	; Do not use OAM X: player head columns start at e.g. $a0 (see LoadPlayerBackPic) and
	; party HUD is on the right; both would get "enemy" pal 1. Use tile id: HUD balls
	; $31-34, player back pic uses $00-$30 (move anims use $31+).
	dec hl
	dec hl
	; hl->X, e=tile id
	ld a, e
	cp $35
	jr nc, .map9OamCgbEnemy
	cp $31
	jr nc, .map9OamCgbHudBall
	jr .map9OamCgbPlayer
.map9OamCgbEnemy
	ld c, 1
	jr .map9OamCgbApply
.map9OamCgbHudBall
	ld c, 2
	jr .map9OamCgbApply
.map9OamCgbPlayer
	ld c, 0
.map9OamCgbApply
	inc hl
	inc hl
	ld a, [hl]
	and $F8
	or c
	ld [hl], a
	jr .nextSprite
.map9NotBattleOam
	ld a, 2
	ldh [rWBK], a
	jr .nextSprite
.notMap9
	cp 10 ; if 10 (used in game freak intro), color based on sprite number
	jr z, .gameFreakIntro
	jr .setPalette ; Otherwise, use the value as-is

.gameFreakIntro: ; The stars under the logo all get different colors
	ld a, b
	and 3
	add 4
	jr .setPalette

.getAttackType
	push hl

	; Load animation (move) being used
	xor a
	ldh [rWBK], a
	ld a, [wAnimationID]
	ld d, a
	ld a, 2
	ldh [rWBK], a

	; If the absorb animation is playing, it's always green. (Needed for leech seed)
	ld a, d
	cp ABSORB
	ld a, GRASS
	jr z, .gotType

	; Make stun spore and solarbeam yellow, despite being grass moves
	ld a, d
	cp STUN_SPORE
	ld a, ELECTRIC
	jr z, .gotType
	ld a, d
	cp SOLARBEAM
	ld a, ELECTRIC
	jr z, .gotType

	; Make tri-attack yellow, despite being a normal move
	ld a, d
	cp TRI_ATTACK
	ld a, ELECTRIC
	jr z, .gotType

	ldh a, [hWhoseTurn]
	and a
	jr z, .playersTurn
	ld a, [wEnemyMoveType] ; Enemy move type
	jr .gotType
.playersTurn
	ld a, [wPlayerMoveType] ; Move type
.gotType
	ld hl, TypeColorTable
	add l
	ld l, a
	jr nc, .noCarry
	inc h
.noCarry
	ld a, [hl]
	pop hl

.setPalette
	ld c, a
	ld a, $f8
	and [hl]
	or c
	ld [hl], a

.nextSprite
	inc hl
	dec b
	jp nz, .spriteLoop

.end
	xor a
	ldh [rWBK], a
	ret

; Called whenever an animation plays in-battle. There are two animation tilesets, each
; with its own palette.
LoadAnimationTilesetPalettes:
	push de
	ld a, [wWhichBattleAnimTileset] ; Animation tileset (0-2)
	ld c, a
	ld a, 2
	ldh [rWBK], a

	xor a
	ld [W2_UseOBP1], a

	call LoadAttackSpritePalettes

	; Indices 0 and 2 both refer to "AnimationTileset1", just different amounts of it.
	; 0 is in-battle, 2 is during a trade.
	; Index 1 refers to "AnimationTileset2".
	ld a, c
	cp 1
	ld hl, AnimationTileset2Palettes
	jr z, .gotPalette
	ld hl, AnimationTileset1Palettes
.gotPalette
	ld de, W2_SpritePaletteMap
	ld b, $80
.copyLoop
	ld a, [hli]
	ld [de], a
	inc e
	dec b
	jr nz, .copyLoop

	; Battle HUD pokeball tiles live at $31-$34 in vSprites. Animation palette setup
	; rewrites the whole sprite palette map, so restore their intended palette after the copy.
	ld a, ATK_PAL_RED
	ld hl, W2_SpritePaletteMap + $31
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a

	; If in a trade, some of the tiles near the end are different. Override some tiles
	; for the link cable, and replace the "purple" palette to match the exact color of
	; the link cable.
	ld a, c
	cp 2
	jr nz, .done

	; Replace ATK_PAL_PURPLE with PAL_MEWMON
	ld d, PAL_MEWMON
	ld e, ATK_PAL_PURPLE
	call LoadSGBPalette_Sprite

	; Set the link cable sprite tiles
	ld a, ATK_PAL_PURPLE
	ld hl, W2_SpritePaletteMap + $7e
	ld [hli], a
	ld [hli], a

.done
	ld a, 1
	ld [W2_ForceOBPUpdate], a

	xor a
	ldh [rWBK], a

	pop de
	ret


; Set all sprite palettes to not be colorized by "ColorNonOverworldSprites".
ClearSpritePaletteMap:
	ldh a, [rWBK]
	ld b, a
	ld a, 2
	ldh [rWBK], a
	push bc

	ld hl, W2_SpritePaletteMap
	ld b, $0 ; $100
	ld a, 9
.loop
	ld [hli], a
	dec b
	jr nz, .loop

	pop af
	ldh [rWBK], a
	ret


SpritePaletteAssignments: ; Characters on the overworld
	table_width 1, SpritePaletteAssignments
	; 0x01: SPRITE_RED
	db SPR_PAL_ORANGE

	; 0x02: SPRITE_BLUE
	db SPR_PAL_BLUE

	; 0x03: SPRITE_OAK
	db SPR_PAL_BROWN

	; 0x04: SPRITE_BUG_CATCHER
	db SPR_PAL_RANDOM

	; 0x05: SPRITE_SLOWBRO
	db SPR_PAL_ORANGE

	; 0x06: SPRITE_LASS
	db SPR_PAL_RANDOM

	; 0x07: SPRITE_BLACK_HAIR_BOY_1
	db SPR_PAL_RANDOM

	; 0x08: SPRITE_LITTLE_GIRL
	db SPR_PAL_RANDOM

	; 0x09: SPRITE_BIRD
	db SPR_PAL_ORANGE

	; 0x0a: SPRITE_FAT_BALD_GUY
	db SPR_PAL_RANDOM

	; 0x0b: SPRITE_GAMBLER
	db SPR_PAL_RANDOM

	; 0x0c: SPRITE_BLACK_HAIR_BOY_2
	db SPR_PAL_RANDOM

	; 0x0d: SPRITE_GIRL
	db SPR_PAL_RANDOM

	; 0x0e: SPRITE_HIKER
	db SPR_PAL_RANDOM

	; 0x0f: SPRITE_FOULARD_WOMAN
	db SPR_PAL_RANDOM

	; 0x10: SPRITE_GENTLEMAN
	db SPR_PAL_BLUE

	; 0x11: SPRITE_DAISY
	db SPR_PAL_BLUE

	; 0x12: SPRITE_BIKER
	db SPR_PAL_RANDOM

	; 0x13: SPRITE_SAILOR
	db SPR_PAL_RANDOM

	; 0x14: SPRITE_COOK
	db SPR_PAL_RANDOM

	; 0x15: SPRITE_BIKE_SHOP_GUY
	db SPR_PAL_RANDOM

	; 0x16: SPRITE_MR_FUJI
	db SPR_PAL_GREEN

	; 0x17: SPRITE_GIOVANNI
	db SPR_PAL_BLUE

	; 0x18: SPRITE_ROCKET
	db SPR_PAL_BROWN

	; 0x19: SPRITE_MEDIUM
	db SPR_PAL_RANDOM

	; 0x1a: SPRITE_WAITER
	db SPR_PAL_RANDOM

	; 0x1b: SPRITE_ERIKA
	db SPR_PAL_RANDOM

	; 0x1c: SPRITE_MOM_GEISHA
	db SPR_PAL_RANDOM

	; 0x1d: SPRITE_BRUNETTE_GIRL
	db SPR_PAL_RANDOM

	; 0x1e: SPRITE_LANCE
	db SPR_PAL_ORANGE

	; 0x1f: SPRITE_OAK_SCIENTIST_AIDE
	db SPR_PAL_GREEN

	; 0x20: SPRITE_OAK_AIDE
	db SPR_PAL_BROWN

	; 0x21: SPRITE_ROCKER ($20)
	db SPR_PAL_RANDOM

	; 0x22: SPRITE_SWIMMER
	db SPR_PAL_RANDOM

	; 0x23: SPRITE_WHITE_PLAYER
	db SPR_PAL_RANDOM

	; 0x24: SPRITE_GYM_HELPER
	db SPR_PAL_RANDOM

	; 0x25: SPRITE_OLD_PERSON
	db SPR_PAL_RANDOM

	; 0x26: SPRITE_MART_GUY
	db SPR_PAL_RANDOM

	; 0x27: SPRITE_FISHER
	db SPR_PAL_RANDOM

	; 0x28: SPRITE_OLD_MEDIUM_WOMAN
	db SPR_PAL_RANDOM

	; 0x29: SPRITE_NURSE
	db SPR_PAL_ORANGE

	; 0x2a: SPRITE_CABLE_CLUB_WOMAN
	db SPR_PAL_GREEN

	; 0x2b: SPRITE_MR_MASTERBALL
	db SPR_PAL_PURPLE

	; 0x2c: SPRITE_LAPRAS_GIVER
	db SPR_PAL_RANDOM

	; 0x2d: SPRITE_WARDEN
	db SPR_PAL_RANDOM

	; 0x2e: SPRITE_SS_CAPTAIN
	db SPR_PAL_RANDOM

	; 0x2f: SPRITE_FISHER2
	db SPR_PAL_RANDOM

	; 0x30: SPRITE_KOGA
	db SPR_PAL_PURPLE

	; 0x31: SPRITE_BROCK
	db SPR_PAL_BROWN

	; 0x32: SPRITE_MISTY
	db SPR_PAL_ORANGE

	; 0x33: SPRITE_LT_SURGE
	db SPR_PAL_ORANGE

	; 0x34: SPRITE_ERIKA
	db SPR_PAL_GREEN

	; 0x35: SPRITE_SABRINA
	db SPR_PAL_ORANGE

	; 0x36: SPRITE_BLAINE
	db SPR_PAL_ORANGE

	; 0x37: SPRITE_GAMEBOY_KID_COPY
	db SPR_PAL_RANDOM

	; 0x38: SPRITE_CLEFAIRY
	db SPR_PAL_ORANGE

	; 0x39: SPRITE_AGATHA
	db SPR_PAL_BLUE

	; 0x3a: SPRITE_BRUNO
	db SPR_PAL_BROWN

	; 0x3b: SPRITE_LORELEI
	db SPR_PAL_ORANGE

	; 0x3c: SPRITE_SEEL
	db SPR_PAL_BLUE

	; 0x3d: SPRITE_BALL
	db SPR_PAL_ORANGE

	; 0x3e: SPRITE_OMANYTE
	db SPR_PAL_ROCK

	; 0x3f: SPRITE_BOULDER
	db SPR_PAL_ROCK

	; 0x40: SPRITE_PAPER_SHEET
	db SPR_PAL_BROWN

	; 0x41: SPRITE_BOOK_MAP_DEX
	db SPR_PAL_ORANGE

	; 0x42: SPRITE_CLIPBOARD
	db SPR_PAL_BROWN

	; 0x43: SPRITE_SNORLAX
	db SPR_PAL_ORANGE

	; 0x44: SPRITE_OLD_AMBER_COPY
	db SPR_PAL_ROCK

	; 0x45: SPRITE_OLD_AMBER
	db SPR_PAL_ROCK

	; 0x46: SPRITE_LYING_OLD_MAN_UNUSED_1
	db SPR_PAL_BROWN

	; 0x47: SPRITE_LYING_OLD_MAN_UNUSED_2
	db SPR_PAL_BROWN

	; 0x48: SPRITE_LYING_OLD_MAN
	db SPR_PAL_BROWN

	; 0x49: SPRITE_SNORLAX
	db SPR_PAL_ORANGE

	; 0x4a: SPRITE_UNUSED_OLD_AMBER
	db SPR_PAL_ROCK

	; 0x4b: SPRITE_OLD_AMBER
	db SPR_PAL_ROCK

	; 0x4c: SPRITE_GREEN_ROCKET
	db SPR_PAL_GREEN

	; 0x4d: SPRITE_BLUE_CLOAK
	db SPR_PAL_BLUE

	; 0x4e: SPRITE_UNUSED_GAMBLER_ASLEEP_2
	db SPR_PAL_BROWN

	; 0x4f: SPRITE_GAMBLER_ASLEEP
	db SPR_PAL_BROWN

	; 0x50: SPRITE_NINJA
	db SPR_PAL_PURPLE

	; 0x51: SPRITE_JANINE
	db SPR_PAL_PURPLE

	; 0x52: SPRITE_MEW
	db SPR_PAL_PURPLE

	; 0x53: SPRITE_ARIANA
	db SPR_PAL_ORANGE

	; 0x54: SPRITE_ARCHER
	db SPR_PAL_BLUE

	; 0x55: SPRITE_PETREL
	db SPR_PAL_PURPLE

	; 0x56: SPRITE_PROTON
	db SPR_PAL_GREEN

	; 0x57: SPRITE_SOLDIER (same overworld green tint as GREEN / unused scientist)
	db SPR_PAL_GREEN

	; 0x58: SPRITE_BULBASAUR
	db SPR_PAL_GREEN

	; 0x59: SPRITE_CHARMANDER
	db SPR_PAL_ORANGE

	; 0x5a: SPRITE_SQUIRTLE
	db SPR_PAL_BLUE

	; 0x5b: SPRITE_CHIKORITA
	db SPR_PAL_GREEN

	; 0x5c: SPRITE_CYNDAQUIL
	db SPR_PAL_ORANGE

	; 0x5d: SPRITE_TOTODILE
	db SPR_PAL_BLUE

	; 0x5e: SPRITE_PIDGEY
	db SPR_PAL_BROWN

	; 0x5f: SPRITE_SPEAROW
	db SPR_PAL_BROWN

	; 0x60: SPRITE_FEAROW
	db SPR_PAL_BROWN

	; 0x61: SPRITE_DODUO
	db SPR_PAL_BROWN

	; 0x62: SPRITE_PIDGEOT
	db SPR_PAL_BROWN

	; 0x63: SPRITE_CHANSEY
	db SPR_PAL_ORANGE

	; 0x64: SPRITE_PIKACHU
	db SPR_PAL_ORANGE

	; 0x65: SPRITE_LAPRAS
	db SPR_PAL_BLUE

	; 0x66: SPRITE_MACHOP
	db SPR_PAL_BLUE

	; 0x67: SPRITE_MACHOKE
	db SPR_PAL_BLUE

	; 0x68: SPRITE_POLIWRATH
	db SPR_PAL_BLUE

	; 0x69: SPRITE_CUBONE
	db SPR_PAL_BROWN

	; 0x6a: SPRITE_MEWTWO
	db SPR_PAL_PURPLE

	; 0x6b: SPRITE_MEOWTH
	db SPR_PAL_BROWN

	; 0x6c: SPRITE_NIDORAN_F
	db SPR_PAL_PURPLE

	; 0x6d: SPRITE_NIDORAN_M
	db SPR_PAL_BLUE

	; 0x6e: SPRITE_NIDORINO
	db SPR_PAL_PURPLE

	; 0x6f: SPRITE_PSYDUCK
	db SPR_PAL_ORANGE

	; 0x70: SPRITE_CLEFAIRY
	db SPR_PAL_ORANGE

	; 0x71: SPRITE_JIGGLYPUFF
	db SPR_PAL_ORANGE

	; 0x72: SPRITE_WIGGLYTUFF
	db SPR_PAL_ORANGE

	; 0x73: SPRITE_KANGASKHAN
	db SPR_PAL_BROWN

	; 0x74: SPRITE_SLOWPOKE
	db SPR_PAL_PURPLE

	; 0x75: SPRITE_SLOWBRO
	db SPR_PAL_PURPLE

	; 0x76: SPRITE_VOLTORB
	db SPR_PAL_ORANGE

	; 0x77: SPRITE_ELECTRODE
	db SPR_PAL_ORANGE

	; 0x78: SPRITE_ARTICUNO
	db SPR_PAL_BLUE

	; 0x79: SPRITE_ZAPDOS
	db SPR_PAL_ORANGE

	; 0x7a: SPRITE_MOLTRES
	db SPR_PAL_ORANGE

	assert_table_length NUM_SPRITES


AnimationTileset1Palettes:
	INCBIN "color/data/animtileset1palettes.bin"

AnimationTileset2Palettes:
	INCBIN "color/data/animtileset2palettes.bin"

TypeColorTable: ; Used for a select few sprites to be colorized based on attack type
	table_width 1, TypeColorTable
	db 0 ; NORMAL EQU $00
	db 0 ; FIGHTING EQU $01
	db 0 ; FLYING EQU $02
	db 7 ; POISON EQU $03
	db 3 ; GROUND EQU $04
	db 3 ; ROCK EQU $05
	db 0
	db 5 ; BUG EQU $07
	db 7 ; GHOST EQU $08
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 0
	db 2 ; FIRE EQU $14
	db 1 ; WATER EQU $15
	db 5 ; GRASS EQU $16
	db 4 ; ELECTRIC EQU $17
	db 7 ; PSYCHIC EQU $18
	db 6 ; ICE EQU $19
	db 1 ; DRAGON EQU $1A
	assert_table_length NUM_TYPES

INCLUDE "color/data/spritepalettes.asm"
