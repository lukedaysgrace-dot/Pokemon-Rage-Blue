	db DEX_MEGANIUM ; pokedex id

	db  80,  82, 100,  80, 93
	;   hp  atk  def  spd  spc

	db GRASS, GRASS ; type
	db 45 ; catch rate
	db 208 ; base exp

	INCBIN "gfx/pokemon/front/meganium.pic", 0, 1
	dw MeganiumPicFront, MeganiumPicBack

	db TACKLE, GROWL, RAZOR_LEAF, REFLECT
	db GROWTH_MEDIUM_SLOW

	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  \
	     MEGA_DRAIN,   SOLARBEAM,    HYPER_BEAM,   DIG,          MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         REST,         \
	     SUBSTITUTE,   CUT
	db 0 ; padding
