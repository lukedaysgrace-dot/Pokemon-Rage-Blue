	db DEX_MAGMORTAR ; pokedex id

	db   90,  95, 77,  83, 110
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 30 ; catch rate
	db 192 ; base exp

; First byte: .pic from pkmncompress(gfx/pokemon/front/magmortar.png). INCBIN must stay .pic, not .png.
	INCBIN "gfx/pokemon/front/magmortar.pic", 0, 1
	dw MagmortarPicFront, MagmortarPicBack

	db EMBER, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   MEGA_KICK,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  HYPER_BEAM,   SUBMISSION,   COUNTER,      SEISMIC_TOSS, \
	     PSYCHIC_M,    RAGE,         SOLARBEAM,    FLAMETHROWER, FIRE_BLAST,   PSYWAVE,      \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         METRONOME,    SWIFT,        \
	     SKULL_BASH,   REST,         SUBSTITUTE,   STRENGTH
	; end

	db 0 ; padding
