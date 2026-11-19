	db DEX_HONCHKROW ; pokedex id

	db 100, 125,  60,  71,  89
	;   hp  atk  def  spd  spc

	db DARK, FLYING ; type
	db 30 ; catch rate
	db 177 ; base exp

	INCBIN "gfx/pokemon/front/honchkrow.pic", 0, 1
	dw HonchkrowPicFront, HonchkrowPicBack

	db PECK, WING_ATTACK, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_SLOW

	tmhm RAZOR_WIND   , TOXIC        , SHADOW_BALL  , TAKE_DOWN    , DOUBLE_EDGE  , \
	     HYPER_BEAM   , PSYCHIC_M    , DOUBLE_TEAM  , SWIFT        , DREAM_EATER  , \
	     SKY_ATTACK   , REST         , THUNDER_WAVE , SUBSTITUTE   , FLY
	db BANK(HonchkrowPicFront)
	assert BANK(HonchkrowPicFront) == BANK(HonchkrowPicBack)
