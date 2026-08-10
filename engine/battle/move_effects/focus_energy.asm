FocusEnergyEffect_:
; moved out of the battle-core bank (which is completely full) to make room
; for the Steel poison-immunity check in PoisonEffect
	ld hl, wPlayerBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .focusEnergyEffect
	ld hl, wEnemyBattleStatus2
.focusEnergyEffect
	set GETTING_PUMPED, [hl]
	callfar PlayCurrentMoveAnimation
	ld hl, GettingPumpedText
	jp PrintText

GettingPumpedText:
	text_far _GettingPumpedText
	text_end
