	db DEX_GUARDIA ; pokedex id

	db  80, 110,  95,  70,  65
	;   hp  atk  def  spd  spc

	db GROUND, FIGHTING ; type
	db 45 ; catch rate
	db 165 ; base exp

	INCBIN "gfx/pokemon/front/guardia.pic", 0, 1
	dw GuardiaPicFront, GuardiaPicBack

	db BONE_CLUB, FOCUS_ENERGY, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_SLOW

	tmhm MEGA_PUNCH,   MEGA_KICK,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  HYPER_BEAM,   SUBMISSION,   EARTHQUAKE,   DIG,          \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   STRENGTH
	db BANK(GuardiaPicFront)
	assert BANK(GuardiaPicFront) == BANK(GuardiaPicBack)
