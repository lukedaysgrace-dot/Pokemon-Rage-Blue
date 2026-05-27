	db DEX_CUFANT ; pokedex id

	db  72,  80,  49,  40,  40
	;   hp  atk  def  spd  spc

	db STEEL, STEEL ; type
	db 190 ; catch rate
	db 66 ; base exp

	INCBIN "gfx/pokemon/front/cufant.pic", 0, 1
	dw CufantPicFront, CufantPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     RAGE,         EARTHQUAKE,   DIG,          MIMIC,         \
	     DOUBLE_TEAM,  BIDE,         REST,         ROCK_SLIDE,    \
	     SUBSTITUTE,   STRENGTH
	db BANK(CufantPicFront)
	assert BANK(CufantPicFront) == BANK(CufantPicBack)
