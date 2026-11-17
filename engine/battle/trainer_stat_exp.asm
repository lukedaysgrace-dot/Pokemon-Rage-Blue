InitializeTrainerStatExp::
; de = byte before the new mon's Stat EXP. Write all five big-endian words
; before CalcStats, returning de at the last byte written, as AddPartyMon
; expects. Player additions, Normal Mode and ordinary trainers get zero.
	push de
	ld a, [wMonDataLocation]
	and $f
	jr z, .zero
	ld a, [wLinkState]
	and a
	jr nz, .zero
	ld a, [wDifficulty]
	and a
	jr z, .zero
	call GetTrainerStatExpMatchingPolicy
	jr nc, .zero
	ld b, a ; point bonus
	pop hl
	push hl
	inc hl
	ld c, 0 ; byte offset into the player's Stat EXP
.stat
	push hl
	call GetPlayerMaximumStatExp
	ld a, b
	and a
	call nz, AddTrainerStatExpPointBonus
	pop hl
	ld a, d
	ld [hli], a
	ld a, e
	ld [hli], a
	inc c
	inc c
	ld a, c
	cp NUM_STATS * 2
	jr c, .stat
	jr .done
.zero
	pop hl
	push hl
	inc hl
	xor a
	ld b, NUM_STATS * 2
.clear
	ld [hli], a
	dec b
	jr nz, .clear
.done
	pop hl
	ld de, NUM_STATS * 2
	add hl, de
	ld d, h
	ld e, l
	ret

GetTrainerStatExpMatchingPolicy::
; Carry = matching class found; a = point bonus. Preserves de.
	ld a, [wTrainerClass]
	ld c, a
	ld hl, TrainerStatExpMatchingPolicy
.next
	ld a, [hli]
	cp $ff
	jr z, .none
	cp c
	jr z, .found
	inc hl
	jr .next
.found
	ld a, [hl]
	scf
	ret
.none
	and a
	ret

GetPlayerMaximumStatExp::
; c = byte offset (0/2/4/6/8); de = highest corresponding party word.
; Preserves bc. Fainted members count; empty/terminator slots do not.
	push bc
	ld de, 0
	ld a, [wPartyCount]
	and a
	jr z, .done
	cp PARTY_LENGTH + 1
	jr nc, .done
	ld b, a
	ld hl, wPartyMon1
.mon
	ld a, [hl]
	and a
	jr z, .nextMon
	cp $ff
	jr z, .nextMon
	push hl
	push bc
	ld b, 0
	add hl, bc
	ld bc, MON_HP_EXP
	add hl, bc
	ld a, [hli]
	cp d
	jr c, .keep
	jr nz, .replace
	ld a, [hl]
	cp e
	jr c, .keep
.replace
	ld a, [hld]
	ld e, a
	ld d, [hl]
.keep
	pop bc
	pop hl
.nextMon
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec b
	jr nz, .mon
.done
	pop bc
	ret

AddTrainerStatExpPointBonus::
; de = raw Stat EXP, b = bonus. Preserve bc, return the square threshold
; for the extra training points, saturating at $ffff. Match CalcStat's
; ceil(sqrt(word)), capped at 255, then divide by four before adding.
	push bc
	ld b, 0
	ld hl, 1 ; successive odd numbers sum to successive squares
	ld a, d
	or e
	jr z, .points
.sqrt
	inc b
	ld a, e
	sub l
	ld e, a
	ld a, d
	sbc h
	ld d, a
	jr c, .points
	or e
	jr z, .points
	ld a, b
	cp $ff
	jr z, .points
	inc hl
	inc hl
	jr .sqrt
.points
	srl b
	srl b
	ld a, b
	pop bc
	push bc
	add b
	cp 63
	jr nc, .maximum
	add a
	add a
	ld c, a
	ld b, 0
	ld hl, 0
	call AddNTimes ; hl = (4 * target points)^2
	ld d, h
	ld e, l
	jr .done
.maximum
	ld de, $ffff
.done
	pop bc
	ret

INCLUDE "data/trainers/stat_exp_matching.asm"
