CheckPoisonableTarget_:
; Steel-type targets can't be poisoned by Poison-type moves.
; A non-Poison-type move with a poison chance (e.g. Twineedle) can still
; poison them like it can any other type.
; Returns z if poisoning is blocked, nz if it may proceed.
; Also returns hl = the target's Type1 address: this routine is callfar'd
; from PoisonEffect, and Bankswitch clobbers hl on the way back, so the
; caller relies on hl being rebuilt here (dec hl from Type1 = Status).
	ldh a, [hWhoseTurn]
	and a
	jr nz, .enemyAttacking
; player attacking: the target is the enemy mon
	ld hl, wEnemyMonType1
	ld a, [wPlayerMoveType]
	jr .gotMoveType
.enemyAttacking
; enemy attacking: the target is the player's mon
	ld hl, wBattleMonType1
	ld a, [wEnemyMoveType]
.gotMoveType
	cp POISON
	jr nz, .canPoison ; only Poison-type moves are blocked by Steel
	ld a, [hli]
	cp STEEL
	jr z, .blocked
	ld a, [hld]
	cp STEEL
	ret ; z: blocked by Type2 (hl already back at Type1); nz: not blocked
.blocked
	dec hl ; point hl back at Type1 (16-bit dec does not affect flags)
	ret
.canPoison
	ld a, 1
	and a ; force nz
	ret
