	db DEX_LAIRON ; pokedex id

	db  60,  90, 140,  40,  50
	;   hp  atk  def  spd  spc

	db STEEL, ROCK ; type
	db 90 ; catch rate
	db 151 ; base exp

	INCBIN "gfx/pokemon/front/lairon.pic", 0, 1
	dw LaironPicFront, LaironPicBack

	db TACKLE, HARDEN, METAL_CLAW, ROCK_THROW
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  METAL_CLAW,   \
	     EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         REST,         ROCK_SLIDE,   SUBSTITUTE,   CUT,          \
	     STRENGTH

	db BANK(LaironPicFront)
	assert BANK(LaironPicFront) == BANK(LaironPicBack)
