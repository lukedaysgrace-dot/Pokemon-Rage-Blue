	object_const_def
	const_export INDIGOPLATEAU_GRAMPS

IndigoPlateau_Object:
	db $e ; border block

	def_warp_events
	warp_event  9,  5, INDIGO_PLATEAU_LOBBY, 1
	warp_event 10,  5, INDIGO_PLATEAU_LOBBY, 1

	def_bg_events

	def_object_events
	object_event  9,  6, SPRITE_GRAMPS, STAY, DOWN, TEXT_INDIGOPLATEAU_GRAMPS

	def_warps_to INDIGO_PLATEAU
