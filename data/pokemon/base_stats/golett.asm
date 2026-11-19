	db DEX_GOLETT ; pokedex id

	db  44,  70,  50,  35,  55
	;   hp  atk  def  spd  spc

	db GROUND, GHOST ; type
	db 190 ; catch rate
	db 89 ; base exp

	INCBIN "gfx/pokemon/front/golett.pic", 0, 1
	dw GolettPicFront, GolettPicBack

	db TACKLE, DEFENSE_CURL, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_SLOW

	tmhm MEGA_PUNCH   , MEGA_KICK    , TOXIC        , SHADOW_BALL  , BODY_SLAM    , \
	     TAKE_DOWN    , DOUBLE_EDGE  , ICE_BEAM     , EARTHQUAKE   , DIG          , \
	     PSYCHIC_M    , DOUBLE_TEAM  , REFLECT      , SELFDESTRUCT , REST         , \
	     ROCK_SLIDE   , SUBSTITUTE   , STRENGTH     , FLASH
	db BANK(GolettPicFront)
	assert BANK(GolettPicFront) == BANK(GolettPicBack)
