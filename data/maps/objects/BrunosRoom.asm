	object_const_def
IF DEF(_RED)
	const_export BRUNOSROOM_BRUNO
ELSE
	const_export KARENSROOM_KAREN
ENDC

BrunosRoom_Object:
	db $3 ; border block

	def_warp_events
	warp_event  4, 11, LORELEIS_ROOM, 3
	warp_event  5, 11, LORELEIS_ROOM, 4
	warp_event  4,  0, AGATHAS_ROOM, 1
	warp_event  5,  0, AGATHAS_ROOM, 2

	def_bg_events

	def_object_events
IF DEF(_RED)
	object_event  5,  2, SPRITE_BRUNO, STAY, DOWN, TEXT_BRUNOSROOM_BRUNO, OPP_BRUNO, 1
ELSE
	object_event  5,  2, SPRITE_KAREN, STAY, DOWN, TEXT_KARENSROOM_KAREN, OPP_KAREN, 1
ENDC

IF DEF(_RED)
	def_warps_to BRUNOS_ROOM
ELSE
	def_warps_to KARENS_ROOM
ENDC
