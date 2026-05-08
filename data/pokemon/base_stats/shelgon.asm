	db DEX_SHELGON ; pokedex id

	db  65,  95, 100,  50,  50
	;   hp  atk  def  spd  spc

	db DRAGON, DRAGON ; type
	db 45 ; catch rate
	db 147 ; base exp

	INCBIN "gfx/pokemon/front/shelgon.pic", 0, 1
	dw ShelgonPicFront, ShelgonPicBack

	db BITE, LEER, HEADBUTT, NO_MOVE
	db GROWTH_SLOW

	tmhm BODY_SLAM,    FLAMETHROWER, FIRE_BLAST,   HYPER_BEAM,   DOUBLE_TEAM,  \
	     REST,         ROCK_SLIDE,   SUBSTITUTE
	db 0 ; padding
