; Used by GetMoveGrammar (see engine/battle/core.asm)
; Each move is given an identifier for what usedmovetext to use (0-4).
; Made redundant in English localization, where all are just "[mon]<LINE>used [move]!"

MoveGrammar:
; 0: originally "[mon]は<LINE>[move]を　つかった！" ("[mon]<LINE>used [move]!")
	db SWORDS_DANCE
	db GROWTH
	db 0 ; end set

; 1: originally "[mon]は<LINE>[move]を　した！" ("[mon]<LINE>did [move]!")
	db RECOVER
	db BIDE
	db SELFDESTRUCT
	db AMNESIA
	db 0 ; end set

; 2: originally "[mon]は<LINE>[move]した！" ("[mon]<LINE>did [move]!")
	db MEDITATE
	db AGILITY
	db TELEPORT
	db MIMIC
	db DOUBLE_TEAM
	db BARRAGE
	db 0 ; end set

; 3: originally "[mon]の<LINE>[move]　こうげき！" ("[mon]'s<LINE>[move] attack!")
	db TACKLE
	db SCRATCH
	db VICEGRIP
	db WING_ATTACK
	db STEEL_WING
	db FLY
	db SHADOW_BALL
	db SLAM
	db HORN_ATTACK
	db BODY_SLAM
	db WRAP
	db THRASH
	db OUTRAGE
	db TAIL_WHIP
	db LEER
	db BITE
	db CRUNCH
	db BUG_BITE
	db GROWL
	db MACH_PUNCH
	db SING
	db PECK
	db COUNTER
	db STRENGTH
	db ABSORB
	db STRING_SHOT
	db EARTHQUAKE
	db FISSURE
	db DIG
	db TOXIC
	db SCREECH
	db HARDEN
	db MINIMIZE
	db WITHDRAW
	db DEFENSE_CURL
	db METRONOME
	db LICK
	db CLAMP
	db CONSTRICT
	db FLAME_WHEEL
	db LEECH_LIFE
	db BUBBLE
	db FLASH
	db IRON_TAIL
	db ACID_ARMOR
	db FURY_SWIPES
	db REST
	db METAL_CLAW
	db SLASH
	db X_SCISSOR
	db DRAGON_CLAW
	db THUNDER_FANG
	db ACCELEROCK
	db STONE_EDGE
	db SUBSTITUTE
	db FOCUS_ENERGY
	db 0 ; end set

; 4: originally "[mon]の<LINE>[move]!" ("[mon]'s<LINE>[move]!")
; Any move not listed above uses this grammar.
	db -1 ; end
