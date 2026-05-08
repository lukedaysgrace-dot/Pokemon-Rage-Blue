	db DEX_ESPEON ; pokedex id

	db   67,  60,  60, 110, 133
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 184 ; base exp

; First byte: .pic from pkmncompress(gfx/pokemon/front/espeon.png). INCBIN must stay .pic, not .png.
	INCBIN "gfx/pokemon/front/espeon.pic", 0, 1
	dw EspeonPicFront, EspeonPicBack

	db TACKLE, TAIL_WHIP, SAND_ATTACK, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     PAY_DAY,      MEGA_KICK,    MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         SWIFT,        SKULL_BASH,   REST,         THUNDER_WAVE, \
	     PSYCHIC_M,    PSYWAVE,      SUBSTITUTE
	; end

	db 0 ; padding
