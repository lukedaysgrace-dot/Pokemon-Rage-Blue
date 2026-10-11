	db DEX_WIGGLYTUFF ; pokedex id

	db 110,  83,  75,  45,  70
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 50 ; catch rate
	db 109 ; base exp

	INCBIN "gfx/pokemon/front/wigglytuff.pic", 0, 1 ; sprite dimensions
	dw WigglytuffPicFront, WigglytuffPicBack

	db SING, DISABLE, DEFENSE_CURL, DOUBLESLAP ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH   , MEGA_KICK    , TOXIC        , SHADOW_BALL  , BODY_SLAM    , \
	     TAKE_DOWN    , DOUBLE_EDGE  , BUBBLEBEAM   , WATER_GUN    , ICE_BEAM     , \
	     BLIZZARD     , HYPER_BEAM   , SUBMISSION   , COUNTER      , SEISMIC_TOSS , \
	     SOLARBEAM    , THUNDERBOLT  , THUNDER      , DIG          , \
	     PSYCHIC_M    , TELEPORT     , MIMIC        , DOUBLE_TEAM  , REFLECT      , \
	     BIDE         , METRONOME    , SELFDESTRUCT , FLAMETHROWER , FIRE_BLAST   , \
	     SWIFT        , SOFTBOILED   , DREAM_EATER  , REST         , THUNDER_WAVE , \
	     PSYWAVE      , TRI_ATTACK   , SUBSTITUTE   , STRENGTH     , FLASH
	; end

	db BANK(WigglytuffPicFront)
	assert BANK(WigglytuffPicFront) == BANK(WigglytuffPicBack)
