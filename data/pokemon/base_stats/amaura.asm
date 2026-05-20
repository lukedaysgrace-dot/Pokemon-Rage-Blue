	db DEX_AMAURA ; pokedex id

	db  77,  59,  50,  46,  67
	;   hp  atk  def  spd  spc

	db ROCK, ICE ; type
	db 45 ; catch rate
	db 72 ; base exp

	INCBIN "gfx/pokemon/front/amaura.pic", 0, 1
	dw AmauraPicFront, AmauraPicBack

	db TACKLE, GROWL, NO_MOVE, NO_MOVE
	db GROWTH_MEDIUM_FAST

	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,   \
	     ICE_BEAM,     BLIZZARD,     RAGE,         THUNDERBOLT,   \
	     THUNDER,      MIMIC,        DOUBLE_TEAM,  REFLECT,       \
	     BIDE,         REST,         ROCK_SLIDE,   SUBSTITUTE
	db BANK(AmauraPicFront)
	assert BANK(AmauraPicFront) == BANK(AmauraPicBack)
