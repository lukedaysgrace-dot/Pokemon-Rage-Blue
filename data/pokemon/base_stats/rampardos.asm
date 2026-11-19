	db DEX_RAMPARDOS ; pokedex id

	db  97, 145,  70,  58,  70
	;   hp  atk  def  spd  spc

	db ROCK, ROCK ; type
	db 45 ; catch rate
	db 173 ; base exp

	INCBIN "gfx/pokemon/front/rampardos.pic", 0, 1
	dw RampardosPicFront, RampardosPicBack

	db TACKLE, LEER, HEADBUTT, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm SWORDS_DANCE , CRUNCH       , TOXIC        , BODY_SLAM    , TAKE_DOWN    , \
	     DOUBLE_EDGE  , ICE_BEAM     , BLIZZARD     , HYPER_BEAM   , \
	     THUNDERBOLT  , THUNDER      , EARTHQUAKE   , FISSURE      , DIG          , \
	     DOUBLE_TEAM  , FLAMETHROWER , FIRE_BLAST   , REST         , ROCK_SLIDE   , \
	     SUBSTITUTE   , CUT          , SURF         , STRENGTH
	db BANK(RampardosPicFront)
	assert BANK(RampardosPicFront) == BANK(RampardosPicBack)
