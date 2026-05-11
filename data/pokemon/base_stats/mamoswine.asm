	db DEX_MAMOSWINE ; pokedex id

	db 110, 110,  80,  80,  80
	;   hp  atk  def  spd  spc

	db ICE, GROUND ; type
	db 50 ; catch rate
	db 207 ; base exp

	INCBIN "gfx/pokemon/front/mamoswine.pic", 0, 1
	dw MamoswinePicFront, MamoswinePicBack

	db TACKLE, FURY_ATTACK, BITE, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   EARTHQUAKE,   DIG,          DOUBLE_TEAM,  REST,         \
	     ROCK_SLIDE,   SUBSTITUTE,   STRENGTH
	db 0 ; padding
