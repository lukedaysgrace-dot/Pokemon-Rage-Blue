	db DEX_TYRANITAR ; pokedex id

	db 100, 134, 110,  61, 95
	;   hp  atk  def  spd  spc

	db ROCK, DARK ; type
	db 45 ; catch rate
	db 218 ; base exp

	INCBIN "gfx/pokemon/front/tyranitar.pic", 0, 1
	dw TyranitarPicFront, TyranitarPicBack

	db BITE, LEER, ROCK_THROW, NO_MOVE
	db GROWTH_SLOW

	tmhm MEGA_PUNCH   , CRUNCH       , MEGA_KICK    , TOXIC        , BODY_SLAM    , \
	     TAKE_DOWN    , DOUBLE_EDGE  , ICE_BEAM     , BLIZZARD     , HYPER_BEAM   , \
	     COUNTER      , SEISMIC_TOSS , THUNDERBOLT  , THUNDER      , EARTHQUAKE   , \
	     DIG          , MIMIC        , DOUBLE_TEAM  , FLAMETHROWER , FIRE_BLAST   , \
	     REST         , THUNDER_WAVE , ROCK_SLIDE   , SUBSTITUTE   , CUT          , \
	     SURF         , STRENGTH
	db BANK(TyranitarPicFront)
	assert BANK(TyranitarPicFront) == BANK(TyranitarPicBack)
