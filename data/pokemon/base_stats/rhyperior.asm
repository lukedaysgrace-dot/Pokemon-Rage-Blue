	db DEX_RHYPERIOR ; pokedex id

	db  115, 140, 130,  40,  55
	;   hp  atk  def  spd  spc

	db GROUND, ROCK ; type
	db 30 ; catch rate
	db 217 ; base exp

; First byte: .pic from pkmncompress(gfx/pokemon/front/rhyperior.png). INCBIN must stay .pic, not .png.
	INCBIN "gfx/pokemon/front/rhyperior.pic", 0, 1
	dw RhyperiorPicFront, RhyperiorPicBack

	db HORN_ATTACK, STOMP, TAIL_WHIP, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   MEGA_KICK,    TOXIC,        SHADOW_BALL,  BODY_SLAM,    \
	     TAKE_DOWN,    DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     \
	     BLIZZARD,     HYPER_BEAM,   PAY_DAY,      SUBMISSION,   COUNTER,      \
	     SEISMIC_TOSS, RAGE,         THUNDERBOLT,  THUNDER,      EARTHQUAKE,   \
	     FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,         \
	     FLAMETHROWER, FIRE_BLAST,   SKULL_BASH,   REST,         ROCK_SLIDE,   SUBSTITUTE,   \
	     SURF,         STRENGTH
	; end

	db 0 ; padding
