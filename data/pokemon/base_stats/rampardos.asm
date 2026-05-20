	db DEX_RAMPARDOS ; pokedex id

	db  97, 145,  70,  58,  75
	;   hp  atk  def  spd  spc

	db ROCK, ROCK ; type
	db 45 ; catch rate
	db 173 ; base exp

	INCBIN "gfx/pokemon/front/rampardos.pic", 0, 1
	dw RampardosPicFront, RampardosPicBack

	db TACKLE, LEER, ROCK_THROW, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     RAGE,         HYPER_BEAM,   THUNDERBOLT,  THUNDER,       \
	     EARTHQUAKE,   FISSURE,      DIG,          MIMIC,         \
	     DOUBLE_TEAM,  BIDE,         FLAMETHROWER, FIRE_BLAST,   SKULL_BASH,    \
	     REST,         ROCK_SLIDE,   SUBSTITUTE,   STRENGTH
	db BANK(RampardosPicFront)
	assert BANK(RampardosPicFront) == BANK(RampardosPicBack)
