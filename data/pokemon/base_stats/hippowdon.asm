	db DEX_HIPPOWDON ; pokedex id

	db 108, 112, 118,  47,  72
	;   hp  atk  def  spd  spc

	db GROUND, GROUND ; type
	db 60 ; catch rate
	db 198 ; base exp

	INCBIN "gfx/pokemon/front/hippowdon.pic", 0, 1
	dw HippowdonPicFront, HippowdonPicBack

	db TACKLE, SAND_ATTACK, BITE, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     HYPER_BEAM,   RAGE,         EARTHQUAKE,   FISSURE,       \
	     DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,          \
	     FLAMETHROWER, FIRE_BLAST,   REST,         ROCK_SLIDE,   SUBSTITUTE,    \
	     STRENGTH
	db 0 ; padding
