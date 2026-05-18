MtMoonB1F_Script:
	call EnableAutoTextBoxDrawing
	ret

MtMoonB1F_TextPointers:
	def_text_pointers
	dw_const PickUpItemText,            TEXT_MTMOONB1F_JAW_FOSSIL
	dw_const PickUpItemText,            TEXT_MTMOONB1F_SAIL_FOSSIL
	dw_const MtMoonB1FUnusedText,       TEXT_MTMOONB1F_UNUSED

MtMoonB1FUnusedText:
	text_far _MtMoonB1FUnusedText
	text_end
