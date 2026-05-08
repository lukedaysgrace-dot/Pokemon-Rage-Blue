	db DEX_MAGNEZONE ; pokedex id

	db   70,  70, 115,  70, 130
	;   hp  atk  def  spd  spc

	db ELECTRIC, STEEL ; type
	db 30 ; catch rate
	db 211 ; base exp

; First byte: .pic from pkmncompress(gfx/pokemon/front/magnezone.png). INCBIN must stay .pic, not .png.
	INCBIN "gfx/pokemon/front/magnezone.pic", 0, 1
	dw MagnezonePicFront, MagnezonePicBack

	db TACKLE, SONICBOOM, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        TAKE_DOWN,    DOUBLE_EDGE,  HYPER_BEAM,   RAGE,         \
	     THUNDERBOLT,  THUNDER,      TELEPORT,     MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         SWIFT,        REST,         THUNDER_WAVE, \
	     SUBSTITUTE,   FLASH
	; end

	db 0 ; padding
