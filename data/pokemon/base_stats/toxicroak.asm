	db DEX_TOXICROAK ; pokedex id

	db  83, 106,  75,  85,  85
	;   hp  atk  def  spd  spc

	db POISON, FIGHTING ; type
	db  75 ; catch rate
	db 185 ; base exp

	INCBIN "gfx/pokemon/front/toxicroak.pic", 0, 1 ; sprite dimensions
	dw ToxicroakPicFront, ToxicroakPicBack

	db POISON_STING, KARATE_CHOP, BITE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    HYPER_BEAM,   TAKE_DOWN,    DOUBLE_EDGE,  \
	     SUBMISSION,   DIG,          MIMIC,        DOUBLE_TEAM,  ROCK_SLIDE,   \
	     REST,         SUBSTITUTE,   STRENGTH
	; end

	db 0 ; padding
