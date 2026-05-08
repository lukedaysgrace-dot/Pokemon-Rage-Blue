	db DEX_TYRANITAR ; pokedex id

	db 100, 134, 110,  61, 95
	;   hp  atk  def  spd  spc

	db ROCK, DARK ; type
	db 45 ; catch rate
	db 218 ; base exp

	INCBIN "gfx/pokemon/front/tyranitar.pic", 0, 1
	dw TyranitarPicFront, TyranitarPicBack

	db BITE, SAND_ATTACK, ROCK_THROW, NO_MOVE
	db GROWTH_SLOW

	tmhm MEGA_PUNCH,   MEGA_KICK,    TOXIC,        BODY_SLAM,    HYPER_BEAM,   \
	     SUBMISSION,   ROCK_SLIDE,   EARTHQUAKE,   DIG,          DOUBLE_TEAM,  \
	     REST,         SUBSTITUTE,   CUT,          STRENGTH
	db 0 ; padding
