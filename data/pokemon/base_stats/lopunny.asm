	db DEX_LOPUNNY
	db 65, 76, 84, 105, 96
	;  hp atk def spd spc
	db NORMAL, NORMAL
	db 60
	db 168
	INCBIN "gfx/pokemon/front/lopunny.pic", 0, 1
	dw LopunnyPicFront, LopunnyPicBack
	db TACKLE, DEFENSE_CURL, QUICK_ATTACK, NO_MOVE
	db GROWTH_MEDIUM_FAST
	tmhm MEGA_PUNCH, MEGA_KICK, TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, \
	     HYPER_BEAM, ICE_BEAM, BLIZZARD, MIMIC, DOUBLE_TEAM, BIDE, REST, \
	     THUNDER_WAVE, SUBSTITUTE, STRENGTH
	db BANK(LopunnyPicFront)
	assert BANK(LopunnyPicFront) == BANK(LopunnyPicBack)
