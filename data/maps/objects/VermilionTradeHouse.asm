	object_const_def
	const_export VERMILIONTRADEHOUSE_LITTLE_GIRL
	const_export VERMILIONTRADEHOUSE_GAMBLER
	const_export VERMILIONTRADEHOUSE_CHIKORITA

VermilionTradeHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 8
	warp_event  3,  7, LAST_MAP, 8

	def_bg_events

	def_object_events
	object_event  3,  5, SPRITE_LITTLE_GIRL, STAY, UP, TEXT_VERMILIONTRADEHOUSE_LITTLE_GIRL
IF DEF(_BLUE)
	object_event  2,  1, SPRITE_GAMBLER_ASLEEP, STAY, DOWN, TEXT_VERMILIONTRADEHOUSE_GAMBLER
	object_event  3,  1, SPRITE_CHIKORITA, STAY, LEFT, TEXT_VERMILIONTRADEHOUSE_CHIKORITA
ENDC

	def_warps_to VERMILION_TRADE_HOUSE
