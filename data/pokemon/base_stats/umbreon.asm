	db DEX_UMBREON ; pokedex id

	db   95, 95,  90,  70,  80
	;   hp  atk  def  spd  spc

	db DARK, DARK ; type
	db 45 ; catch rate
	db 197 ; base exp

; First byte: .pic from pkmncompress(gfx/pokemon/front/umbreon.png). INCBIN must stay .pic, not .png.
	INCBIN "gfx/pokemon/front/umbreon.pic", 0, 1
	dw UmbreonPicFront, UmbreonPicBack

	db TACKLE, TAIL_WHIP, SAND_ATTACK, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     PAY_DAY,      MIMIC,        DOUBLE_TEAM,  BIDE,         SWIFT,        \
	     SKULL_BASH,   REST,         SUBSTITUTE
	; end

	db 0 ; padding
