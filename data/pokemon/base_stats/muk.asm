	db DEX_MUK ; pokedex id

	db 105, 105,  75,  50,  65
	;   hp  atk  def  spd  spc

	db POISON, POISON ; type
	db 75 ; catch rate
	db 157 ; base exp

	INCBIN "gfx/pokemon/front/muk.pic", 0, 1 ; sprite dimensions
	dw MukPicFront, MukPicBack

	db TACKLE, DISABLE, HARDEN, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC        , SHADOW_BALL  , BODY_SLAM    , TAKE_DOWN    , HYPER_BEAM   , \
	     MEGA_DRAIN   , THUNDERBOLT  , THUNDER      , DIG          , \
	     MIMIC        , DOUBLE_TEAM  , BIDE         , METRONOME    , SELFDESTRUCT , \
	     FLAMETHROWER , FIRE_BLAST   , SWIFT        , SLUDGE_BOMB  , REST         , \
	     EXPLOSION    , ROCK_SLIDE   , SUBSTITUTE   , STRENGTH
	; end

	db BANK(MukPicFront)
	assert BANK(MukPicFront) == BANK(MukPicBack)
