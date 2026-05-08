	db DEX_BAGON ; pokedex id

	db  45,  75,  60,  50,  40
	;   hp  atk  def  spd  spc

	db DRAGON, DRAGON ; type
	db 45 ; catch rate
	db 89 ; base exp

	INCBIN "gfx/pokemon/front/bagon.pic", 0, 1
	dw BagonPicFront, BagonPicBack

	db BITE, LEER, NO_MOVE, NO_MOVE
	db GROWTH_SLOW

	tmhm BODY_SLAM,    FLAMETHROWER, FIRE_BLAST,   DOUBLE_TEAM,  REST,         \
	     ROCK_SLIDE,   SUBSTITUTE
	db 0 ; padding
