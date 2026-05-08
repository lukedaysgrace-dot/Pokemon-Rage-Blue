	db DEX_DUSKULL ; pokedex id

	db  50,  40,  60,  25,  60
	;   hp  atk  def  spd  spc

	db GHOST, GHOST ; type
	db 190 ; catch rate
	db 97 ; base exp

	INCBIN "gfx/pokemon/front/duskull.pic", 0, 1
	dw DuskullPicFront, DuskullPicBack

	db CONFUSE_RAY, NIGHT_SHADE, NO_MOVE, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  REST,         \
	     SUBSTITUTE
	db 0 ; padding
