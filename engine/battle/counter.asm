; Determine whether Counter hits and, if so, set wDamage to twice the damage
; the user actually received from a Normal/Fighting move during this turn.
HandleCounterMove::
	ldh a, [hWhoseTurn]
	and a
	ld hl, wPlayerCounterDamage
	ld a, [wPlayerSelectedMove]
	jr z, .selected
	ld hl, wEnemyCounterDamage
	ld a, [wEnemySelectedMove]
.selected
	cp COUNTER
	ret nz
	ld a, 1
	ld [wMoveMissed], a
	ld a, [hli]
	ld b, a
	or [hl]
	ret z
	ld a, [hl]
	add a
	ld [wDamage + 1], a
	ld a, b
	adc a
	ld [wDamage], a
	jr nc, .damageReady
	ld a, $ff
	ld [wDamage], a
	ld [wDamage + 1], a
.damageReady
	xor a
	ld [wMoveMissed], a
	farcall MoveHitTest
	xor a
	ret

; Record actual HP damage from Normal/Fighting moves for Counter. Substitute
; damage and misses bypass this routine, leaving the turn's record at zero.
RecordCounterableDamage::
	ldh a, [hWhoseTurn]
	and a
	jr nz, .enemyAttacked
	ld a, [wPlayerMoveType]
	ld de, wEnemyCounterDamage
	jr .checkType
.enemyAttacked
	ld a, [wEnemyMoveType]
	ld de, wPlayerCounterDamage
.checkType
	and a ; NORMAL
	jr z, .store
	cp FIGHTING
	ret nz
.store
	ld hl, wDamage
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret
