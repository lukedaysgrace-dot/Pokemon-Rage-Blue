	db DEX_TYRANTRUM
	db 82, 121, 119, 71, 69
	;  hp  atk  def spd spc
	db ROCK, DRAGON
	db 45
	db 182
	INCBIN "gfx/pokemon/front/tyrantrum.pic", 0, 1
	dw TyrantrumPicFront, TyrantrumPicBack
	db TACKLE, TAIL_WHIP, BITE, ROCK_THROW
	db GROWTH_MEDIUM_FAST
	tmhm TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, HYPER_BEAM, \
	     EARTHQUAKE, FISSURE, DIG, MIMIC, DOUBLE_TEAM, BIDE, FIRE_BLAST, \
	     REST, ROCK_SLIDE, SUBSTITUTE, STRENGTH
	db BANK(TyrantrumPicFront)
	assert BANK(TyrantrumPicFront) == BANK(TyrantrumPicBack)
