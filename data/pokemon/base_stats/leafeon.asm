	db DEX_LEAFEON ; pokedex id

	db   65, 60, 100,  95, 110
	;   hp  atk  def  spd  spc

	db GRASS, GRASS ; type
	db 45 ; catch rate
	db 196 ; base exp

; First byte: compressed .pic header (built from gfx/pokemon/front/leafeon.png via Makefile). Do not INCBIN .png.
; Name your art leafeon.png / leafeonb.png — not leafeonb.png on front or leafeon.png on back.
	INCBIN "gfx/pokemon/front/leafeon.pic", 0, 1
	dw LeafeonPicFront, LeafeonPicBack

	db TACKLE, SAND_ATTACK, RAZOR_LEAF, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    TAKE_DOWN,    DOUBLE_EDGE,  \
	     MEGA_DRAIN,   SOLARBEAM,    RAGE,         MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         SWIFT,        SKULL_BASH,   REST,         SUBSTITUTE,   \
	     CUT
	; end

	db 0 ; padding
