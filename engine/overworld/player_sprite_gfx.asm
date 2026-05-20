; ROM bank 3 — kept out of Home (ROM0) to avoid overflowing the fixed bank.
_LoadWalkingPlayerSpriteGraphics::
	ld hl, vNPCSprites
	ld de, RedSprite
	ld a, [wPlayerGender]
	and a
	jr nz, .walkingGirl
	ld b, BANK(RedSprite)
	jr _LoadPlayerSpriteGraphicsCommonBC
.walkingGirl
	ld de, MintSprite
	ld b, BANK(MintSprite)
	jr _LoadPlayerSpriteGraphicsCommonBC

_LoadSurfingPlayerSpriteGraphics::
	ld de, SeelSprite
	ld hl, vNPCSprites
	ld b, BANK(SeelSprite)
	jr _LoadPlayerSpriteGraphicsCommonBC

_LoadBikePlayerSpriteGraphics::
	ld hl, vNPCSprites
	ld a, [wCurrentRideItem]
	cp SKATEBOARD
	jr z, .skateboard
	ld de, RedBikeSprite
	ld a, [wPlayerGender]
	and a
	jr nz, .bikeGirl
	ld b, BANK(RedBikeSprite)
	jr _LoadPlayerSpriteGraphicsCommonBC
.bikeGirl
	ld de, MintBikeSprite
	ld b, BANK(MintBikeSprite)
	jr _LoadPlayerSpriteGraphicsCommonBC
.skateboard
	ld a, [wPlayerGender]
	and a
	jr nz, .skateGirl
	ld de, RedSkateboardSprite
	ld b, BANK(RedSkateboardSprite)
	jr _LoadPlayerSpriteGraphicsCommonBC
.skateGirl
	ld de, MintSkateboardSprite
	ld b, BANK(MintSkateboardSprite)

_LoadPlayerSpriteGraphicsCommonBC::
	push de
	push hl
	ld c, $0c
	call CopyVideoData
	pop hl
	pop de
	ld a, $c0
	add e
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
	set 3, h
	ld c, $0c
	jp CopyVideoData
