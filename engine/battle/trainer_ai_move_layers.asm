; Phase 1 trainer move AI (layers 1-3), adapted from Shin Pokémon Red (joenote).
AIMoveChoiceModification1:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	ld a, [wBattleMonStatus]
;	and a
;	ret z ; return if no status ailment on player's mon
;joenote - don't return yet. going to check for dream eater. will do this later
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z ; no more moves in move set
	inc de
	call ReadMove
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.checkBadMoves
;joenote - do not use effects that end battle because this is a trainer battle and they do not work
	ld a, [wEnemyMoveEffect]	;load the move effect
	cp SWITCH_AND_TELEPORT_EFFECT	;see if it is a battle-ending effect
	jp z, .heavydiscourage	;heavily discourage if so
.checkBadMoves_rage
;rage kind of sucks even though it does something, so slightly discourage it if it might be worth using, otherwise heavily discourage
	cp RAGE_EFFECT
	jr nz, .endBadMoves
	call StrCmpSpeed	;do a speed compare
	jp nc, .heavydiscourage	;don't even bother if the ai pokemon does not out-speed the player
	ld a, [wPlayerMoveEffect]
	cp TWO_TO_FIVE_ATTACKS_EFFECT
	jr z, .checkBadMoves_rage_okay
	cp ATTACK_TWICE_EFFECT
	jp nz, .heavydiscourage
.checkBadMoves_rage_okay
	inc [hl]	;only slightly discourage
	jp .nextMove
.endBadMoves
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - do not use dream eater if enemy not asleep, otherwise encourage it
	ld a, [wEnemyMoveEffect]	;load the move effect
	cp DREAM_EATER_EFFECT	;see if it is dream eater
	jr nz, .notdreameater	;skip out if move is not dream eater
	ld a, [wActionResultOrTookBattleTurn]
	and a
	jp nz, .nextMove	;if player switched or used an item, AI should be blind to the change
	ld a, [wBattleMonStatus]	;load the player pkmn non-volatile status
	and $7	;check bits 0 to 2 for sleeping turns
	jp z, .heavydiscourage	;heavily discourage using dream eater on non-sleeping pkmn
	dec [hl]	;else slightly encourage dream eater's use on a sleeping pkmn
	jp .nextMove
.notdreameater	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - do not use counter against a non-applicable move
	ld a, [wEnemyMoveNum]	
	cp COUNTER
	jr nz, .countercheck_end	;if this move is not counter then jump out
	ld a, [wPlayerMovePower]
	and a
	jp z, .heavydiscourage	;heavily discourage counter if enemy is using zero-power move
	ld a, [wPlayerMoveType]
	cp NORMAL
	jr z, .countercheck_end	; continue on if countering a normal move
	cp FIGHTING
	jr z, .countercheck_end	; continue on if countering a fighting move
	cp BIRD
	jr z, .countercheck_end	; continue on if countering STRUGGLE or other typeless move
	jp .heavydiscourage	;else heavily discourage since the player move type is not applicable to counter
.countercheck_end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - do not use moves that are ineffective against substitute if a substitute is up
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a	;check for substitute bit
	jr z, .noSubImm	;if the substitute bit is not set, then skip out of this block
	ld a, [wEnemyMoveEffect]	;get the move effect into a
	push hl
	push de
	push bc
	ld hl, SubstituteImmuneEffects
	ld de, $0001
	call IsInArray	;see if a is found in the hl array (carry flag set if true)
	pop bc
	pop de
	pop hl
	jp c, .heavydiscourage	;carry flag means the move effect is blocked by substitute
	;else continue onward
.noSubImm	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Heavily discourage healing or exploding moves if HP is full. Encourage if hp is low
	ld a, [wEnemyMoveEffect]	;load the move effect
	cp HEAL_EFFECT	;see if it is a healing move
	jr z, .heal_explode	;skip out if move is not
	cp EXPLODE_EFFECT	;what about an explosion effect?
	jr nz, .not_heal_explode	;skip out if move is not
	
	;since this is an explosion effect, it would be good to heavily discourage if
	;the opponent is in fly/dig state and the exploder is for-sure faster than the opponent
	ld a, [wPlayerBattleStatus1]
	bit 6, a
	jr z, .heal_explode	;proceed as normal if player is not in fly/dig
	call StrCmpSpeed	;do a speed compare
	jp c, .heavydiscourage	;a set carry bit means the ai 'mon is faster, so heavily discourage
	
