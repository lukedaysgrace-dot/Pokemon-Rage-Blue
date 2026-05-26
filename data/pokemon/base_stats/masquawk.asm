	db DEX_MASQUAWK ; pokedex id

	db  70, 110,  75, 105,  65
	;   hp  atk  def  spd  spc

	db FIGHTING, FLYING ; type
	db 45 ; catch rate
	db 175 ; base exp

	INCBIN "gfx/pokemon/front/masquawk.pic", 0, 1
	dw MasquawkPicFront, MasquawkPicBack

	db PECK, FOCUS_ENERGY, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm SWORDS_DANCE, MEGA_PUNCH,   MEGA_KICK,    TOXIC,        BODY_SLAM,    \
	     TAKE_DOWN,    DOUBLE_EDGE,  HYPER_BEAM,   SUBMISSION,   MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         SWIFT,        SKY_ATTACK,   REST,         \
	     SUBSTITUTE,   CUT,          FLY
	db BANK(MasquawkPicFront)
	assert BANK(MasquawkPicFront) == BANK(MasquawkPicBack)
