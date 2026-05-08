	db DEX_LOPUNNY ; pokedex id

	db  65,  76,  84,  96,  54
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 60 ; catch rate
	db 178 ; base exp

	INCBIN "gfx/pokemon/front/lopunny.pic", 0, 1
	dw LopunnyPicFront, LopunnyPicBack

	db TACKLE, LEER, QUICK_ATTACK, NO_MOVE
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
