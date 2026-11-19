	db DEX_DUSKNOIR ; pokedex id

	db  95,  80, 115,  45,  90
	;   hp  atk  def  spd  spc

	db GHOST, GHOST ; type
	db 45 ; catch rate
	db 210 ; base exp

	INCBIN "gfx/pokemon/front/dusknoir.pic", 0, 1
	dw DusknoirPicFront, DusknoirPicBack

	db CONFUSE_RAY, NIGHT_SHADE, DISABLE, LEER
	db GROWTH_SLOW

	tmhm MEGA_PUNCH   , MEGA_KICK    , TOXIC        , SHADOW_BALL  , BODY_SLAM    , \
	     ICE_BEAM     , BLIZZARD     , HYPER_BEAM   , EARTHQUAKE   , PSYCHIC_M    , \
	     DOUBLE_TEAM  , METRONOME    , SWIFT        , DREAM_EATER  , REST         , \
	     ROCK_SLIDE   , SUBSTITUTE   , STRENGTH     , FLASH
	db BANK(DusknoirPicFront)
	assert BANK(DusknoirPicFront) == BANK(DusknoirPicBack)
