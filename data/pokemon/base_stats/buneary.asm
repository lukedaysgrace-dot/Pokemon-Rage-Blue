	db DEX_BUNEARY
	db 55, 66, 44, 85, 56
	;  hp atk def spd spc
	db NORMAL, NORMAL
	db 190
	db 70
	INCBIN "gfx/pokemon/front/buneary.pic", 0, 1
	dw BunearyPicFront, BunearyPicBack
	db TACKLE, DEFENSE_CURL, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_FAST
	tmhm MEGA_PUNCH, MEGA_KICK, TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, \
	     ICE_BEAM, BLIZZARD, MIMIC, DOUBLE_TEAM, BIDE, REST, \
	     THUNDER_WAVE, SUBSTITUTE, STRENGTH
	db BANK(BunearyPicFront)
	assert BANK(BunearyPicFront) == BANK(BunearyPicBack)
