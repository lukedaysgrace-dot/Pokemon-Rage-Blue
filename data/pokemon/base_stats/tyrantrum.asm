	db DEX_TYRANTRUM ; pokedex id

	db  82, 121, 107,  71,  59
	;   hp  atk  def  spd  spc

	db ROCK, DRAGON ; type
	db 45 ; catch rate
	db 182 ; base exp

	INCBIN "gfx/pokemon/front/tyrantrum.pic", 0, 1
	dw TyrantrumPicFront, TyrantrumPicBack

	db TACKLE, TAIL_WHIP, BITE, ROCK_SLIDE
	db GROWTH_MEDIUM_FAST

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     HYPER_BEAM,   RAGE,         EARTHQUAKE,   DIG,           \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         FIRE_BLAST,    \
	     REST,         ROCK_SLIDE,   SUBSTITUTE,   CUT,           \
	     STRENGTH
	db BANK(TyrantrumPicFront)
	assert BANK(TyrantrumPicFront) == BANK(TyrantrumPicBack)
