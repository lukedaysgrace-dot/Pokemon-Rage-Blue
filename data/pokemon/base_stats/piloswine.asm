	db DEX_PILOSWINE ; pokedex id

	db 100, 90,  80,  50,  70
	;   hp  atk  def  spd  spc

	db ICE, GROUND ; type
	db 75 ; catch rate
	db 160 ; base exp

	INCBIN "gfx/pokemon/front/piloswine.pic", 0, 1
	dw PiloswinePicFront, PiloswinePicBack

	db TACKLE, FURY_ATTACK, NO_MOVE, NO_MOVE
	db GROWTH_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   EARTHQUAKE,   DIG,          DOUBLE_TEAM,  REST,         \
	     ROCK_SLIDE,   SUBSTITUTE
	db 0 ; padding
