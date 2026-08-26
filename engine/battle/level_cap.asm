; Hard mode gym level caps.
; On hard mode the party level cap is the highest-level Pokémon of the first
; unbeaten gym leader in the intended gym order. Looking at individual badge
; bits instead of merely counting badges prevents an out-of-order badge from
; advancing the cap past an earlier unbeaten leader. Once all 8 badges are
; obtained, the cap is lifted entirely.
;
; OUTPUT:
; a = current level cap (MAX_LEVEL when no cap applies)
; [wLevelCap] = same value (for callers in other banks, since the value in
;               a does not survive a callfar)
; preserves bc, de and hl
GetLevelCap::
	push bc
	push hl
	ld a, [wDifficulty]
	and a
	ld a, MAX_LEVEL
	jr z, .done ; no level caps on normal mode
	ld a, [wObtainedBadges]
	ld c, a
	ld hl, HardModeLevelCaps
	ld b, 1 << BIT_BOULDERBADGE
.findFirstUnbeatenGym
	ld a, c
	and b
	jr z, .foundCap
	inc hl
	sla b
	jr nz, .findFirstUnbeatenGym
	ld a, MAX_LEVEL ; all eight badges obtained
	jr .done
.foundCap
	ld a, [hl]
.done
	ld [wLevelCap], a
	pop hl
	pop bc
	ret

HardModeLevelCaps:
	table_width 1, HardModeLevelCaps
; badge bit -> leader level cap
	db 15 ; Boulder: Brock's Onix
	db 22 ; Cascade: Misty's Starmie
	db 25 ; Thunder: Lt. Surge's Raichu
	db 33 ; Rainbow: Erika's Exeggutor/Vileplume
	db 43 ; Soul: Koga's Weezing
	db 49 ; Marsh: Sabrina's Gardevoir
	db 54 ; Volcano: Blaine's Flareon
	db 55 ; Earth: Giovanni's Marowak
	assert_table_length NUM_BADGES
