	db DEX_CRADILY ; pokedex id

	db  86,  81,  97,  43,  93
	;   hp  atk  def  spd  spc

	db ROCK, GRASS ; type
	db 45 ; catch rate
	db 201 ; base exp

	INCBIN "gfx/pokemon/front/cradily.pic", 0, 1
	dw CradilyPicFront, CradilyPicBack

	db CONSTRICT, ACID, MEGA_DRAIN, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     HYPER_BEAM,   BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,      \
	     BLIZZARD,     RAGE,         MEGA_DRAIN,   SOLARBEAM,     \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         REST,          \
	     ROCK_SLIDE,   SUBSTITUTE
	db BANK(CradilyPicFront)
	assert BANK(CradilyPicFront) == BANK(CradilyPicBack)
