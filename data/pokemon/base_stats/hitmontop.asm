	db DEX_HITMONTOP
	db 50, 95, 95, 70, 110
	;  hp atk def spd spc
	db FIGHTING, FIGHTING
	db 45
	db 159
	INCBIN "gfx/pokemon/front/hitmontop.pic", 0, 1
	dw HitmontopPicFront, HitmontopPicBack
	db TACKLE, ROLLING_KICK, FOCUS_ENERGY, NO_MOVE
	db GROWTH_MEDIUM_FAST
	tmhm MEGA_PUNCH, MEGA_KICK, TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, \
	     SUBMISSION, COUNTER, SEISMIC_TOSS, MIMIC, DOUBLE_TEAM, BIDE, \
	     REST, ROCK_SLIDE, SUBSTITUTE, STRENGTH
	db BANK(HitmontopPicFront)
	assert BANK(HitmontopPicFront) == BANK(HitmontopPicBack)
