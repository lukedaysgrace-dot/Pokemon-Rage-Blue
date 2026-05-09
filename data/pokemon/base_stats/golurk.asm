	db DEX_GOLURK ; pokedex id

	db  89, 124,  80,  55,  80
	;   hp  atk  def  spd  spc

	db GROUND, GHOST ; type
	db 90 ; catch rate
	db 169 ; base exp

	INCBIN "gfx/pokemon/front/golurk.pic", 0, 1
	dw GolurkPicFront, GolurkPicBack

	db TACKLE, ROCK_THROW, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_SLOW

	tmhm MEGA_PUNCH,   TOXIC,        BODY_SLAM,    HYPER_BEAM,   EARTHQUAKE,   \
	     DIG,          DOUBLE_TEAM,  REST,         ROCK_SLIDE,   SUBSTITUTE,   \
	     STRENGTH
	db 0 ; padding
