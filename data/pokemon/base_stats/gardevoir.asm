	db DEX_GARDEVOIR ; pokedex id

	db  70,  50,  80,  80, 125
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 208 ; base exp

	INCBIN "gfx/pokemon/front/gardevoir.pic", 0, 1
	dw GardevoirPicFront, GardevoirPicBack

	db CONFUSION, DOUBLE_TEAM, TELEPORT, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    HYPER_BEAM,   PSYCHIC_M,    DOUBLE_TEAM,  \
	     REFLECT,      REST,         SUBSTITUTE
	db 0 ; padding
