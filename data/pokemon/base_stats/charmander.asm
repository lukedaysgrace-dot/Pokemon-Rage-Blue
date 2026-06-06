	db DEX_CHARMANDER ; pokedex id

	db  39,  52,  43,  65,  50
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 255 ; catch rate
	db 65 ; base exp

	INCBIN "gfx/pokemon/front/charmander.pic", 0, 1 ; sprite dimensions
	dw CharmanderPicFront, CharmanderPicBack

	db SCRATCH, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH   , SWORDS_DANCE , CRUNCH       , MEGA_KICK    , TOXIC        , \
	     BODY_SLAM    , TAKE_DOWN    , DOUBLE_EDGE  , METAL_CLAW   , SUBMISSION   , \
	     COUNTER      , SEISMIC_TOSS , DRAGON_RAGE  , DIG          , \
	     MIMIC        , DOUBLE_TEAM  , REFLECT      , BIDE         , FLAMETHROWER , \
	     FIRE_BLAST   , SWIFT        , REST         , ROCK_SLIDE   , SUBSTITUTE   , \
	     CUT          , STRENGTH
	; end

	db BANK(CharmanderPicFront)
	assert BANK(CharmanderPicFront) == BANK(CharmanderPicBack)
