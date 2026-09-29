	db DEX_AGGRON ; pokedex id

	db  70, 110, 180,  50,  60
	;   hp  atk  def  spd  spc

	db STEEL, ROCK ; type
	db 45 ; catch rate
	db 239 ; base exp

	INCBIN "gfx/pokemon/front/aggron.pic", 0, 1
	dw AggronPicFront, AggronPicBack

	db TACKLE, HARDEN, METAL_CLAW, ROCK_THROW
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  ICE_BEAM,     \
	     BLIZZARD,     HYPER_BEAM,   METAL_CLAW,   THUNDERBOLT,  THUNDER,      \
	     EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         FLAMETHROWER, FIRE_BLAST,   REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   CUT,          SURF,         STRENGTH

	db BANK(AggronPicFront)
	assert BANK(AggronPicFront) == BANK(AggronPicBack)
