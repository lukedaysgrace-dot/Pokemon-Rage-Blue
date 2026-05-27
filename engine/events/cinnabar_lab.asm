GiveFossilToCinnabarLab::
	ld hl, wStatusFlags5
	set BIT_NO_TEXT_DELAY, [hl]
	xor a
	ld [wCurrentMenuItem], a
	ld a, PAD_A | PAD_B
	ld [wMenuWatchedKeys], a
	ld a, [wFilteredBagItemsCount]
	dec a
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
	ld a, [wFilteredBagItemsCount]
	dec a
	ld bc, 2
	ld hl, 3
	call AddNTimes
	dec l
	ld b, l
	ld c, $d
	hlcoord 0, 0
	call TextBoxBorder
	call UpdateSprites
	call PrintFossilsInBag
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	call HandleMenuInput
	bit B_PAD_B, a
	jp nz, .cancelledGivingFossil
	ld hl, wFilteredBagItems
	ld a, [wCurrentMenuItem]
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	ldh [hItemToRemoveID], a
	cp DOME_FOSSIL
	jr z, .choseDomeFossil
	cp HELIX_FOSSIL
	jr z, .choseHelixFossil
	cp SKULL_FOSSIL
	jr z, .choseSkullFossil
	cp ARMOR_FOSSIL
	jr z, .choseArmorFossil
	cp CLAW_FOSSIL
	jr z, .choseClawFossil
	cp ROOT_FOSSIL
	jr z, .choseRootFossil
	cp JAW_FOSSIL
	jr z, .choseJawFossil
	cp SAIL_FOSSIL
	jr z, .choseSailFossil
	ld b, AERODACTYL
	jr .fossilSelected
.choseSailFossil
	ld b, TOXEL
	jr .fossilSelected
.choseJawFossil
	ld b, CUFANT
	jr .fossilSelected
.choseRootFossil
	ld b, LILEEP
	jr .fossilSelected
.choseClawFossil
	ld b, ANORITH
	jr .fossilSelected
.choseArmorFossil
	ld b, SHIELDON
	jr .fossilSelected
.choseSkullFossil
	ld b, CRANIDOS
	jr .fossilSelected
.choseHelixFossil
	ld b, OMANYTE
	jr .fossilSelected
.choseDomeFossil
	ld b, KABUTO
.fossilSelected
	ld [wFossilItem], a
	ld a, b
	ld [wFossilMon], a
	call LoadFossilItemAndMonName
	ld hl, .ScientistSeesFossilText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .cancelledGivingFossil
	ld hl, .ScientistTakesFossilText
	call PrintText
	ld a, [wFossilItem]
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	ld hl, .GoForAWalkText
	call PrintText
	SetEvents EVENT_GAVE_FOSSIL_TO_LAB, EVENT_LAB_STILL_REVIVING_FOSSIL
	ret
.cancelledGivingFossil
	ld hl, .ComeAgainText
	call PrintText
	ret

.ScientistSeesFossilText:
	text_far _CinnabarLabFossilRoomScientist1SeesFossilText
	text_end

.ScientistTakesFossilText:
	text_far _CinnabarLabFossilRoomScientist1TakesFossilText
	text_end

.GoForAWalkText:
	text_far _CinnabarLabFossilRoomScientist1GoForAWalkText2
	text_end

.ComeAgainText:
	text_far _CinnabarLabFossilRoomScientist1ComeAgainText
	text_end

PrintFossilsInBag:
; Prints each fossil in the player's bag on a separate line in the menu.
	ld hl, wFilteredBagItems
	xor a
	ldh [hItemCounter], a
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wNamedObjectIndex], a
	call GetItemName
	hlcoord 2, 2
	ldh a, [hItemCounter]
	ld bc, SCREEN_WIDTH * 2
	call AddNTimes
	ld de, wNameBuffer
	call PlaceString
	ld hl, hItemCounter
	inc [hl]
	pop hl
	jr .loop

; loads the names of the fossil item and the resulting mon
LoadFossilItemAndMonName::
	ld a, [wFossilMon]
	ld [wNamedObjectIndex], a
	call GetMonName
	call CopyToStringBuffer
	ld a, [wFossilItem]
	ld [wNamedObjectIndex], a
	call GetItemName
	ret

Lab4Script_GetFossilsInBag::
	xor a
	ld [wFilteredBagItemsCount], a
	ld de, wFilteredBagItems
	ld hl, FossilsList
.loop
	ld a, [hli]
	and a
	jr z, .done
	push hl
	push de
	ld [wTempByteValue], a
	ld b, a
	predef GetQuantityOfItemInBag
	pop de
	pop hl
	ld a, b
	and a
	jr z, .loop
	ld a, [wTempByteValue]
	ld [de], a
	inc de
	push hl
	ld hl, wFilteredBagItemsCount
	inc [hl]
	pop hl
	jr .loop
.done
	ld a, $ff
	ld [de], a
	ret

FossilsList:
	db DOME_FOSSIL
	db HELIX_FOSSIL
	db SKULL_FOSSIL
	db ARMOR_FOSSIL
	db CLAW_FOSSIL
	db ROOT_FOSSIL
	db JAW_FOSSIL
	db SAIL_FOSSIL
	db OLD_AMBER
	db 0 ; end
