	db DEX_PILOSWINE
	db 100, 100, 80, 50, 60
	;   hp  atk def spd spc
	db ICE, GROUND
	db 75
	db 158
	INCBIN "gfx/pokemon/front/piloswine.pic", 0, 1
	dw PiloswinePicFront, PiloswinePicBack
	db TACKLE, POWDER_SNOW, HORN_ATTACK, NO_MOVE
	db GROWTH_SLOW
	tmhm TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, HYPER_BEAM, ICE_BEAM, \
	     BLIZZARD, EARTHQUAKE, FISSURE, DIG, MIMIC, DOUBLE_TEAM, BIDE, \
	     REST, ROCK_SLIDE, SUBSTITUTE, STRENGTH
	db BANK(PiloswinePicFront)
	assert BANK(PiloswinePicFront) == BANK(PiloswinePicBack)
