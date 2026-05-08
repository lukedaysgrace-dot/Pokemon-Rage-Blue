	db DEX_CROBAT ; pokedex id

	db   85,  90,  80, 130,  70
	;   hp  atk  def  spd  spc

	db POISON, FLYING ; type
	db 90 ; catch rate
	db 204 ; base exp

; First byte: .pic from pkmncompress(gfx/pokemon/front/crobat.png). INCBIN must stay .pic, not .png.
	INCBIN "gfx/pokemon/front/crobat.pic", 0, 1
	dw CrobatPicFront, CrobatPicBack

	db LEECH_LIFE, SCREECH, BITE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm RAZOR_WIND,   CRUNCH,       TOXIC,        TAKE_DOWN,    DOUBLE_EDGE,  \
	     HYPER_BEAM,   RAGE,         MEGA_DRAIN,   MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         SWIFT,        REST,         SUBSTITUTE
	; end

	db 0 ; padding