.heal_explode
	ld a, 1	;
	call AICheckIfHPBelowFraction
	jp nc, .heavydiscourage	;heavy discourage if hp at max (heal +5 & explode +5)
	inc [hl]	;1/2 hp to max hp - slight discourage (heal +1 & explode +1)
	ld a, 2	;
	call AICheckIfHPBelowFraction
	jp nc, .nextMove	;if hp is 1/2 or more, get next move
	dec [hl]	;else 1/3 to 1/2 hp - neutral (heal 0 & explode 0)
	ld a, 3	;
	call AICheckIfHPBelowFraction
	jp nc, .nextMove	;if hp is 1/3 or more, get next move
	dec [hl]	;else 0 to 1/3 hp - slight preference (heal -1 & explode -1)
	jp .nextMove	;get next move
.not_heal_explode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Randomly discourage 2-turn moves if confused or paralyzed
	;check for 2-turn move
	ld a, [wEnemyMoveEffect]
	cp FLY_EFFECT
	jr z, .twoturncheck_par
	cp CHARGE_EFFECT
	jr nz, .twoturndone
	
.twoturncheck_par
	;handle paralysis
	ld a, [wEnemyMonStatus]
	bit PAR, a
	jr z, .twoturncheck_confused
	call Random
	cp $70
	jr nc, .twoturncheck_confused
	inc [hl]	;random chance to discourage if paralyzed
	inc [hl]
	
.twoturncheck_confused
	;handle confusion
	ld a, [wEnemyBattleStatus1]
	bit 7, a ;check confusion bit
	jr z, .twoturndone
	call Random
	cp $C0
	jr nc, .twoturndone
	inc [hl]	;random chance to discourage if confused
	inc [hl]
	
.twoturndone
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - discourage the use of fly or dig if a slower player is doing the same
; this is because the faster 'mon always misses if both decide to use fly/dig
	ld a, [wEnemyMoveNum]
	call IsDigOrFly
	jr nz, .end_bothusedigorfly
	ld a, [wPlayerMoveNum]
	call IsDigOrFly
	jr nz, .end_bothusedigorfly
	ld a, [wPlayerBattleStatus1]
	bit 6, a
	jr nz, .end_bothusedigorfly	;player is already in dig/fly invulnerability if nz, so move on
	call StrCmpSpeed
	jr z, .end_bothusedigorfly	;speeds equal if z, so move on
	jr c, .end_bothusedigorfly	;speed is less than player if carry, so move on
	;else AI is faster than player
	;discourage because AI will miss and player will hit
	inc [hl]
	inc [hl]
.end_bothusedigorfly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld a, [wEnemyMovePower]
	and a
	jp nz, .nextMove	;go to next move if the current move is not zero-power
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;**************************************************************************************************************************
;At this line onward all moves are assumed to be zero power
;**************************************************************************************************************************
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - slightly discourage all zero power moves if the player's pokemon has < 1/2 HP remaining
	ld a, 2
	call AICheckIfPlayerHPBelowFraction
	jr nc, .end_playerHPcheck
	inc [hl]
.end_playerHPcheck
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - do not use haze if user has no status or neutral stat mods
	ld a, [wEnemyMoveEffect]	;load the move effect
	cp HAZE_EFFECT	;see if it is haze
	jp nz, .hazekickout	;move on if not haze
;using haze at this point
	ld a, [wEnemyMonStatus]	;get status
	and a
	jp z, .heavydiscourage	;discourage if status is clear
	push hl
	push bc
	xor a
	ld b, 6
	ld hl, wEnemyMonStatMods
.hazeloop
	add [hl]
	inc hl
	dec b
	jr nz, .hazeloop
	pop bc
	pop hl
	cp 42
	jp nc, .heavydiscourage	;discourage if summed stat mods are same or more than 42 (7 per mod is neutral)
.hazekickout
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - do not use disable on a pkmn that is already disabled
	ld a, [wEnemyMoveEffect]	;load the move effect
	cp DISABLE_EFFECT
	jr nz, .notdisable
	ld a, [wPlayerDisabledMove]	
	and a
	jp nz, .heavydiscourage	
