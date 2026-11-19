	db DEX_MIMIKYU ; pokedex id

	db  66,  90,  80,  96,  78
	;   hp  atk  def  spd  spc

	db GHOST, DARK ; type
	db 45 ; catch rate
	db 167 ; base exp

	INCBIN "gfx/pokemon/front/mimikyu.pic", 0, 1
	dw MimikyuPicFront, MimikyuPicBack

	db SCRATCH, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE , TOXIC        , SHADOW_BALL  , BODY_SLAM    , TAKE_DOWN    , \
	     HYPER_BEAM   , THUNDERBOLT  , THUNDER      , PSYCHIC_M    , MIMIC        , \
	     DOUBLE_TEAM  , DREAM_EATER  , REST         , THUNDER_WAVE , SUBSTITUTE
	; end

	db BANK(MimikyuPicFront)
	assert BANK(MimikyuPicFront) == BANK(MimikyuPicBack)
