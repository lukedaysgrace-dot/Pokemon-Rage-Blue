	db DEX_CROAGUNK
	db 48, 61, 40, 50, 61
	;  hp atk def spd spc
	db POISON, FIGHTING
	db 140
	db 60
	INCBIN "gfx/pokemon/front/croagunk.pic", 0, 1
	dw CroagunkPicFront, CroagunkPicBack
	db POISON_STING, SAND_ATTACK, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_FAST
	tmhm MEGA_PUNCH, TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, SUBMISSION, \
	     COUNTER, SEISMIC_TOSS, EARTHQUAKE, DIG, MIMIC, DOUBLE_TEAM, BIDE, \
	     SLUDGE_BOMB, REST, ROCK_SLIDE, SUBSTITUTE, STRENGTH
	db BANK(CroagunkPicFront)
	assert BANK(CroagunkPicFront) == BANK(CroagunkPicBack)
