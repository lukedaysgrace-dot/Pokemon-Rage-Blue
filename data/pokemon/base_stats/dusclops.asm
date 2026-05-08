	db DEX_DUSCLOPS ; pokedex id

	db  80,  60, 110,  25,  85
	;   hp  atk  def  spd  spc

	db GHOST, GHOST ; type
	db 90 ; catch rate
	db 147 ; base exp

	INCBIN "gfx/pokemon/front/dusclops.pic", 0, 1
	dw DusclopsPicFront, DusclopsPicBack

	db CONFUSE_RAY, NIGHT_SHADE, DISABLE, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    HYPER_BEAM,   PSYCHIC_M,    MIMIC,        \
	     DOUBLE_TEAM,  REST,         SUBSTITUTE
	db 0 ; padding
