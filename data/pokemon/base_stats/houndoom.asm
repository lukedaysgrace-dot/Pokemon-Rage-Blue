	db DEX_HOUNDOOM ; pokedex id

	db  75,  90,  50,  95, 110
	;   hp  atk  def  spd  spc

	db DARK, FIRE ; type
	db 45 ; catch rate
	db 204 ; base exp

	INCBIN "gfx/pokemon/front/houndoom.pic", 0, 1
	dw HoundoomPicFront, HoundoomPicBack

	db LEER, EMBER, SMOG, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   HYPER_BEAM,   \
	     DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,          FLAMETHROWER, FIRE_BLAST,   \
	     SWIFT,        REST,         SUBSTITUTE
	db 0 ; padding
