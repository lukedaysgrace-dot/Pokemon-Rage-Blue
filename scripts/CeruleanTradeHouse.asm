CeruleanTradeHouse_Script:
	jp EnableAutoTextBoxDrawing

CeruleanTradeHouse_TextPointers:
	def_text_pointers
	dw_const CeruleanTradeHouseGrannyText,  TEXT_CERULEANTRADEHOUSE_GRANNY
	dw_const CeruleanTradeHouseGamblerText, TEXT_CERULEANTRADEHOUSE_GAMBLER
	dw_const CeruleanTradeHouseGirlText,    TEXT_CERULEANTRADEHOUSE_GIRL
	dw_const CeruleanTradeHouseBulbasaurText, TEXT_CERULEANTRADEHOUSE_BULBASAUR

CeruleanTradeHouseGrannyText:
	text_far _CeruleanTradeHouseGrannyText
	text_end

CeruleanTradeHouseGamblerText:
	text_asm
	ld a, TRADE_FOR_LOLA
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	jp TextScriptEnd

CeruleanTradeHouseGirlText:
	text_asm
	CheckEvent EVENT_GOT_BULBASAUR_IN_CERULEAN
	jr nz, .after_gift
	ld a, [wPlayerStarter]
	cp STARTER3
	jr z, .same_starter
	ld hl, .OfferText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
	lb bc, BULBASAUR, 10
	call GivePokemon
	jr nc, .done
	SetEvent EVENT_GOT_BULBASAUR_IN_CERULEAN
	ld a, TOGGLE_CERULEAN_TRADE_HOUSE_BULBASAUR
	ld [wToggleableObjectIndex], a
	predef HideObject
	ld hl, .ReceivedText
	call PrintText
	jr .done
.refused
	ld hl, .RefusedText
	call PrintText
	jr .done
.same_starter
	ld hl, .SameStarterText
	call PrintText
	jr .done
.after_gift
	ld hl, .AfterGiftText
	call PrintText
.done
	jp TextScriptEnd

.OfferText:
	text_far _CeruleanTradeHouseGirlOfferText
	text_end

.ReceivedText:
	text_far _CeruleanTradeHouseGirlReceivedText
	text_end

.SameStarterText:
	text_far _CeruleanTradeHouseGirlSameStarterText
	text_end

.AfterGiftText:
	text_far _CeruleanTradeHouseGirlAfterGiftText
	text_end

.RefusedText:
	text_far _CeruleanTradeHouseGirlRefusedText
	text_end

CeruleanTradeHouseBulbasaurText:
	text_far _CeruleanTradeHouseBulbasaurText
	text_asm
	ld a, BULBASAUR
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
