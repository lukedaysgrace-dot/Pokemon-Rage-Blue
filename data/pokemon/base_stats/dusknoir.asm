	db DEX_DUSKNOIR ; pokedex id

	db  95,  60, 115,  45,  90
	;   hp  atk  def  spd  spc

	db GHOST, GHOST ; type
	db 45 ; catch rate
	db 210 ; base exp

	INCBIN "gfx/pokemon/front/dusknoir.pic", 0, 1
	dw DusknoirPicFront, DusknoirPicBack

	db CONFUSE_RAY, NIGHT_SHADE, DISABLE, CONFUSION
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    HYPER_BEAM,   PSYCHIC_M,    MIMIC,        \
	     DOUBLE_TEAM,  REST,         SUBSTITUTE
	db 0 ; padding
