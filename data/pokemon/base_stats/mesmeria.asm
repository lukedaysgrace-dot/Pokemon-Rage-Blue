	db DEX_MESMERIA ; pokedex id

	db  65,  70,  65, 115, 120
	;   hp  atk  def  spd  spc

	db ICE, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 137 ; base exp

	INCBIN "gfx/pokemon/front/mesmeria.pic", 0, 1 ; sprite dimensions
	dw MesmeriaPicFront, MesmeriaPicBack

	db TACKLE, LOVELY_KISS, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH   , MEGA_KICK    , TOXIC        , BODY_SLAM    , TAKE_DOWN    , \
	     DOUBLE_EDGE  , BUBBLEBEAM   , WATER_GUN    , ICE_BEAM     , BLIZZARD     , \
	     HYPER_BEAM   , SUBMISSION   , COUNTER      , SEISMIC_TOSS , \
	     PSYCHIC_M    , TELEPORT     , MIMIC        , DOUBLE_TEAM  , REFLECT      , \
	     BIDE         , METRONOME    , REST         , PSYWAVE      , SUBSTITUTE
	; end

	db BANK(MesmeriaPicFront)
	assert BANK(MesmeriaPicFront) == BANK(MesmeriaPicBack)
