	db DEX_KROOKODILE ; pokedex id

	db  95, 117,  80,  92,  68
	;   hp  atk  def  spd  spc

	db GROUND, DARK ; type
	db 45 ; catch rate
	db 234 ; base exp

	INCBIN "gfx/pokemon/front/krookodile.pic", 0, 1
	dw KrookodilePicFront, KrookodilePicBack

	db RAGE, LEER, SAND_ATTACK, BITE
	db GROWTH_MEDIUM_SLOW

	tmhm CRUNCH,       TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  \
	     HYPER_BEAM,   EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         SLUDGE_BOMB,  REST,         ROCK_SLIDE,  \
	     SUBSTITUTE,   CUT,          STRENGTH

	db BANK(KrookodilePicFront)
	assert BANK(KrookodilePicFront) == BANK(KrookodilePicBack)
