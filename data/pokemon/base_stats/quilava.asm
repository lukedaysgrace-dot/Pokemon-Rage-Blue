	db DEX_QUILAVA ; pokedex id

	db  58,  64,  58,  80,  65
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 142 ; base exp

	INCBIN "gfx/pokemon/front/quilava.pic", 0, 1
	dw QuilavaPicFront, QuilavaPicBack

	db TACKLE, LEER, EMBER, NO_MOVE
	db GROWTH_MEDIUM_SLOW

	tmhm MEGA_PUNCH,   DIG,          TOXIC,        BODY_SLAM,    FLAMETHROWER, FIRE_BLAST,   \
	     DOUBLE_TEAM,  SWIFT,        REST,         \
	     SUBSTITUTE,     CUT
	db 0 ; padding
