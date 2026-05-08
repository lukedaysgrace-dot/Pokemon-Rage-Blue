	db DEX_TYPHLOSION ; pokedex id

	db  78,  84,  78, 100,  95
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 209 ; base exp

	INCBIN "gfx/pokemon/front/typhlosion.pic", 0, 1
	dw TyphlosionPicFront, TyphlosionPicBack

	db TACKLE, LEER, EMBER, QUICK_ATTACK
	db GROWTH_MEDIUM_SLOW

	tmhm MEGA_PUNCH,   DIG,          TOXIC,        BODY_SLAM,    FLAMETHROWER, FIRE_BLAST,   \
	     HYPER_BEAM,   DOUBLE_TEAM,  SWIFT,        \
	     REST,         SUBSTITUTE,   CUT,          STRENGTH
	db 0 ; padding
