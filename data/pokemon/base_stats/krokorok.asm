	db DEX_KROKOROK ; pokedex id

	db  60,  82,  45,  74,  45
	;   hp  atk  def  spd  spc

	db GROUND, DARK ; type
	db 90 ; catch rate
	db 123 ; base exp

	INCBIN "gfx/pokemon/front/krokorok.pic", 0, 1
	dw KrokorokPicFront, KrokorokPicBack

	db RAGE, LEER, SAND_ATTACK, BITE
	db GROWTH_MEDIUM_SLOW

	tmhm CRUNCH,       TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  \
	     EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         SLUDGE_BOMB,  REST,         ROCK_SLIDE,   SUBSTITUTE,  \
	     CUT,          STRENGTH

	db BANK(KrokorokPicFront)
	assert BANK(KrokorokPicFront) == BANK(KrokorokPicBack)
