	db DEX_FERALIGATR ; pokedex id

	db  85,  95, 93,  78,  84
	;   hp  atk  def  spd  spc

	db WATER, DARK ; type
	db 45 ; catch rate
	db 210 ; base exp

	INCBIN "gfx/pokemon/front/feraligatr.pic", 0, 1
	dw FeraligatrPicFront, FeraligatrPicBack

	db SCRATCH, LEER, WATER_GUN, BITE
	db GROWTH_MEDIUM_SLOW

	tmhm MEGA_PUNCH,   MEGA_KICK,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   SUBMISSION,   COUNTER,      RAGE,         DIG,          \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         SKULL_BASH,   REST,         \
	     SUBSTITUTE,   CUT,          SURF,         STRENGTH,     FLASH
	db 0 ; padding