.notdisable
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - do not use substitute if not enough hp
	ld a, [wEnemyMoveEffect]
	cp SUBSTITUTE_EFFECT
	jr nz, .notsubstitute
	ld a, 4	;
	call AICheckIfHPBelowFraction
	jp c, .heavydiscourage
.notsubstitute
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - do not use moves that are blocked by mist
	ld a, [wPlayerBattleStatus2]
	bit PROTECTED_BY_MIST, a	;check for mist bit
	jr z, .noMistImm	;if the mist bit is not set, then skip out of this block
	ld a, [wEnemyMoveEffect]	;get the move effect into a
	push hl
	push de
	push bc
	ld hl, MistBlockEffects
	ld de, $0001
	call IsInArray	;see if a is found in the hl array (carry flag set if true)
	pop bc
	pop de
	pop hl
	jp c, .heavydiscourage	;carry flag means the move effect is blocked by mist
	;else continue onward
.noMistImm	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - do not use defense-up moves if opponent is special attacking
	ld a, [wEnemyMoveEffect]	;get the move effect
	cp LIGHT_SCREEN_EFFECT	
	jr z, .do_def_check
	cp REFLECT_EFFECT	
	jr z, .do_def_check
	cp DEFENSE_UP1_EFFECT	
	jr z, .do_def_check
	cp DEFENSE_UP2_EFFECT
	jr nz, .nodefupmove
.do_def_check
	ld a, [wPlayerMoveEffect]
	cp SPECIAL_DAMAGE_EFFECT
	jp z, .heavydiscourage	;don't bother boosting def against static damage attacks
	cp OHKO_EFFECT
	jp z, .heavydiscourage	;don't bother boosting def against OHKO attacks
	ld a, [wPlayerMovePower]	;all regular damage moves have a power of at least 10
	cp 10
	jr c, .nodefupmove
.do_def_check_lightscreen
	ld a, [wEnemyMoveEffect]	;get the move effect
	cp LIGHT_SCREEN_EFFECT
	jr nz, .do_def_check_other
	ld a, [wPlayerMoveType]	;physical: types < SPECIAL (incl. Dark/Steel); special: FIRE–GHOST
	cp SPECIAL
	jp c, .heavydiscourage	;at this point, heavy discourage light screen because player is using a physical move of 10+ power
	jr .nodefupmove
.do_def_check_other
	ld a, [wPlayerMoveType]	;physical: types < SPECIAL; special: types >= SPECIAL
	cp SPECIAL
	jp nc, .heavydiscourage	;at this point, heavy discourage defense-boosting because player is using a special move of 10+ power
.nodefupmove
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - heavily discourage stat modifying moves if it would hit the mod limit and be ineffective
	;check for stat down effects
	ld a, [wEnemyMoveEffect]	;get the move effect
	cp ATTACK_DOWN1_EFFECT	
	jr c, .nostatdownmod	;if value is < the ATTACK_DOWN1_EFFECT value, jump out
	cp EVASION_DOWN2_EFFECT	+ $1
	jr nc, .nostatdownmod	;if value >= EVASION_DOWN2_EFFECT value + $1, jump out
	cp EVASION_DOWN1_EFFECT	+ $1
	jr c, .statdownmod	;if value < EVASION_DOWN1_EFFECT value + $1, there is a stat down move
	cp ATTACK_DOWN2_EFFECT	
	jr nc, .statdownmod	;if value is >= the ATTACK_DOWN2_EFFECT value, there is a stat down move
	jr .nostatdownmod; else the effect is something else in-between the target values
.statdownmod
	sub ATTACK_DOWN1_EFFECT	;normalize the effects from 0 to 5 to get an offset
	cp EVASION_DOWN1_EFFECT + $1 - ATTACK_DOWN1_EFFECT ; covers all -1 effects
	jr c, .statdowncheck
	sub ATTACK_DOWN2_EFFECT - ATTACK_DOWN1_EFFECT ; map -2 effects to corresponding -1 effect
.statdowncheck	
	push hl
	push bc
	ld hl, wPlayerMonStatMods	;load the player's stat mods
	ld c, a
	ld b, $0
	add hl, bc	;use offset to shift to the correct stat mod
	ld b, [hl]
	dec b ; decrement corresponding stat mod
	pop bc
	pop hl
	jr nz, .endstatmod ; if stat mod was > 1 before decrementing, then it's fine to lower
	;else can't be lowered anymore
	jp .heavydiscourage
