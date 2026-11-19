	db DEX_WHIRLIPEDE ; pokedex id

	db   40,  55,  99,  47,  60
	;   hp  atk  def  spd  spc

	db BUG, POISON ; type
	db 120 ; catch rate
	db 72 ; base exp

; First byte: .pic from pkmncompress(gfx/pokemon/front/whirlipede.png). INCBIN must stay .pic, not .png.
	INCBIN "gfx/pokemon/front/whirlipede.pic", 0, 1
	dw WhirlipedePicFront, WhirlipedePicBack

	db DEFENSE_CURL, POISON_STING, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC        , TAKE_DOWN    , DOUBLE_EDGE  , MEGA_DRAIN   , \
	     SOLARBEAM    , MIMIC        , DOUBLE_TEAM  , BIDE         , SWIFT        , \
	     SLUDGE_BOMB  , REST         , SUBSTITUTE
	; end

	db BANK(WhirlipedePicFront)
	assert BANK(WhirlipedePicFront) == BANK(WhirlipedePicBack)
