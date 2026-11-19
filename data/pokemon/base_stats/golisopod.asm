	db DEX_GOLISOPOD ; pokedex id

	db  85, 125, 130,  50,  85
	;   hp  atk  def  spd  spc

	db BUG, WATER ; type
	db 45 ; catch rate
	db 225 ; base exp

	INCBIN "gfx/pokemon/front/golisopod.pic", 0, 1
	dw GolisopodPicFront, GolisopodPicBack

	db SAND_ATTACK, BUG_BITE, HARDEN, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm SWORDS_DANCE , TOXIC        , BODY_SLAM    , TAKE_DOWN    , DOUBLE_EDGE  , \
	     BUBBLEBEAM   , WATER_GUN    , ICE_BEAM     , BLIZZARD     , HYPER_BEAM   , \
	     SUBMISSION   , SEISMIC_TOSS , MEGA_DRAIN   , DIG          , \
	     MIMIC        , DOUBLE_TEAM  , BIDE         , SWIFT        , SLUDGE_BOMB  , \
	     REST         , ROCK_SLIDE   , SUBSTITUTE   , CUT          , SURF         , \
	     STRENGTH
	db BANK(GolisopodPicFront)
	assert BANK(GolisopodPicFront) == BANK(GolisopodPicBack)
