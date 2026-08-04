SeafoamIslands1F_Script:
	call EnableAutoTextBoxDrawing
	SetEvent EVENT_IN_SEAFOAM_ISLANDS
	ld hl, wMiscFlags
	bit BIT_PUSHED_BOULDER, [hl]
	res BIT_PUSHED_BOULDER, [hl]
	jr z, .noBoulderWasPushed
	ld hl, Seafoam1HolesCoords
	call CheckBoulderCoords
	ret nc
	EventFlagAddress hl, EVENT_SEAFOAM1_BOULDER1_DOWN_HOLE
	ld a, [wCoordIndex]
	cp $1
	jr nz, .boulder2FellDownHole
	SetEventReuseHL EVENT_SEAFOAM1_BOULDER1_DOWN_HOLE
	ld de, TOGGLE_SEAFOAM_ISLANDS_1F_BOULDER_1 ; object to hide
	ld bc, TOGGLE_SEAFOAM_ISLANDS_B1F_BOULDER_1 ; object to show
	jr .hideAndShowBoulderObjects
.boulder2FellDownHole
	SetEventAfterBranchReuseHL EVENT_SEAFOAM1_BOULDER2_DOWN_HOLE, EVENT_SEAFOAM1_BOULDER1_DOWN_HOLE
	ld de, TOGGLE_SEAFOAM_ISLANDS_1F_BOULDER_2 ; object to hide
	ld bc, TOGGLE_SEAFOAM_ISLANDS_B1F_BOULDER_2 ; object to show
.hideAndShowBoulderObjects
	push bc
	predef HideObject
	pop de
	predef_jump ShowObject
.noBoulderWasPushed
	ld a, SEAFOAM_ISLANDS_B1F
	ld [wDungeonWarpDestinationMap], a
	ld hl, Seafoam1HolesCoords
	jp IsPlayerOnDungeonWarp

Seafoam1HolesCoords:
	dbmapcoord 17,  6
	dbmapcoord 24,  6
	db -1 ; end

SeafoamIslands1F_TextPointers:
	def_text_pointers
	dw_const BoulderText, TEXT_SEAFOAMISLANDS1F_BOULDER1
	dw_const BoulderText, TEXT_SEAFOAMISLANDS1F_BOULDER2
