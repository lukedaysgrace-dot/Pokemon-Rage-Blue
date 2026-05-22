BikeShop_Script:
	call EnableAutoTextBoxDrawing
IF DEF(_BLUE)
	CheckEvent EVENT_GOT_TOTODILE_IN_BIKE_SHOP
	ret nz
	ld a, TOGGLE_BIKE_SHOP_TOTODILE
	ld [wToggleableObjectIndex], a
	predef ShowObject
ENDC
	ret

BikeShop_TextPointers:
	def_text_pointers
	dw_const BikeShopClerkText,             TEXT_BIKESHOP_CLERK
	dw_const BikeShopMiddleAgedWomanText,   TEXT_BIKESHOP_MIDDLE_AGED_WOMAN
	dw_const BikeShopYoungsterText,         TEXT_BIKESHOP_YOUNGSTER
	dw_const BikeShopSailorText,            TEXT_BIKESHOP_SAILOR
	dw_const BikeShopTotodileText,          TEXT_BIKESHOP_TOTODILE

BikeShopClerkText:
	text_asm
	CheckEvent EVENT_GOT_BICYCLE
	jr z, .dontHaveBike
	CheckEvent EVENT_GOT_SKATEBOARD_FROM_BIKE_SHOP
	jr nz, .howDoYouLikeSkateboard
	ld hl, BikeShopClerkHowDoYouLikeYourBicycleText
	call PrintText
	jp .Done
.howDoYouLikeSkateboard
	ld hl, BikeShopClerkHowDoYouLikeYourSkateboardText
	call PrintText
	jp .Done
.dontHaveBike
	ld b, BIKE_VOUCHER
	call IsItemInBag
	jr z, .dontHaveVoucher
	ld hl, BikeShopClerkOhThatsAVoucherText
	call PrintText
	ld hl, BikeShopClerkVoucherChoiceIntroText
	call PrintText
	call BikeShopVoucherChoiceMenu
	bit B_PAD_B, a
	jp nz, .Done
	ld a, [wCurrentMenuItem]
	and a
	ld a, BICYCLE
	jr z, .gotVoucherChoice
	ld a, SKATEBOARD
.gotVoucherChoice
	ld [wCurItem], a
	ld e, a ; preserve voucher choice across GiveItem / RemoveItemByID
	ld b, a ; GiveItem expects item ID in b (not [wCurItem] alone)
	push de
	ld c, 1
	call GiveItem
	pop de
	jr nc, .BagFull
	push de
	ld a, BIKE_VOUCHER
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	pop de
	SetEvent EVENT_GOT_BICYCLE
	ld a, e
	cp SKATEBOARD
	jr nz, .choseBikeFromVoucher
	SetEvent EVENT_GOT_SKATEBOARD_FROM_BIKE_SHOP
	jr .afterVoucherRewardFlag
.choseBikeFromVoucher
	ResetEvent EVENT_GOT_SKATEBOARD_FROM_BIKE_SHOP
.afterVoucherRewardFlag
	ld a, e
	cp SKATEBOARD
	ld hl, BikeShopExchangedVoucherSkateboardText
	jr z, .printExchangeText
	ld hl, BikeShopExchangedVoucherBikeText
.printExchangeText
	push de
	call PrintText
	pop de
	ld a, e
	cp SKATEBOARD
	jr nz, .Done
	ld hl, BikeShopClerkSkateboardFollowupText
	call PrintText
	jr .Done
.BagFull
	ld hl, BikeShopBagFullText
	call PrintText
	jr .Done
.dontHaveVoucher
	ld hl, BikeShopClerkWelcomeText
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld a, PAD_A | PAD_B
	ld [wMenuWatchedKeys], a
	ld a, $1
	ld [wMaxMenuItem], a
	ld a, $2
	ld [wTopMenuItemY], a
	ld a, $1
	ld [wTopMenuItemX], a
	ld hl, wStatusFlags5
	set BIT_NO_TEXT_DELAY, [hl]
	hlcoord 0, 0
	ld b, 4
	ld c, 15
	call TextBoxBorder
	call UpdateSprites
	hlcoord 2, 2
	ld de, BikeShopMenuText
	call PlaceString
	hlcoord 8, 3
	ld de, BikeShopMenuPrice
	call PlaceString
	ld hl, BikeShopClerkDoYouLikeItText
	call PrintText
	call HandleMenuInput
	bit B_PAD_B, a
	jr nz, .cancel
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .cancel
	ld hl, BikeShopCantAffordText
	call PrintText
