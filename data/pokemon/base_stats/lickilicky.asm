	db DEX_LICKILICKY ; pokedex id

	db  110,  85,  95,  50,  88
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 30 ; catch rate
	db 180 ; base exp

; First byte: .pic from pkmncompress(gfx/pokemon/front/lickilicky.png). INCBIN must stay .pic, not .png.
	INCBIN "gfx/pokemon/front/lickilicky.pic", 0, 1
	dw LickilickyPicFront, LickilickyPicBack

	db LICK, SUPERSONIC, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   SWORDS_DANCE, TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   SUBMISSION,   COUNTER,      SEISMIC_TOSS, RAGE,         \
	     THUNDERBOLT,  THUNDER,      EARTHQUAKE,   FISSURE,      DIG,          \
	     PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  BIDE,         FLAMETHROWER, FIRE_BLAST,   \
	     SKULL_BASH,   REST,         ROCK_SLIDE,   SUBSTITUTE,   SURF,         \
	     STRENGTH
	; end

	db 0 ; padding
