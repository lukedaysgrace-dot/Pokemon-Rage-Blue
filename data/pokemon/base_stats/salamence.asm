	db DEX_SALAMENCE ; pokedex id

	db  95, 135,  80, 100,  90
	;   hp  atk  def  spd  spc

	db DRAGON, FLYING ; type
	db 45 ; catch rate
	db 218 ; base exp

	INCBIN "gfx/pokemon/front/salamence.pic", 0, 1
	dw SalamencePicFront, SalamencePicBack

	db BITE, LEER, HEADBUTT, EMBER
	db GROWTH_SLOW

	tmhm MEGA_KICK,    TOXIC,        BODY_SLAM,    FLAMETHROWER, FIRE_BLAST,   \
	     HYPER_BEAM,   DOUBLE_TEAM,  SWIFT,        REST,         SUBSTITUTE,   \
	     FLY,          STRENGTH
	db 0 ; padding
