ThunderFangEffect_:
	xor a
	ld [wAnimationType], a ; as FreezeBurnParalyzeEffect does; else the hud shake
	                       ; plays with the move's own animation type still set
; 10% chance to paralyze the target and an independent 10% chance to flinch.
; NOTE: this file lives outside the battle-core bank. Bankswitch (used by
; callfar) clobbers a, b, c, and hl on the way back, so a value returned in a
; (like BattleRandom's result) can NOT be read after a callfar. Random lives
; in the home bank, so it can be called directly from anywhere instead.
	callfar CheckTargetSubstitute
	ret nz ; can't affect a target behind a substitute
	call .paralyzeEffect
; fallthrough
.flinchEffect
	call Random
	cp 10 percent + 1
	ret nc
; load the flinch target only after the RNG call, so hl can't be clobbered
	ld hl, wEnemyBattleStatus1
	ldh a, [hWhoseTurn]
	and a
	jr z, .gotFlinchTarget
	ld hl, wPlayerBattleStatus1
.gotFlinchTarget
	set FLINCHED, [hl]
	callfar ClearHyperBeam
	ret

.paralyzeEffect
	ldh a, [hWhoseTurn]
	and a
	jr nz, .opponentAttacker
	ld a, [wEnemyMonStatus]
	and a
	ret nz
	ld a, [wPlayerMoveType]
	ld b, a
	ld a, [wEnemyMonType1]
	cp b
	ret z
	ld a, [wEnemyMonType2]
	cp b
	ret z
	call Random
	cp 10 percent + 1
	ret nc
	ld a, 1 << PAR
	ld [wEnemyMonStatus], a
	callfar QuarterSpeedDueToParalysis
; pass the animation ID through wAnimationID: Bankswitch would clobber a
	ld a, ENEMY_HUD_SHAKE_ANIM
	ld [wAnimationID], a
	callfar PlayBattleAnimationGotID
	callfar PrintMayNotAttackText
	ret
.opponentAttacker
	ld a, [wBattleMonStatus]
	and a
	ret nz
	ld a, [wEnemyMoveType]
	ld b, a
	ld a, [wBattleMonType1]
	cp b
	ret z
	ld a, [wBattleMonType2]
	cp b
	ret z
	call Random
	cp 10 percent + 1
	ret nc
	ld a, 1 << PAR
	ld [wBattleMonStatus], a
	callfar QuarterSpeedDueToParalysis
	callfar PrintMayNotAttackText
	ret
