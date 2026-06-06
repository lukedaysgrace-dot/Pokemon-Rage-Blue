	db DEX_MEW ; pokedex id

	db 120, 120, 120, 120, 120
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 3 ; catch rate
	db 64 ; base exp

	INCBIN "gfx/pokemon/front/mew.pic", 0, 1 ; sprite dimensions
	dw MewPicFront, MewPicBack

	db TACKLE, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH   , RAZOR_WIND   , SWORDS_DANCE , CRUNCH       , MEGA_KICK    , \
	     TOXIC        , SHADOW_BALL  , BODY_SLAM    , TAKE_DOWN    , DOUBLE_EDGE  , \
	     BUBBLEBEAM   , WATER_GUN    , ICE_BEAM     , BLIZZARD     , HYPER_BEAM   , \
	     METAL_CLAW   , SUBMISSION   , COUNTER      , SEISMIC_TOSS , PAY_DAY      , \
	     MEGA_DRAIN   , SOLARBEAM    , DRAGON_RAGE  , THUNDERBOLT  , THUNDER      , \
	     EARTHQUAKE   , FISSURE      , DIG          , PSYCHIC_M    , TELEPORT     , \
	     MIMIC        , DOUBLE_TEAM  , REFLECT      , BIDE         , METRONOME    , \
	     SELFDESTRUCT , FLAMETHROWER , FIRE_BLAST   , SWIFT        , SLUDGE_BOMB  , \
	     SOFTBOILED   , DREAM_EATER  , SKY_ATTACK   , REST         , THUNDER_WAVE , \
	     PSYWAVE      , EXPLOSION    , ROCK_SLIDE   , TRI_ATTACK   , SUBSTITUTE   , \
	     CUT          , FLY          , SURF         , STRENGTH     , FLASH
	; end

	db BANK(MewPicFront)
	assert BANK(MewPicFront) == BANK(MewPicBack)
