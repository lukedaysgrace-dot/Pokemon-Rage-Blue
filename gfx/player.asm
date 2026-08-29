RedPicFront::   INCBIN "gfx/player/red.pic"
GreenPicFront:: INCBIN "gfx/player/green.pic"
YellowPicFront::  INCBIN "gfx/player/yellow.pic"
ShrinkPic1::   INCBIN "gfx/player/shrink1.pic"
ShrinkPic2::   INCBIN "gfx/player/shrink2.pic"

	ASSERT BANK(RedPicFront) == BANK(GreenPicFront)
	ASSERT BANK(RedPicFront) == BANK(YellowPicFront)
