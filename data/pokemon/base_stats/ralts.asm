	db DEX_RALTS ; pokedex id

	db  48,  25,  45,  60,  75
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 235 ; catch rate
	db 70 ; base exp

	INCBIN "gfx/pokemon/front/ralts.pic", 0, 1
	dw RaltsPicFront, RaltsPicBack

	db CONFUSION, NO_MOVE, NO_MOVE, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    PSYCHIC_M,    DOUBLE_TEAM,  \
	     REFLECT,      REST,         SUBSTITUTE
	db 0 ; padding
