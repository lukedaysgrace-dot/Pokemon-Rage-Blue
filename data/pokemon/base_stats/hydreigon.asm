	db DEX_HYDREIGON ; pokedex id

	db  92, 115,  90,  98, 105
	;   hp  atk  def  spd  spc

	db DARK, DRAGON ; type
	db 45 ; catch rate
	db 243 ; base exp

	INCBIN "gfx/pokemon/front/hydreigon.pic", 0, 1
	dw HydreigonPicFront, HydreigonPicBack

	db BITE, DRAGON_RAGE, HEADBUTT, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  CRUNCH,       \
	     HYPER_BEAM,   RAGE,         DRAGON_RAGE,  THUNDERBOLT,  THUNDER,      \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         FLAMETHROWER, FIRE_BLAST,   \
	     SWIFT,        REST,         ROCK_SLIDE,   TRI_ATTACK,   SUBSTITUTE,   \
	     FLY,          SURF,         STRENGTH
	db BANK(HydreigonPicFront)
	assert BANK(HydreigonPicFront) == BANK(HydreigonPicBack)