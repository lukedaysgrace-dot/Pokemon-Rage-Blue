; Syntactic sugar macros

MACRO? lb ; r, hi, lo
	ld \1, ((\2) & $ff) << 8 + ((\3) & $ff)
ENDM

MACRO? ldpal
	ld \1, \2 << 6 | \3 << 4 | \4 << 2 | \5
ENDM

; Design patterns

MACRO ld_hli_a_string
	FOR n, CHARLEN(\1) - 1
		ld a, CHARVAL(STRCHAR(\1, n))
		ld [hli], a
	ENDR
	ld [hl], CHARVAL(STRCHAR(\1, CHARLEN(\1) - 1))
ENDM

MACRO dict
	IF \1 == 0
		and a
	ELSE
		cp \1
	ENDC
	jp z, \2
ENDM

; Converts the map-local toggleable object index in a (as stored in
; wToggleableObjectList) into the global index in de, which is what
; ShowObject/HideObject and ToggleableObjectFlagAction expect.
; There are more than 256 toggleable objects, so the global index does not
; fit in 8 bits and must never be round-tripped through a single byte.
; Clobbers a and hl.
MACRO global_toggle_index
	ld hl, wToggleableObjectBase
	add a, [hl]
	ld e, a
	inc hl
	ld a, [hl]
	adc a, 0
	ld d, a
ENDM