.cancel
	ld hl, BikeShopComeAgainText
	call PrintText
.Done
	jp TextScriptEnd

BikeShopMenuText:
	db   "BICYCLE"
	next "CANCEL@"

BikeShopMenuPrice:
	db "¥1000000@"

BikeShopClerkWelcomeText:
	text_far _BikeShopClerkWelcomeText
	text_end

BikeShopClerkDoYouLikeItText:
	text_far _BikeShopClerkDoYouLikeItText
	text_end

BikeShopCantAffordText:
	text_far _BikeShopCantAffordText
	text_end

BikeShopClerkOhThatsAVoucherText:
	text_far _BikeShopClerkOhThatsAVoucherText
	text_end

BikeShopClerkVoucherChoiceIntroText:
	text_far _BikeShopClerkVoucherChoiceIntroText
	text_end

BikeShopExchangedVoucherBikeText:
	text_far _BikeShopExchangedVoucherBikeText
	sound_get_key_item
	text_end

BikeShopExchangedVoucherSkateboardText:
	text_far _BikeShopExchangedVoucherSkateboardText
	sound_get_key_item
	text_end

BikeShopClerkSkateboardFollowupText:
	text_far _BikeShopClerkSkateboardFollowupText
	text_end

BikeShopComeAgainText:
	text_far _BikeShopComeAgainText
	text_end

BikeShopClerkHowDoYouLikeYourBicycleText:
	text_far _BikeShopClerkHowDoYouLikeYourBicycleText
	text_end

BikeShopClerkHowDoYouLikeYourSkateboardText:
	text_far _BikeShopClerkHowDoYouLikeYourSkateboardText
	text_end

BikeShopBagFullText:
	text_far _BikeShopBagFullText
	text_end

BikeShopVoucherChoiceMenu:
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld a, PAD_A | PAD_B
	ld [wMenuWatchedKeys], a
	ld a, $2
	ld [wMaxMenuItem], a
	ld a, $2
	ld [wTopMenuItemY], a
	ld a, $1
	ld [wTopMenuItemX], a
	ld hl, wStatusFlags5
	set BIT_NO_TEXT_DELAY, [hl]
	hlcoord 0, 0
	ld b, 6
	ld c, 18
	call TextBoxBorder
	call UpdateSprites
	hlcoord 2, 2
	ld de, BikeShopVoucherChoiceText
	call PlaceString
	call HandleMenuInput
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	ret

BikeShopVoucherChoiceText:
	db   "BICYCLE"
	next "SKATEBOARD"
	next "CANCEL@"

BikeShopMiddleAgedWomanText:
	text_asm
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text_far _BikeShopMiddleAgedWomanText
	text_end

BikeShopYoungsterText:
	text_asm
	CheckEvent EVENT_GOT_BICYCLE
	ld hl, .CoolBikeText
	jr nz, .gotBike
	ld hl, .TheseBikesAreExpensiveText
.gotBike
	call PrintText
	jp TextScriptEnd

.TheseBikesAreExpensiveText:
	text_far _BikeShopYoungsterTheseBikesAreExpensiveText
	text_end

.CoolBikeText:
	text_far _BikeShopYoungsterCoolBikeText
	text_end

BikeShopSailorText:
	text_asm
	CheckEvent EVENT_GOT_TOTODILE_IN_BIKE_SHOP
	jr nz, .after_gift
	ld hl, .OfferText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
	lb bc, TOTODILE, 10
	call GivePokemon
	jr nc, .done
	SetEvent EVENT_GOT_TOTODILE_IN_BIKE_SHOP
	ld a, TOGGLE_BIKE_SHOP_TOTODILE
	ld [wToggleableObjectIndex], a
	predef HideObject
	ld hl, .ReceivedText
	call PrintText
	jr .done
.after_gift
	ld hl, .AfterGiftText
	call PrintText
	jr .done
.refused
	ld hl, .RefusedText
	call PrintText
.done
	jp TextScriptEnd

.OfferText:
	text_far _BikeShopSailorOfferText
	text_end

.ReceivedText:
	text_far _BikeShopSailorReceivedText
	text_end

.AfterGiftText:
	text_far _BikeShopSailorAfterGiftText
	text_end

.RefusedText:
	text_far _BikeShopSailorRefusedText
	text_end

BikeShopTotodileText:
	text_far _BikeShopTotodileText
	text_asm
	ld a, TOTODILE
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
