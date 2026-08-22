; Hard mode gym level caps.
; On hard mode the party level cap is the highest-level Pokémon of the next
; gym leader still to be beaten. Once all 8 badges are obtained, the cap is
; lifted entirely.
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
	push de
	ld hl, wObtainedBadges
	ld b, 1
	call CountSetBits
	pop de
	ld a, [wNumSetBits]
	ld hl, HardModeLevelCaps
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
.done
	ld [wLevelCap], a
	pop hl
	pop bc
	ret

HardModeLevelCaps:
; number of badges -> level cap
	db 15        ; 0 badges: Brock's Onix
	db 22        ; 1 badge:  Misty's Starmie
	db 25        ; 2 badges: Lt. Surge's Raichu
	db 33        ; 3 badges: Erika's Exeggutor/Vileplume
	db 43        ; 4 badges: Koga's Weezing
	db 49        ; 5 badges: Sabrina's Gardevoir
	db 54        ; 6 badges: Blaine's Flareon
	db 55        ; 7 badges: Giovanni's Marowak
	db MAX_LEVEL ; 8 badges: the cap goes away
