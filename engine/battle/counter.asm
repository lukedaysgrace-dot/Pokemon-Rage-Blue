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
; Input: e = 0 if the player's Pokemon took the damage, nonzero if the enemy's
; did. Self-inflicted damage (confusion, Jump Kick recoil) is applied during a
; momentary turn swap, so the attacker and the victim are the same side; that
; damage is not counterable and must not be recorded.
RecordCounterableDamage::
	ldh a, [hWhoseTurn]
	and a
	jr nz, .enemyAttacked
	ld a, e
	and a
	ret z ; player attacked and the player took the damage: self-inflicted
	ld a, [wPlayerMoveType]
	ld de, wEnemyCounterDamage
	jr .checkType
.enemyAttacked
	ld a, e
	and a
	ret nz ; enemy attacked and the enemy took the damage: self-inflicted
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
