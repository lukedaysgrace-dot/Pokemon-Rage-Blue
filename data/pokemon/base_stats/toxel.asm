	db DEX_TOXEL ; pokedex id

	db  40,  38,  35,  40,  54
	;   hp  atk  def  spd  spc

	db ELECTRIC, POISON ; type
	db 75 ; catch rate
	db 48 ; base exp

	INCBIN "gfx/pokemon/front/toxel.pic", 0, 1
	dw ToxelPicFront, ToxelPicBack

	db ACID, GROWL, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_SLOW

	tmhm TOXIC,        TAKE_DOWN,    DOUBLE_EDGE,  RAGE,          \
	     THUNDERBOLT,  THUNDER,      MIMIC,        DOUBLE_TEAM,   \
	     BIDE,         REST,         SUBSTITUTE,   FLASH
	db BANK(ToxelPicFront)
	assert BANK(ToxelPicFront) == BANK(ToxelPicBack)
