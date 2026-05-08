	db DEX_BASTIODON ; pokedex id

	db 100,  72, 148,  30,  87
	;   hp  atk  def  spd  spc

	db ROCK, STEEL ; type
	db 45 ; catch rate
	db 173 ; base exp

	INCBIN "gfx/pokemon/front/bastiodon.pic", 0, 1
	dw BastiodonPicFront, BastiodonPicBack

	db TACKLE, DEFENSE_CURL, ROCK_THROW, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     BLIZZARD,     HYPER_BEAM,   RAGE,         THUNDERBOLT,   \
	     THUNDER,      EARTHQUAKE,   DIG,          MIMIC,         \
	     DOUBLE_TEAM,  BIDE,         FLAMETHROWER, FIRE_BLAST,   REST,          \
	     ROCK_SLIDE,   SUBSTITUTE,   STRENGTH
	db 0 ; padding
