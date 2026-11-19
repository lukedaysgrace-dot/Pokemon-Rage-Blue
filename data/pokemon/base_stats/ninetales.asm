	db DEX_NINETALES ; pokedex id

	db  83,  76,  75, 100, 100
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 75 ; catch rate
	db 178 ; base exp

	INCBIN "gfx/pokemon/front/ninetales.pic", 0, 1 ; sprite dimensions
	dw NinetalesPicFront, NinetalesPicBack

	db EMBER, TAIL_WHIP, QUICK_ATTACK, CONFUSE_RAY ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC        , SHADOW_BALL  , BODY_SLAM    , TAKE_DOWN    , DOUBLE_EDGE  , \
	     HYPER_BEAM   , SOLARBEAM    , DIG          , MIMIC        , \
	     DOUBLE_TEAM  , REFLECT      , BIDE         , FLAMETHROWER , FIRE_BLAST   , \
	     SWIFT        , DREAM_EATER  , REST         , SUBSTITUTE
	; end

	db BANK(NinetalesPicFront)
	assert BANK(NinetalesPicFront) == BANK(NinetalesPicBack)
