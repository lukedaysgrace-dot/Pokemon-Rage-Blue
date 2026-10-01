	db DEX_GOROCHU ; pokedex id

	db  70,  90,  65, 115, 100
	;   hp  atk  def  spd  spc

	db ELECTRIC, DARK ; type
	db 45 ; catch rate
	db 190 ; base exp

	INCBIN "gfx/pokemon/front/gorochu.pic", 0, 1
	dw GorochuPicFront, GorochuPicBack

	db THUNDERSHOCK, TAIL_WHIP, QUICK_ATTACK, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm MEGA_PUNCH   , MEGA_KICK    , TOXIC        , BODY_SLAM    , TAKE_DOWN    , \
	     DOUBLE_EDGE  , HYPER_BEAM   , SEISMIC_TOSS , THUNDERBOLT  , THUNDER      , \
	     MIMIC        , DOUBLE_TEAM  , REFLECT      , SWIFT        , REST         , \
	     THUNDER_WAVE , SUBSTITUTE   , FLY          , SURF         , FLASH
	db BANK(GorochuPicFront)
	assert BANK(GorochuPicFront) == BANK(GorochuPicBack)
