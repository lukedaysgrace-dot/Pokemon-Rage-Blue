	db DEX_ARMALDO ; pokedex id

	db  75, 125, 100,  45,  75
	;   hp  atk  def  spd  spc

	db ROCK, BUG ; type
	db 45 ; catch rate
	db 199 ; base exp

	INCBIN "gfx/pokemon/front/armaldo.pic", 0, 1
	dw ArmaldoPicFront, ArmaldoPicBack

	db SCRATCH, HARDEN, WATER_GUN, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    TAKE_DOWN,     \
	     DOUBLE_EDGE,  HYPER_BEAM,   WATER_GUN,    ICE_BEAM,      \
	     BLIZZARD,     RAGE,         DIG,          MIMIC,         \
	     DOUBLE_TEAM,  BIDE,         REST,         ROCK_SLIDE,    \
	     SUBSTITUTE,   SURF
	db BANK(ArmaldoPicFront)
	assert BANK(ArmaldoPicFront) == BANK(ArmaldoPicBack)
