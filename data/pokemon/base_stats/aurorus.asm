	db DEX_AURORUS ; pokedex id

	db 123,  88,  72,  58,  99
	;   hp  atk  def  spd  spc

	db ROCK, ICE ; type
	db 45 ; catch rate
	db 104 ; base exp

	INCBIN "gfx/pokemon/front/aurorus.pic", 0, 1
	dw AurorusPicFront, AurorusPicBack

	db TACKLE, GROWL, AURORA_BEAM, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   RAGE,          \
	     THUNDERBOLT,  THUNDER,      MIMIC,        DOUBLE_TEAM,   \
	     REFLECT,      BIDE,         REST,         ROCK_SLIDE,    \
	     SUBSTITUTE
	db BANK(AurorusPicFront)
	assert BANK(AurorusPicFront) == BANK(AurorusPicBack)
