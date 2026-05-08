	db DEX_CYNDAQUIL ; pokedex id

	db  39,  52,  43,  65,  50
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 65 ; base exp

	INCBIN "gfx/pokemon/front/cyndaquil.pic", 0, 1
	dw CyndaquilPicFront, CyndaquilPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_SLOW

	tmhm MEGA_PUNCH,   DIG,          TOXIC,        BODY_SLAM,    FLAMETHROWER, FIRE_BLAST,   \
	     DOUBLE_TEAM,  SWIFT,        REST,         \
	     SUBSTITUTE,     CUT
	db 0 ; padding
