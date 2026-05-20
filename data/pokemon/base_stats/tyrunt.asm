	db DEX_TYRUNT ; pokedex id

	db  58,  89,  77,  48,  45
	;   hp  atk  def  spd  spc

	db ROCK, DRAGON ; type
	db 45 ; catch rate
	db 72 ; base exp

	INCBIN "gfx/pokemon/front/tyrunt.pic", 0, 1
	dw TyruntPicFront, TyruntPicBack

	db TACKLE, TAIL_WHIP, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     RAGE,         EARTHQUAKE,   DIG,          MIMIC,         \
	     DOUBLE_TEAM,  BIDE,         FIRE_BLAST,   REST,          \
	     ROCK_SLIDE,   SUBSTITUTE,   STRENGTH
	db BANK(TyruntPicFront)
	assert BANK(TyruntPicFront) == BANK(TyruntPicBack)
