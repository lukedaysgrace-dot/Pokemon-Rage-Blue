	db DEX_BISHARP ; pokedex id

	db  65, 125, 100,  70,  60
	;   hp  atk  def  spd  spc

	db DARK, STEEL ; type
	db 45 ; catch rate
	db 172 ; base exp

	INCBIN "gfx/pokemon/front/bisharp.pic", 0, 1
	dw BisharpPicFront, BisharpPicBack

	db SCRATCH, LEER, METAL_CLAW, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm SWORDS_DANCE , CRUNCH       , TOXIC        , TAKE_DOWN    , DOUBLE_EDGE  , \
	     HYPER_BEAM   , METAL_CLAW   , DIG          , MIMIC        , \
	     DOUBLE_TEAM  , BIDE         , SWIFT        , REST         , THUNDER_WAVE , \
	     ROCK_SLIDE   , SUBSTITUTE   , CUT
	db BANK(BisharpPicFront)
	assert BANK(BisharpPicFront) == BANK(BisharpPicBack)