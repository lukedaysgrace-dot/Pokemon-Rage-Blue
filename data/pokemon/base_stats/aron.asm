	db DEX_ARON ; pokedex id

	db  50,  70, 100,  30,  40
	;   hp  atk  def  spd  spc

	db STEEL, ROCK ; type
	db 180 ; catch rate
	db 66 ; base exp

	INCBIN "gfx/pokemon/front/aron.pic", 0, 1
	dw AronPicFront, AronPicBack

	db TACKLE, HARDEN, METAL_CLAW, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  METAL_CLAW,   \
	     EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         REST,         ROCK_SLIDE,   SUBSTITUTE,   CUT,          \
	     STRENGTH

	db BANK(AronPicFront)
	assert BANK(AronPicFront) == BANK(AronPicBack)
