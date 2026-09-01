	db DEX_TYRUNT
	db 58, 89, 77, 48, 45
	;  hp atk def spd spc
	db ROCK, DRAGON
	db 45
	db 72
	INCBIN "gfx/pokemon/front/tyrunt.pic", 0, 1
	dw TyruntPicFront, TyruntPicBack
	db TACKLE, TAIL_WHIP, BITE, NO_MOVE
	db GROWTH_MEDIUM_FAST
	tmhm TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, EARTHQUAKE, FISSURE, \
	     DIG, MIMIC, DOUBLE_TEAM, BIDE, REST, ROCK_SLIDE, SUBSTITUTE, STRENGTH
	db BANK(TyruntPicFront)
	assert BANK(TyruntPicFront) == BANK(TyruntPicBack)
