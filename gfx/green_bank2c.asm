; Extra graphics in ROM bank $2C (same bank as custom trainer moves) to avoid overflowing
; "Blue Cloak OW Sprite" (bank $1), etc.
SECTION "Yellow Fishing Tiles", ROMX

YellowFishingTilesFront:: INCBIN "gfx/overworld/yellow_fish_front.2bpp"
YellowFishingTilesBack::  INCBIN "gfx/overworld/yellow_fish_back.2bpp"
YellowFishingTilesSide::  INCBIN "gfx/overworld/yellow_fish_side.2bpp"


SECTION "Green Player OW Sprites", ROMX

GreenSprite::            INCBIN "gfx/sprites/green.2bpp"
YellowSprite::           INCBIN "gfx/sprites/yellow.2bpp"
YellowBikeSprite::       INCBIN "gfx/sprites/yellow_bike.2bpp"
YellowSkateboardSprite:: INCBIN "gfx/sprites/yellow_skateboard.2bpp"


SECTION "Green Rocket OW Sprite", ROMX

GreenRocketSprite:: INCBIN "gfx/sprites/greenrocket.2bpp"


SECTION "Green Pic Back", ROMX

GreenPicBack:: INCBIN "gfx/player/greenb.pic"


SECTION "Yellow Pic Back", ROMX

YellowPicBack:: INCBIN "gfx/player/yellowb.pic"


SECTION "Green Rocket Trainer Pic", ROMX

GreenRocketPic:: INCBIN "gfx/trainers/greenrocket.pic"


SECTION "Ninja Janine Trainer Pics", ROMX

NinjaPic::  INCBIN "gfx/trainers/ninja.pic"
JaninePic:: INCBIN "gfx/trainers/janine.pic"


SECTION "Rocket Executive Trainer Pics", ROMX

PetrelPic:: INCBIN "gfx/trainers/petrel.pic"
ProtonPic:: INCBIN "gfx/trainers/proton.pic"
ArcherPic:: INCBIN "gfx/trainers/archer.pic"
ArianaPic:: INCBIN "gfx/trainers/ariana.pic"
SoldierPic:: INCBIN "gfx/trainers/soldier.pic"
