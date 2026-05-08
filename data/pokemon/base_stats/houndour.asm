	db DEX_HOUNDOUR ; pokedex id

	db  45,  60,  30,  65,  80
	;   hp  atk  def  spd  spc

	db DARK, FIRE ; type
	db 120 ; catch rate
	db 114 ; base exp

	INCBIN "gfx/pokemon/front/houndour.pic", 0, 1
	dw HoundourPicFront, HoundourPicBack

	db LEER, EMBER, NO_MOVE, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   DIG,          \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         FLAMETHROWER, FIRE_BLAST,    SWIFT,        \
	     REST,         SUBSTITUTE
	db 0 ; padding
