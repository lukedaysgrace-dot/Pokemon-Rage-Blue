	db DEX_MAMOSWINE
	db 110, 130, 80, 80, 70
	;   hp  atk def spd spc
	db ICE, GROUND
	db 50
	db 239
	INCBIN "gfx/pokemon/front/mamoswine.pic", 0, 1
	dw MamoswinePicFront, MamoswinePicBack
	db TACKLE, POWDER_SNOW, HORN_ATTACK, NO_MOVE
	db GROWTH_SLOW
	tmhm TOXIC, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, HYPER_BEAM, ICE_BEAM, \
	     BLIZZARD, EARTHQUAKE, FISSURE, DIG, MIMIC, DOUBLE_TEAM, BIDE, \
	     REST, ROCK_SLIDE, SUBSTITUTE, STRENGTH
	db BANK(MamoswinePicFront)
	assert BANK(MamoswinePicFront) == BANK(MamoswinePicBack)
