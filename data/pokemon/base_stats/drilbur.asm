	db DEX_DRILBUR ; pokedex id

	db   60,  85,  40,  68,  45
	;   hp  atk  def  spd  spc

	db GROUND, GROUND ; type
	db 120 ; catch rate
	db 66 ; base exp

; First byte: .pic from pkmncompress(gfx/pokemon/front/drilbur.png). INCBIN must stay .pic, not .png.
	INCBIN "gfx/pokemon/front/drilbur.pic", 0, 1
	dw DrilburPicFront, DrilburPicBack

	db SCRATCH, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE , TOXIC        , TAKE_DOWN    , DOUBLE_EDGE  , METAL_CLAW   , \
	     SUBMISSION   , EARTHQUAKE   , FISSURE      , DIG          , DOUBLE_TEAM  , \
	     SLUDGE_BOMB  , REST         , ROCK_SLIDE   , SUBSTITUTE   , CUT          , \
	     STRENGTH
	; end

	db BANK(DrilburPicFront)
	assert BANK(DrilburPicFront) == BANK(DrilburPicBack)
