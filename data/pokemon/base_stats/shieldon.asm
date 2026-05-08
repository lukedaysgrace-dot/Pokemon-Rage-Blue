	db DEX_SHIELDON ; pokedex id

	db  60,  42, 88,  30,  42
	;   hp  atk  def  spd  spc

	db ROCK, STEEL ; type
	db 45 ; catch rate
	db 99 ; base exp

	INCBIN "gfx/pokemon/front/shieldon.pic", 0, 1
	dw ShieldonPicFront, ShieldonPicBack

	db TACKLE, DEFENSE_CURL, NO_MOVE, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     BLIZZARD,     HYPER_BEAM,   RAGE,         THUNDERBOLT,   \
	     THUNDER,      EARTHQUAKE,   DIG,          MIMIC,         \
	     DOUBLE_TEAM,  BIDE,         FIRE_BLAST,   REST,          \
	     ROCK_SLIDE,   SUBSTITUTE,   STRENGTH
	db 0 ; padding