.nostatdownmod
	;check for stat up effects
	ld a, [wEnemyMoveEffect]	;get the move effect
	cp ATTACK_UP1_EFFECT
	jr c, .endstatmod	;if value is < the ATTACK_UP1_EFFECT value, jump out
	cp EVASION_UP2_EFFECT + $1
	jr nc, .endstatmod	;if value >= EVASION_UP2_EFFECT value + $1, jump out
	cp EVASION_UP1_EFFECT + $1
	jr c, .statupmod	;if value < EVASION_UP1_EFFECT value + $1, there is a stat up move
	cp ATTACK_UP2_EFFECT	
	jr nc, .statupmod	;if value is >= the ATTACK_UP2_EFFECT value, there is a stat up move
	jr .endstatmod; else the effect is something else in-between the target values
.statupmod
	sub ATTACK_UP1_EFFECT	;normalize the effects from 0 to 5 to get an offset
	cp EVASION_UP1_EFFECT + $1 - ATTACK_UP1_EFFECT ; covers all +1 effects
	jr c, .statupcheck
	sub ATTACK_UP2_EFFECT - ATTACK_UP1_EFFECT ; map +2 effects to corresponding +1 effect
.statupcheck	
	push hl
	push bc
	ld hl, wEnemyMonStatMods	;load the enemy's stat mods
	ld c, a
	ld b, $0
	add hl, bc	;use offset to shift to the correct stat mod
	ld b, [hl]
	inc b ; increment corresponding stat mod
	ld a, $0d
	cp b ; can't raise stat past +6 ($0d or 13)
	pop bc
	pop hl
	jr nc, .endstatmod ; if stat mod was < $0d before incrementing, then it's fine to raise
	;else can't be raised anymore
	jp .heavydiscourage
.endstatmod
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - heavily discourage moves that do not stack
	;check each of the stackabe effects one by one and jump to the corresponding section
	ld a, [wEnemyMoveEffect]
	cp LIGHT_SCREEN_EFFECT
	jr z, .checkscreen
	cp REFLECT_EFFECT
	jr z, .checkreflect
	cp SUBSTITUTE_EFFECT
	jr z, .checksub
	cp MIST_EFFECT
	jr z, .checkmist
	cp LEECH_SEED_EFFECT
	jr z, .checkseed
	jr .endstacking
.checkscreen ;check status, and heavily discourage if bit is set
	ld a, [wEnemyBattleStatus3]
	bit HAS_LIGHT_SCREEN_UP, a
	jp nz, .heavydiscourage
	jr .endstacking
.checkreflect	;check status, and heavily discourage if bit is set
	ld a, [wEnemyBattleStatus3]
	bit HAS_REFLECT_UP, a
	jp nz, .heavydiscourage
	jr .endstacking
.checkmist	;check status, and heavily discourage if bit is set
	ld a, [wEnemyBattleStatus2]
	bit PROTECTED_BY_MIST, a
	jp nz, .heavydiscourage
	jr .endstacking
