	db DEX_GOLISOPOD ; pokedex id

	db  75, 125, 140,  40,  72
	;   hp  atk  def  spd  spc

	db BUG, WATER ; type
	db 45 ; catch rate
	db 225 ; base exp

	INCBIN "gfx/pokemon/front/golisopod.pic", 0, 1
	dw GolisopodPicFront, GolisopodPicBack

	db SAND_ATTACK, BUG_BITE, GROWL, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    TAKE_DOWN,     \
	     DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,      \
	     BLIZZARD,     HYPER_BEAM,   SUBMISSION,   SEISMIC_TOSS,  \
	     RAGE,         MEGA_DRAIN,   DIG,          MIMIC,         \
	     DOUBLE_TEAM,  BIDE,         SWIFT,        SKULL_BASH,    \
	     REST,         SUBSTITUTE,   CUT,          SURF,          \
	     STRENGTH
	db BANK(GolisopodPicFront)
	assert BANK(GolisopodPicFront) == BANK(GolisopodPicBack)
