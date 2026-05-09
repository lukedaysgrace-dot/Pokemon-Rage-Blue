	object_const_def
	const_export CERULEANBADGEHOUSE_SCIENTIST

CeruleanBadgeHouse_Object:
	db $17 ; border block

	def_warp_events
	warp_event  2,  0, LAST_MAP, 11
	warp_event  3,  0, LAST_MAP, 11
	warp_event  2,  7, LAST_MAP, 9
	warp_event  3,  7, LAST_MAP, 9

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_SCIENTIST, WALK, LEFT_RIGHT, TEXT_CERULEANBADGEHOUSE_SCIENTIST

	def_warps_to CERULEAN_BADGE_HOUSE
