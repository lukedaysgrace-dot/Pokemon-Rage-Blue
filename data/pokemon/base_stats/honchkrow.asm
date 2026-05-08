	db DEX_HONCHKROW ; pokedex id

	db 100, 125,  52,  71,  89
	;   hp  atk  def  spd  spc

	db DARK, FLYING ; type
	db 30 ; catch rate
	db 177 ; base exp

	INCBIN "gfx/pokemon/front/honchkrow.pic", 0, 1
	dw HonchkrowPicFront, HonchkrowPicBack

	db PECK, QUICK_ATTACK, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_SLOW

	tmhm TOXIC,        MEGA_KICK,    HYPER_BEAM,   RAZOR_WIND,   MIMIC,        \
	     DOUBLE_TEAM,  SWIFT,        SKY_ATTACK,   REST,         SUBSTITUTE,   \
	     FLY
	db 0 ; padding
