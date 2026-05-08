	db DEX_LUCARIO ; pokedex id

	db  70, 110,  70,  90, 93
	;   hp  atk  def  spd  spc

	db FIGHTING, STEEL ; type
	db 45 ; catch rate
	db 204 ; base exp

	INCBIN "gfx/pokemon/front/lucario.pic", 0, 1
	dw LucarioPicFront, LucarioPicBack

	db QUICK_ATTACK, COUNTER, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_SLOW

	tmhm MEGA_PUNCH,   MEGA_KICK,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  HYPER_BEAM,   SUBMISSION,   DIG,          MIMIC,        \
	     DOUBLE_TEAM,  REST,         SUBSTITUTE,   CUT,          STRENGTH
	db 0 ; padding
