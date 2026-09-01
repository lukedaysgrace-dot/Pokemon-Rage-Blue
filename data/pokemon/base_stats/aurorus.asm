	db DEX_AURORUS
	db 123, 77, 72, 58, 92
	;   hp atk def spd spc
	db ROCK, ICE
	db 45
	db 104
	INCBIN "gfx/pokemon/front/aurorus.pic", 0, 1
	dw AurorusPicFront, AurorusPicBack
	db GROWL, POWDER_SNOW, ROCK_THROW, AURORA_BEAM
	db GROWTH_MEDIUM_FAST
	tmhm TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, HYPER_BEAM, ICE_BEAM, \
	     BLIZZARD, THUNDERBOLT, THUNDER, EARTHQUAKE, MIMIC, DOUBLE_TEAM, \
	     BIDE, REST, THUNDER_WAVE, ROCK_SLIDE, SUBSTITUTE
	db BANK(AurorusPicFront)
	assert BANK(AurorusPicFront) == BANK(AurorusPicBack)
