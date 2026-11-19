	db DEX_SHIELDON ; pokedex id

	db  60,  42, 88,  30,  42
	;   hp  atk  def  spd  spc

	db ROCK, STEEL ; type
	db 45 ; catch rate
	db 99 ; base exp

	INCBIN "gfx/pokemon/front/shieldon.pic", 0, 1
	dw ShieldonPicFront, ShieldonPicBack

	db TACKLE, NO_MOVE, NO_MOVE, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC        , BODY_SLAM    , TAKE_DOWN    , DOUBLE_EDGE  , ICE_BEAM     , \
	     BLIZZARD     , COUNTER      , THUNDERBOLT  , THUNDER      , EARTHQUAKE   , \
	     FISSURE      , DIG          , DOUBLE_TEAM  , FLAMETHROWER , FIRE_BLAST   , \
	     REST         , ROCK_SLIDE   , SUBSTITUTE   , STRENGTH
	db BANK(ShieldonPicFront)
	assert BANK(ShieldonPicFront) == BANK(ShieldonPicBack)
