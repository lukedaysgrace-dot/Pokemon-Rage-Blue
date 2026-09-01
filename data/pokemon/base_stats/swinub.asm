	db DEX_SWINUB
	db 50, 50, 40, 50, 30
	;  hp atk def spd spc
	db ICE, GROUND
	db 225
	db 50
	INCBIN "gfx/pokemon/front/swinub.pic", 0, 1
	dw SwinubPicFront, SwinubPicBack
	db TACKLE, POWDER_SNOW, NO_MOVE, NO_MOVE
	db GROWTH_SLOW
	tmhm TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ICE_BEAM, BLIZZARD, \
	     EARTHQUAKE, FISSURE, DIG, MIMIC, DOUBLE_TEAM, BIDE, REST, \
	     ROCK_SLIDE, SUBSTITUTE, STRENGTH
	db BANK(SwinubPicFront)
	assert BANK(SwinubPicFront) == BANK(SwinubPicBack)
