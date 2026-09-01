	db DEX_LICKILICKY
	db 110, 85, 95, 50, 95
	;   hp atk def spd spc
	db NORMAL, NORMAL
	db 30
	db 180
	INCBIN "gfx/pokemon/front/lickilicky.pic", 0, 1
	dw LickilickyPicFront, LickilickyPicBack
	db LICK, SUPERSONIC, DEFENSE_CURL, NO_MOVE
	db GROWTH_MEDIUM_FAST
	tmhm MEGA_PUNCH, MEGA_KICK, TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, \
	     HYPER_BEAM, ICE_BEAM, BLIZZARD, EARTHQUAKE, FISSURE, \
	     MIMIC, DOUBLE_TEAM, BIDE, FIRE_BLAST, REST, THUNDER_WAVE, \
	     ROCK_SLIDE, SUBSTITUTE, CUT, SURF, STRENGTH
	db BANK(LickilickyPicFront)
	assert BANK(LickilickyPicFront) == BANK(LickilickyPicBack)
