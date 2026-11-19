	db DEX_LANTURN ; pokedex id

	db 125,  58,  58,  67,  76
	;   hp  atk  def  spd  spc

	db WATER, ELECTRIC ; type
	db 75 ; catch rate
	db 161 ; base exp

	INCBIN "gfx/pokemon/front/lanturn.pic", 0, 1
	dw LanturnPicFront, LanturnPicBack

	db BUBBLEBEAM, THUNDER_WAVE, NO_MOVE, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC        , BODY_SLAM    , TAKE_DOWN    , DOUBLE_EDGE  , BUBBLEBEAM   , \
	     WATER_GUN    , ICE_BEAM     , BLIZZARD     , HYPER_BEAM   , THUNDERBOLT  , \
	     THUNDER      , MIMIC        , DOUBLE_TEAM  , REST         , THUNDER_WAVE , \
	     SUBSTITUTE   , SURF         , FLASH
	db BANK(LanturnPicFront)
	assert BANK(LanturnPicFront) == BANK(LanturnPicBack)
