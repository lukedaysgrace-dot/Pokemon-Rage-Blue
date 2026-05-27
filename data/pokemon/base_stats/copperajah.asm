	db DEX_COPPERAJAH ; pokedex id

	db 122, 130,  69,  30,  80
	;   hp  atk  def  spd  spc

	db STEEL, STEEL ; type
	db 90 ; catch rate
	db 175 ; base exp

	INCBIN "gfx/pokemon/front/copperajah.pic", 0, 1
	dw CopperajahPicFront, CopperajahPicBack

	db TACKLE, GROWL, STOMP, ROCK_SLIDE
	db GROWTH_MEDIUM_FAST

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     HYPER_BEAM,   RAGE,         EARTHQUAKE,   DIG,           \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         REST,          \
	     ROCK_SLIDE,   SUBSTITUTE,   STRENGTH
	db BANK(CopperajahPicFront)
	assert BANK(CopperajahPicFront) == BANK(CopperajahPicBack)
