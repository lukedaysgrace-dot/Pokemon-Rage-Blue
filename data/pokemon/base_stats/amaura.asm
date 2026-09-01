	db DEX_AMAURA
	db 77, 59, 50, 46, 63
	;  hp atk def spd spc
	db ROCK, ICE
	db 45
	db 72
	INCBIN "gfx/pokemon/front/amaura.pic", 0, 1
	dw AmauraPicFront, AmauraPicBack
	db GROWL, POWDER_SNOW, ROCK_THROW, NO_MOVE
	db GROWTH_MEDIUM_FAST
	tmhm TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ICE_BEAM, BLIZZARD, \
	     THUNDERBOLT, THUNDER, MIMIC, DOUBLE_TEAM, BIDE, REST, \
	     THUNDER_WAVE, ROCK_SLIDE, SUBSTITUTE
	db BANK(AmauraPicFront)
	assert BANK(AmauraPicFront) == BANK(AmauraPicBack)
