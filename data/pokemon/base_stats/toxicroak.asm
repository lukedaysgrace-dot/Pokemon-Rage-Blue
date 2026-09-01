	db DEX_TOXICROAK
	db 83, 106, 65, 85, 86
	;  hp  atk def spd spc
	db POISON, FIGHTING
	db 75
	db 172
	INCBIN "gfx/pokemon/front/toxicroak.pic", 0, 1
	dw ToxicroakPicFront, ToxicroakPicBack
	db POISON_STING, SAND_ATTACK, LOW_KICK, NO_MOVE
	db GROWTH_MEDIUM_FAST
	tmhm MEGA_PUNCH, MEGA_KICK, TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, \
	     HYPER_BEAM, SUBMISSION, COUNTER, SEISMIC_TOSS, EARTHQUAKE, DIG, \
	     MIMIC, DOUBLE_TEAM, BIDE, SLUDGE_BOMB, REST, ROCK_SLIDE, \
	     SUBSTITUTE, STRENGTH
	db BANK(ToxicroakPicFront)
	assert BANK(ToxicroakPicFront) == BANK(ToxicroakPicBack)
