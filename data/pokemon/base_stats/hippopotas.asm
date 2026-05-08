	db DEX_HIPPOPOTAS ; pokedex id

	db  68,  72,  78,  32,  38
	;   hp  atk  def  spd  spc

	db GROUND, GROUND ; type
	db 140 ; catch rate
	db 95 ; base exp

	INCBIN "gfx/pokemon/front/hippopotas.pic", 0, 1
	dw HippopotasPicFront, HippopotasPicBack

	db TACKLE, SAND_ATTACK, NO_MOVE, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     HYPER_BEAM,   RAGE,         EARTHQUAKE,   FISSURE,       \
	     DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,          \
	     FIRE_BLAST,   REST,         ROCK_SLIDE,   SUBSTITUTE,    \
	     STRENGTH
	db 0 ; padding
