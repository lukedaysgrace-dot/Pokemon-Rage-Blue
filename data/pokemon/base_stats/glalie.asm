	db DEX_GLALIE ; pokedex id

	db  80,  80,  80,  80,  80
	;   hp  atk  def  spd  spc

	db ICE, ICE ; type
	db 75 ; catch rate
	db 168 ; base exp

	INCBIN "gfx/pokemon/front/glalie.pic", 0, 1
	dw GlaliePicFront, GlaliePicBack

	db POWDER_SNOW, LEER, BITE, ICE_SHARD
	db GROWTH_MEDIUM_FAST

	tmhm CRUNCH,       TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   EARTHQUAKE,   MIMIC,         \
	     DOUBLE_TEAM,  SELFDESTRUCT, BIDE,         REST,         EXPLOSION,     \
	     SUBSTITUTE

	db BANK(GlaliePicFront)
	assert BANK(GlaliePicFront) == BANK(GlaliePicBack)
