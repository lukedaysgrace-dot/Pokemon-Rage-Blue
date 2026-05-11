VermilionTradeHouse_Script:
	jp EnableAutoTextBoxDrawing

VermilionTradeHouse_TextPointers:
	def_text_pointers
	dw_const VermilionTradeHouseLittleGirlText, TEXT_VERMILIONTRADEHOUSE_LITTLE_GIRL
	dw_const VermilionTradeHouseGamblerText,    TEXT_VERMILIONTRADEHOUSE_GAMBLER
	dw_const VermilionTradeHouseChikoritaText,  TEXT_VERMILIONTRADEHOUSE_CHIKORITA

VermilionTradeHouseLittleGirlText:
	text_asm
	ld a, TRADE_FOR_DUX
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	jp TextScriptEnd

VermilionTradeHouseGamblerText:
	text_asm
	CheckEvent EVENT_GOT_CHIKORITA_IN_TRADE_HOUSE
	jr nz, .after_gift
	ld hl, .OfferText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
	lb bc, CHIKORITA, 10
	call GivePokemon
	jr nc, .done
	SetEvent EVENT_GOT_CHIKORITA_IN_TRADE_HOUSE
	ld a, TOGGLE_VERMILION_TRADE_HOUSE_CHIKORITA
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
	text "Hic!"
	line "This little"
	cont "CHIKORITA"
	cont "followed me home!"

	para "The darn thing"
	line "won't leave me"
	cont "alone."

	para "Will you take it"
	line "with you?"
	done

.ReceivedText:
	text "Hic! Good."

	para "Maybe it'll stick"
	line "to you instead."
	done

.AfterGiftText:
	text "Hic!"

	para "That CHIKORITA"
	line "sure picked its"
	cont "trainer fast."
	done

.RefusedText:
	text "Hic..."

	para "Then I guess it's"
	line "still following"
	cont "me."
	done

VermilionTradeHouseChikoritaText:
	text_far _VermilionTradeHouseChikoritaText
	text_asm
	ld a, CHIKORITA
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
