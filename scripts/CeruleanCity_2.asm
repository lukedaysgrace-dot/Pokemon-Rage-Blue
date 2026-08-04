CeruleanHideRocket:
; code similar to this appears in a lot of banks; this particular
; one is called after you beat the Rocket that gives you TM28 DIG.
; the screen then fades out, he disappears, and fades back in
	call GBFadeOutToBlack
	ld de, TOGGLE_CERULEAN_GUARD_1
	predef ShowObject
	ld de, TOGGLE_CERULEAN_GUARD_2
	predef HideObject
	ld de, TOGGLE_CERULEAN_ROCKET
	predef HideObject
	call GBFadeInFromBlack
	ret
