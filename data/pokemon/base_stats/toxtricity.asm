	db DEX_TOXTRICITY ; pokedex id

	db  75,  98,  70,  75, 114
	;   hp  atk  def  spd  spc

	db ELECTRIC, POISON ; type
	db 45 ; catch rate
	db 176 ; base exp

	INCBIN "gfx/pokemon/front/toxtricity.pic", 0, 1
	dw ToxtricityPicFront, ToxtricityPicBack

	db ACID, GROWL, LEER, THUNDERSHOCK
	db GROWTH_MEDIUM_SLOW

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     HYPER_BEAM,   RAGE,         THUNDERBOLT,  THUNDER,       \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         REST,          \
	     SUBSTITUTE,   FLASH
	db BANK(ToxtricityPicFront)
	assert BANK(ToxtricityPicFront) == BANK(ToxtricityPicBack)
