	db DEX_PUPITAR ; pokedex id

	db  70,  84,  70,  51,  70
	;   hp  atk  def  spd  spc

	db ROCK, GROUND ; type
	db 45 ; catch rate
	db 144 ; base exp

	INCBIN "gfx/pokemon/front/pupitar.pic", 0, 1
	dw PupitarPicFront, PupitarPicBack

	db BITE, LEER, NO_MOVE, NO_MOVE
	db GROWTH_SLOW

	tmhm CRUNCH       , TOXIC        , BODY_SLAM    , TAKE_DOWN    , DOUBLE_EDGE  , \
	     HYPER_BEAM   , EARTHQUAKE   , DIG          , MIMIC        , DOUBLE_TEAM  , \
	     REST         , ROCK_SLIDE   , SUBSTITUTE
	db BANK(PupitarPicFront)
	assert BANK(PupitarPicFront) == BANK(PupitarPicBack)
