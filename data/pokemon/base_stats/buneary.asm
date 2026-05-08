	db DEX_BUNEARY ; pokedex id

	db  55,  66,  44,  85,  44
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 190 ; catch rate
	db 84 ; base exp

	INCBIN "gfx/pokemon/front/buneary.pic", 0, 1
	dw BunearyPicFront, BunearyPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm MEGA_PUNCH,   MEGA_KICK,    TOXIC,        BODY_SLAM,    \
	     TAKE_DOWN,    DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    \
	     ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   SUBMISSION,   \
	     COUNTER,      SEISMIC_TOSS, RAGE,         SOLARBEAM,    \
	     THUNDERBOLT,  THUNDER,      DIG,          PSYCHIC_M,    \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         FIRE_BLAST,   \
	     SKULL_BASH,   REST,         THUNDER_WAVE, SUBSTITUTE,   \
	     STRENGTH,     FLASH
	db 0 ; padding
