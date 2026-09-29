	db DEX_SANDILE ; pokedex id

	db  50,  72,  35,  65,  35
	;   hp  atk  def  spd  spc

	db GROUND, DARK ; type
	db 180 ; catch rate
	db 58 ; base exp

	INCBIN "gfx/pokemon/front/sandile.pic", 0, 1
	dw SandilePicFront, SandilePicBack

	db RAGE, LEER, SAND_ATTACK, NO_MOVE
	db GROWTH_MEDIUM_SLOW

	tmhm CRUNCH,       TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  \
	     EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         SLUDGE_BOMB,  REST,         ROCK_SLIDE,   SUBSTITUTE,  \
	     CUT

	db BANK(SandilePicFront)
	assert BANK(SandilePicFront) == BANK(SandilePicBack)
