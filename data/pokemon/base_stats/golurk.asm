	db DEX_GOLURK ; pokedex id

	db  89, 124,  80,  55,  80
	;   hp  atk  def  spd  spc

	db GROUND, GHOST ; type
	db 90 ; catch rate
	db 169 ; base exp

	INCBIN "gfx/pokemon/front/golurk.pic", 0, 1
	dw GolurkPicFront, GolurkPicBack

	db TACKLE, DEFENSE_CURL, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_SLOW

	tmhm MEGA_PUNCH   , MEGA_KICK    , TOXIC        , SHADOW_BALL  , BODY_SLAM    , \
	     TAKE_DOWN    , DOUBLE_EDGE  , ICE_BEAM     , HYPER_BEAM   , SOLARBEAM    , \
	     THUNDERBOLT  , EARTHQUAKE   , DIG          , PSYCHIC_M    , DOUBLE_TEAM  , \
	     REFLECT      , SELFDESTRUCT , REST         , ROCK_SLIDE   , SUBSTITUTE   , \
	     FLY          , STRENGTH     , FLASH
	db BANK(GolurkPicFront)
	assert BANK(GolurkPicFront) == BANK(GolurkPicBack)