.checksub	;check status, and heavily discourage if bit is set
	ld a, [wEnemyBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jp nz, .heavydiscourage
	jr .endstacking
.checkseed
	;first check to make sure leech seed isn't used on a grass pokemon
	push bc
	push hl
	ld hl, wBattleMonType
	ld b, [hl]                 ; b = type 1 of player's pokemon
	inc hl
	ld c, [hl]                 ; c = type 2 of player's pokemon
	ld a, b		;load type 1 into a
	cp GRASS	;is type 1 grass?
	jr z, .seedgrasstest	;skip ahead if type1 is grass
	ld a, c		;load type 2 into a
.seedgrasstest
	pop hl
	pop bc
	cp GRASS	;a is either type 1 grass or it is type 2 yet to be confirmed
	jp z, .heavydiscourage	;heavily discourage if either of the types are grass
	;else, not to make sure it isn't already used
	;check status, and heavily discourage if bit is set
	ld a, [wPlayerBattleStatus2]
	bit SEEDED, a
	jp nz, .heavydiscourage
.endstacking
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - discourage using confuse-only moves on confused pkmn
	ld a, [wEnemyMoveEffect]
	cp CONFUSION_EFFECT	;see if the move has a confusion effect
	jr nz, .notconfuse	;skip out if move is not a zero-power confusion move
	ld a, [wPlayerBattleStatus1]	;load the player pkmn volatile status
	and $80	;check bit 7 for confusion bit
	jp nz, .heavydiscourage	;heavily discourage using zero-power confusion moves on confused pkmn
.notconfuse
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;don't use a status move against a status'd target
	ld a, [wEnemyMoveEffect]
	push hl
	push de
	push bc
	ld hl, StatusAilmentMoveEffects
	ld de, $0001
	call IsInArray
	pop bc
	pop de
	pop hl
	jr nc, .nostatusconflict
	ld a, [wBattleMonStatus]
	and a
	jr nz, .heavydiscourage
.nostatusconflict
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote: fix spamming of buff/debuff moves
	;See if the move has an effect that should not be dissuaded
	ld a, [wEnemyMoveEffect]
	push hl
	push de
	push bc
	ld hl, EffectsToNotDissuade
	ld de, $0001
	call IsInArray
	pop bc
	pop de
	pop hl
	jr nc, .spamprotection	;If not found on list, run anti-spam on it
	;if it is in the list, has only a chance of anti-spam being run on it

;let's try to blind the AI a bit so that it won't just status the player immediately after using
;a restorative item or switching
	;effect found on list of spam-exempt moves, is this a status move (includes status-like effects)?
	ld a, [wEnemyMoveEffect]
	push hl
	push de
	push bc
	ld hl, StatusAilmentMoveEffectsExtended
	ld de, $0001
	call IsInArray
	pop bc
	pop de
	pop hl
	jr nc, .skipoutspam	;skip if not in the list of status effects (it's healing or a substitute or something)
	
	;effect is a status move, did the player use an item or switch?
	ld a, [wActionResultOrTookBattleTurn]
	and a
	jr z, .skipoutspam	;skip if player did not use an item or switch
	
	;79.68% chance per move that the AI is blind to the fact that the player switched or used an item
	;with three status moves on an AI mon, this works out to ~50% chance overall
	call Random
	cp 204
	jr nc, .skipoutspam	; if >= 204, proceed as normal
	;else run spam protection on the status move to simulate not predicting the player
	
.spamprotection
;heavily discourage 0 BP moves if health is below 1/3 max
	ld a, 3
	call AICheckIfHPBelowFraction
	jp c, .heavydiscourage
;heavily discourage 0 BP moves if one was used just previously
	ld a, [wAILastMovePower]
	and a
	jp z, .heavydiscourage
;else apply a random bias to the 0 bp move we are on
	call Random	
;outcome desired: 	50% chance to heavily discourage and would rather do damage
;					12.5% chance to slightly encourage
;					else neither encourage nor discourage
	cp 128	;don't set carry flag if number is >= this value
	jp nc, .heavydiscourage	
	cp 32
	jp c, .givepref	;if not discouraged, then there is a chance to slightly encourage to spice things up
	;else neither encourage nor discourage
.skipoutspam
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - end of this AI layer
	jp .nextMove
.heavydiscourage
	ld a, [hl]
	add $5 ; heavily discourage move
	ld [hl], a
	jp .nextMove
.givepref	;joenote - added marker
	dec [hl] ; slightly encourage this move
	jp .nextMove

EffectsToNotDissuade:
	db HEAL_EFFECT
	db SUBSTITUTE_EFFECT
	;fall through
StatusAilmentMoveEffectsExtended:
	db CONFUSION_EFFECT
	db LEECH_SEED_EFFECT
	db DISABLE_EFFECT
	;fall through
StatusAilmentMoveEffects:
	db $01 ; unused sleep effect
	db SLEEP_EFFECT
	db POISON_EFFECT
	db PARALYZE_EFFECT
	db $FF

SubstituteImmuneEffects:	;joenote - added this table to track for substitute immunities
	db $01 ; unused sleep effect
	db SLEEP_EFFECT
	db POISON_EFFECT
	db PARALYZE_EFFECT
	db CONFUSION_EFFECT
	db DRAIN_HP_EFFECT
	db LEECH_SEED_EFFECT
	db DREAM_EATER_EFFECT
	;fall through
MistBlockEffects:	;joenote - added this table to track for things blocked by mist
	db ATTACK_DOWN1_EFFECT
	db DEFENSE_DOWN1_EFFECT
	db SPEED_DOWN1_EFFECT
	db SPECIAL_DOWN1_EFFECT
	db ACCURACY_DOWN1_EFFECT
	db EVASION_DOWN1_EFFECT
	db ATTACK_DOWN2_EFFECT
	db DEFENSE_DOWN2_EFFECT
	db SPEED_DOWN2_EFFECT
	db SPECIAL_DOWN2_EFFECT
	db ACCURACY_DOWN2_EFFECT
	db EVASION_DOWN2_EFFECT
	db $FF

SpecialZeroBPMoves:	;joenote - added this table to tracks 0 bp moves that should not be treated as buffs
	db BIDE
	db METRONOME
	db THUNDER_WAVE
	db $FF
	
OtherZeroBPEffects:	;joenote - added to keep track of some outliers
	db LEECH_SEED_EFFECT
	db DISABLE_EFFECT
	db CONFUSION_EFFECT
	db $FF

; slightly encourage moves with specific effects.
; in particular, stat-modifying moves and other move effects
; that fall in-between
AIMoveChoiceModification2:
	ld a, [wAILayer2Encouragement]
	and a ;cp $1	;joenote - AI layer 2 should activate on 1st turn instead of 2nd turn after sendout
	ret nz
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z ; no more moves in move set
	inc de
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp ATTACK_UP1_EFFECT
	jr c, .nextMove
	cp BIDE_EFFECT
	jr c, .preferMove
	cp ATTACK_UP2_EFFECT
	jr c, .nextMove
	cp POISON_EFFECT
	jr c, .preferMove
	jr .nextMove
.preferMove
	dec [hl] ; slightly encourage this move
	jr .nextMove

; encourages moves that are effective against the player's mon (even if non-damaging).
; discourage damaging moves that are ineffective or not very effective against the player's mon,
; unless there's no damaging move that deals at least neutral damage
; joenote - updated to also do some more advanced battle strategies
AIMoveChoiceModification3:
; If the player used the turn for a switch, item, etc., skip type logic (no free switch-in info).
	ld a, [wActionResultOrTookBattleTurn]
	and a
	ret nz
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z ; no more moves in move set
	inc de
	call ReadMove
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;don't use poison-effect moves on poison-type pokemon
	ld a, [wEnemyMoveEffect]
	cp POISON_EFFECT
	jr nz, .notpoisoneffect
	ld a, [wBattleMonType]
	cp POISON
	jp z, .heavydiscourage2
	ld a, [wBattleMonType + 1]
	cp POISON
	jp z, .heavydiscourage2
.notpoisoneffect
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;slightly discourage using most offensive moves against fly/dig opponent if faster than opponent
	ld a, [wPlayerBattleStatus1]
	bit 6, a
	jr z, .endflydigcheck	;proceed as normal if player is not in fly/dig
	
	call StrCmpSpeed	;do a speed compare
	jr c, .flydigcheck_faster	;a set carry bit means the ai 'mon is faster
	ld a, [wEnemyMoveNum]
	cp EXTREME_SPEED
	jr z, .flydigcheck_faster
	cp QUICK_ATTACK
	jr z, .flydigcheck_faster
	cp SUCKER_PUNCH
	jr z, .flydigcheck_faster
	cp MACH_PUNCH
	jr z, .flydigcheck_faster
	cp ICE_SHARD
	jr z, .flydigcheck_faster
	cp ACCELEROCK
	jr z, .flydigcheck_faster

.flydigcheck_notfaster
	jr .endflydigcheck

.flydigcheck_faster
	;slightly discourage stuff that will just miss
	ld a, [wEnemyMoveEffect]
	push hl
	push de
	push bc
	ld hl, MistBlockEffects
	ld de, $0001
	call IsInArray
	pop bc
	pop de
	pop hl
	jr c, .flydigcheck_discourage

	ld a, [wEnemyMoveEffect]
	push hl
	push de
	push bc
	ld hl, StatusAilmentMoveEffects
	ld de, $0001
	call IsInArray
	pop bc
	pop de
	pop hl
	jr c, .flydigcheck_discourage

	ld a, [wEnemyMoveEffect]
	push hl
	push de
	push bc
	ld hl, OtherZeroBPEffects
	ld de, $0001
	call IsInArray
	pop bc
	pop de
	pop hl
	jr c, .flydigcheck_discourage

	ld a, [wEnemyMovePower]
	and a
	jr z, .endflydigcheck

	ld a, [wEnemyMoveEffect]
	cp FLY_EFFECT
	jr z, .endflydigcheck
	cp CHARGE_EFFECT
	jr z, .endflydigcheck
	
.flydigcheck_discourage
	inc [hl]
.endflydigcheck
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;check on certain moves with zero bp but are handled differently
	ld a, [wEnemyMoveNum]
	push hl
	push de
	push bc
	ld hl, SpecialZeroBPMoves
	ld de, $0001
	call IsInArray	;see if a is found in the hl array (carry flag set if true)
	pop bc
	pop de
	pop hl
	jp c, .specialBPend	;If found on list, treat it as if it were a damaging move

	;otherise only handle moves that deal damage from here on out
	ld a, [wEnemyMovePower]
	and a
	jp z, .nextMove	;go to next move if the current move is zero-power
.specialBPend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	;90.625% chance per move that AI is blind to the player switching, so treat the move as neutrally effective
;	commented out because a different solution is used higher up
;	ld a, [wActionResultOrTookBattleTurn]
;	cp $A
;	jr nz, .blind_end
;	call Random
;	cp 232
;	jr c, .neutral_effective	; if <, treat move as neutral damage
;	;else proceed as normal
;.blind_end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - heavily discourage attack moves that have no effect due to typing
	push hl
	push bc
	push de
	callfar AIGetTypeEffectiveness
	pop de
	pop bc
	pop hl

	ld a, [wTypeEffectiveness]	;get the effectiveness
	and a 	;check if it's zero
	jr nz, .skipout2	;skip if it's not immune
.heavydiscourage2	;at this line the move has no effect due to immunity or other circumstance
;heavily discourage move
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
.lightlydiscourage
	inc [hl]
	jp .nextMove
.skipout2
	;if thunder wave is being used against a non-immune target, neither encourage nor discourage it
	ld a, [wEnemyMoveNum]
	cp THUNDER_WAVE
	jp z, .nextMove
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - do not use ohko moves on faster opponents, since they will auto-miss
	ld a, [wEnemyMoveEffect]	;load the move effect
	cp OHKO_EFFECT	;see if it is ohko move
	jr nz, .skipout3	;skip ahead if not ohko move
	ld a, [wEnemyBattleStatus2]
	bit USING_X_ACCURACY, a
	jp nz, .nextMove	;X-accuracy is being used so ohko move viable
	call StrCmpSpeed	;do a speed compare
	jp c, .nextMove	;ai is fast enough so ohko move viable
	;else ai is slower so don't bother
	jp .heavydiscourage2
.skipout3	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote: static damage value moves should not be accounted for typing
;at the same time, randomly bump their preference to spice things up
	ld a, [wEnemyMovePower]	;get the base power of the enemy's attack
	cp $1	;check if it is 1. special damage moves assumed to have 1 base power
	jr nz, .skipout4	;skip down if it's not a special damage move
	call Random	;else get a random number between 0 and 255
	cp $40	
	jp c, .givepref	;(25% chance) slightly encourage
	jp .nextMove	;else neither encourage nor discourage
.skipout4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;jump if the move is not very effective or is super effective
	ld a, [wTypeEffectiveness]
	cp $0A
	jr c, .notEffectiveMove
	jr nz, .isSuperEffectiveMove
;move has neutral effectiveness at this line
.neutral_effective
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;since the type effectiveness is neutral, randomly apply slight preference if there is STAB	
	;25% chance to check for and prefer a stab move
	call Random
	cp 192
	jr c, .skipout5
	push bc
	ld a, [wEnemyMoveType]
	ld b, a
	ld a, [wEnemyMonType1]
	cp b
	pop bc
	jp z, .givepref
	push bc
	ld a, [wEnemyMoveType]
	ld b, a
	ld a, [wEnemyMonType2]
	cp b
	pop bc
	jp z, .givepref
.skipout5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if attack is < special and move is physical, slightly discourage
;if attack is > special and move is special, slightly discourage
;25% chance to enact this
	call Random
	cp 192
	jr c, .skipout6
	call StrCmpAtkSPA
	jr z, .skipout6	;jump if stats equal
	push af
	ld a, [wEnemyMoveType]
	cp FIRE
	jr nc, .special_move
.physical_move
	pop af
	jp c, .lightlydiscourage	;jump if attack < special
	jr .skipout6
.special_move
	pop af
	jp nc, .lightlydiscourage		;jump if special < attack
.skipout6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	jp .nextMove
.isSuperEffectiveMove
	;at this line, move is super effective
.givepref	;joenote - added marker
	dec [hl] ; slightly encourage this move
	jp .nextMove
.notEffectiveMove ; discourages non-effective moves if better moves are available 
	push hl
	push de
	push bc
	ld a, [wEnemyMoveType]
	ld d, a
	ld hl, wEnemyMonMoves  ; enemy moves
	ld b, NUM_MOVES + 1
	ld c, $0
.loopMoves
	dec b
	jr z, .done
	ld a, [hli]
	and a
	jr z, .done
	call ReadMove
	ld a, [wEnemyMoveEffect]
	cp SUPER_FANG_EFFECT
	jr z, .betterMoveFound ; Super Fang is considered to be a better move
	cp SPECIAL_DAMAGE_EFFECT
	jr z, .betterMoveFound ; any special damage moves are considered to be better moves
	cp FLY_EFFECT
	jr z, .betterMoveFound ; Fly is considered to be a better move
	ld a, [wEnemyMoveType]
	cp d
	jr z, .loopMoves
	ld a, [wEnemyMovePower]
	and a
	jr nz, .betterMoveFound ; damaging moves of a different type are considered to be better moves
	jr .loopMoves
.betterMoveFound
	ld c, a
.done
	ld a, c
	pop bc
	pop de
	pop hl
	and a
	jp z, .nextMove
	inc [hl] ; slightly discourage this move
	jp .nextMove

AIMoveChoiceModification4:
; BlueCloakAI move layer: strongly prefer real damaging super-effective moves.
; Status/zero-power moves are intentionally ignored here so their type never
; makes them look like attacking coverage.
	ld a, [wActionResultOrTookBattleTurn]
	and a
	ret nz
	ld hl, wBuffer - 1
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z
	inc hl
	ld a, [de]
	and a
	ret z
	inc de
	call ReadMove
	ld a, [wEnemyMovePower]
	and a
	jr z, .nextMove
	ld a, [wEnemyMoveEffect]
	cp SPECIAL_DAMAGE_EFFECT
	jr z, .nextMove
	push hl
	push de
	push bc
	callfar AIGetTypeEffectiveness
	pop bc
	pop de
	pop hl
	ld a, [wTypeEffectiveness]
	and a
	jr z, .immuneMove
	cp EFFECTIVE
	jr c, .resistedMove
	cp SUPER_EFFECTIVE
	jr nc, .superEffectiveMove
	ld a, [wEnemyMoveType]
	ld c, a
	ld a, [wEnemyMonType1]
	cp c
	jr z, .preferMove
	ld a, [wEnemyMonType2]
	cp c
	jr z, .preferMove
	jr .nextMove
.superEffectiveMove
	dec [hl]
.preferMove
	dec [hl]
	jr .nextMove
.immuneMove
	inc [hl]
	inc [hl]
	inc [hl]
.resistedMove
	inc [hl]
	inc [hl]
	jr .nextMove

ReadMove:
	push hl
	push de
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wEnemyMoveNum
	call CopyData
	pop bc
	pop de
	pop hl
	ret

StrCmpSpeed:
; wBattleMonSpeed vs wEnemyMonSpeed (big-endian). Carry set => enemy faster.
	push bc
	push de
	push hl
	ld de, wBattleMonSpeed
	ld hl, wEnemyMonSpeed
	ld c, $2
.spdcmploop
	ld a, [de]
	cp [hl]
	jr nz, .return
	inc de
	inc hl
	dec c
	jr nz, .spdcmploop
.return
	pop hl
	pop de
	pop bc
	ret

StrCmpAtkSPA:
	push bc
	push de
	push hl
	ld de, wEnemyMonAttack
	ld hl, wEnemyMonSpecial
	ld c, $2
.atkspaloop
	ld a, [de]
	cp [hl]
	jr nz, .atkspareturn
	inc de
	inc hl
	dec c
	jr nz, .atkspaloop
.atkspareturn
	pop hl
	pop de
	pop bc
	ret

IsDigOrFly:
	cp DIG
	ret z
	cp FLY
	ret
