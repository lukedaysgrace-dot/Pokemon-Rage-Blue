_AddPartyMon::
; Adds a new mon to the player's or enemy's party.
; [wMonDataLocation] is used in an unusual way in this function.
; If the lower nybble is 0, the mon is added to the player's party, else the enemy's.
; If the entire value is 0, then the player is allowed to name the mon.
	ld de, wPartyCount
	ld a, [wMonDataLocation]
	and $f
	jr z, .next
	ld de, wEnemyPartyCount
.next
	ld a, [de]
	inc a
	cp PARTY_LENGTH + 1
	ret nc ; return if the party is already full
	ld [de], a
	ld a, [de]
	ldh [hNewPartyLength], a
	add e
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
	ld a, [wCurPartySpecies]
	ld [de], a ; write species of new mon in party list
	inc de
	ld a, $ff ; terminator
	ld [de], a
	ld hl, wPartyMonOT
	ld a, [wMonDataLocation]
	and $f
	jr z, .next2
	ld hl, wEnemyMonOT
.next2
	ldh a, [hNewPartyLength]
	dec a
	call SkipFixedLengthTextEntries
	ld d, h
	ld e, l
	ld hl, wPlayerName
	ld bc, NAME_LENGTH
	call CopyData
	ld a, [wMonDataLocation]
	and a
	jr nz, .skipNaming
	ld hl, wPartyMonNicks
	ldh a, [hNewPartyLength]
	dec a
	call SkipFixedLengthTextEntries
	ld a, NAME_MON_SCREEN
	ld [wNamingScreenType], a
	predef AskName
.skipNaming
	ld hl, wPartyMons
	ld a, [wMonDataLocation]
	and $f
	jr z, .next3
	ld hl, wEnemyMons
.next3
	ldh a, [hNewPartyLength]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld e, l
	ld d, h
	push hl
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetMonHeader
	ld hl, wMonHeader
	ld a, [hli]
	ld [de], a ; species
	inc de
	pop hl
	push hl
	ld a, [wMonDataLocation]
	and $f
	jr z, .playerPartyDVs
; Enemy party (ReadTrainer): use the same perfect vs average split as LoadEnemyMonData,
; or party HP/max mismatch makes full-health mons look damaged when sent out.
	ld a, [wTrainerClass]
	cp RIVAL1
	jr z, .enemyPerfectDVs
	cp RIVAL2
	jr z, .enemyPerfectDVs
	cp RIVAL3
	jr z, .enemyPerfectDVs
	cp BLUE_CLOAK
	jr z, .enemyPerfectDVs
	cp GREEN
	jr z, .enemyPerfectDVs
	cp GREEN_ROCKET
	jr z, .enemyPerfectDVs
	cp GIOVANNI
	jr z, .enemyPerfectDVs
	cp JANINE
	jr z, .enemyPerfectDVs
	cp ARIANA
	jr z, .enemyPerfectDVs
	cp PETREL
	jr z, .enemyPerfectDVs
	cp PROTON
	jr z, .enemyPerfectDVs
	cp ARCHER
	jr z, .enemyPerfectDVs
	cp PROF_OAK
	jr z, .enemyPerfectDVs
	cp KAREN
	jr c, .enemyAverageDVs
	cp SABRINA + 1 ; Bruno–Sabrina: gym leaders
	jr c, .enemyPerfectDVs
	cp LORELEI
	jr z, .enemyPerfectDVs
	cp AGATHA
	jr z, .enemyPerfectDVs
	cp LANCE
	jr z, .enemyPerfectDVs
IF DEF(_BLUE)
	cp EXILE_BRUNO
	jr z, .enemyPerfectDVs
ENDC
.enemyAverageDVs
	ld a, ATKDEFDV_TRAINER
	ld b, SPDSPCDV_TRAINER
	jr .next4
.enemyPerfectDVs
	ld a, PERFECT_DV_BYTE
	ld b, PERFECT_DV_BYTE
	jr .next4

; If the mon is being added to the player's party, update the pokedex.
.playerPartyDVs
	ld a, [wCurPartySpecies]
	ld [wPokedexNum], a
	push de
	predef IndexToPokedex
	pop de
	ld a, [wPokedexNum]
	dec a
	ld c, a
	ld b, FLAG_TEST
	ld hl, wPokedexOwned
	call FlagAction
	ld a, c ; whether the mon was already flagged as owned
	ld [wUnusedAlreadyOwnedFlag], a
	ld a, [wPokedexNum]
	dec a
	ld c, a
	ld b, FLAG_SET
	push bc
	call FlagAction
	pop bc
	ld hl, wPokedexSeen
	call FlagAction

	pop hl
	push hl

	ld a, [wIsInBattle]
	and a ; is this a wild mon caught in battle?
	jr nz, .copyEnemyMonData

; Not wild.
	ld a, PERFECT_DV_BYTE
	ld b, PERFECT_DV_BYTE

.next4
	push bc
	ld bc, MON_DVS
	add hl, bc
	pop bc
	ld [hli], a
	ld [hl], b         ; write IVs
	ld bc, (MON_HP_EXP - 1) - (MON_DVS + 1)
	add hl, bc
	ld c, 1
	xor a
	ld b, a
.calcInitialHP
	call CalcStat      ; calc HP stat (set cur Hp to max HP)
	ldh a, [hMultiplicand+1]
	ld [de], a
	inc de
	ldh a, [hMultiplicand+2]
	ld [de], a
	inc de
	xor a
	ld [de], a         ; box level
	inc de
	ld [de], a         ; status ailments
	inc de
	jr .copyMonTypesAndMoves
.copyEnemyMonData
	ld bc, MON_DVS
	add hl, bc
	ld a, [wMonDataLocation]
	and $f
	jr nz, .copyEnemyBattleDVs
	ld a, PERFECT_DV_BYTE
	ld [hli], a
	ld [hl], a
	jr .copyEnemyMonHPStatus
.copyEnemyBattleDVs
	ld a, [wEnemyMonDVs]
	ld [hli], a
	ld a, [wEnemyMonDVs + 1]
	ld [hl], a
.copyEnemyMonHPStatus
	ld a, [wEnemyMonHP]    ; copy HP from cur enemy mon
	ld [de], a
	inc de
	ld a, [wEnemyMonHP+1]
	ld [de], a
	inc de
	xor a
	ld [de], a                ; box level
	inc de
	ld a, [wEnemyMonStatus]   ; copy status ailments from cur enemy mon
	ld [de], a
	inc de
.copyMonTypesAndMoves
	ld hl, wMonHTypes
	ld a, [hli]       ; type 1
	ld [de], a
	inc de
	ld a, [hli]       ; type 2
	ld [de], a
	inc de
	ld a, [hli]       ; catch rate (held item in gen 2)
	ld [de], a
	ld hl, wMonHMoves
	ld a, [hli]
	inc de
	push de
	ld [de], a
	ld a, [hli]
	inc de
	ld [de], a
	ld a, [hli]
	inc de
	ld [de], a
	ld a, [hli]
	inc de
	ld [de], a
	push de
	dec de
	dec de
	dec de
	xor a
	ld [wLearningMovesFromDayCare], a
	predef WriteMonMoves
	pop de
	ld a, [wPlayerID]  ; set trainer ID to player ID
	inc de
	ld [de], a
	ld a, [wPlayerID + 1]
	inc de
	ld [de], a
	push de
	ld a, [wCurEnemyLevel]
	ld d, a
	callfar CalcExperience
	pop de
	inc de
	ldh a, [hExperience] ; write experience
	ld [de], a
	inc de
	ldh a, [hExperience + 1]
	ld [de], a
	inc de
	ldh a, [hExperience + 2]
	ld [de], a
	ld a, [wMonDataLocation]
	and $f
	jp z, .zeroStatExp
	; Enemy trainer Stat EXP presets.
	; Default: 0 (vanilla behavior). Specific trainer classes/rows override.
	xor a
	ld b, a ; hi byte
	ld c, a ; lo byte

	; Blue Cloak (Cinnabar) should be strong but not perfect: 0x8000 each stat.
	ld a, [wTrainerClass]
	cp BLUE_CLOAK
	jr nz, .checkPalletGreenStatExp
	ld b, $80
	ld c, $00
	jp .writeTrainerStatExp

.checkPalletGreenStatExp
	; Pallet Town postgame Green is wTrainerNo 13-15: 0x6666 each stat.
	ld a, [wTrainerClass]
	cp GREEN
	jp nz, .checkGreenOtherFightsStatExp
	ld a, [wTrainerNo]
	cp 13
	jr c, .checkGreenOtherFightsStatExp
	cp 16
	jr nc, .checkGreenOtherFightsStatExp
	ld b, $66
	ld c, $66
	jp .writeTrainerStatExp

.checkGreenOtherFightsStatExp
	; Green fights:
	; - Route 5 / Route 10 (wTrainerNo 1–6): 10% -> 0x199A (6554)
	; - Cinnabar Mansion / Indigo Plateau (wTrainerNo 7–12): 15% -> 0x2666 (9830)
	; (Pallet Town is handled above as a special case wTrainerNo 13–15.)
	ld a, [wTrainerClass]
	cp GREEN
	jr nz, .checkGreenRocketStatExp
	ld a, [wTrainerNo]
	cp 7
	jr c, .setGreenTenPercent
	cp 13
	jr c, .setGreenFifteenPercent
	jp .maybeZeroTrainerStatExp
.setGreenTenPercent
	ld b, $19
	ld c, $9a
	jp .writeTrainerStatExp
.setGreenFifteenPercent
	ld b, $26
	ld c, $66
	jp .writeTrainerStatExp

.checkGreenRocketStatExp
	; Rocket Hideout Green uses GREEN_ROCKET: treat as 10% -> 0x199A.
	ld a, [wTrainerClass]
	cp GREEN_ROCKET
	jr nz, .checkGymLeadersEarlyStatExp
	ld b, $19
	ld c, $9a
	jp .writeTrainerStatExp

.checkGymLeadersEarlyStatExp
	; Brock/Misty/Lt. Surge/Erika: 0x0CD0 each stat, but rematch (wTrainerNo 2) uses 0x4CCD.
	ld a, [wTrainerClass]
	cp BROCK
	jr z, .gymLeaderEarlyMaybeRematch
	cp MISTY
	jr z, .gymLeaderEarlyMaybeRematch
	cp LT_SURGE
	jr z, .gymLeaderEarlyMaybeRematch
	cp ERIKA
	jr z, .gymLeaderEarlyMaybeRematch
	jr .checkGymLeadersLateStatExp

.gymLeaderEarlyMaybeRematch
	ld a, [wTrainerNo]
	cp 2
	jp z, .setRematchStatExp
	ld b, $0c
	ld c, $d0
	jp .writeTrainerStatExp

.checkGymLeadersLateStatExp
	; Koga/Sabrina/Blaine: 0x199A each stat, but rematch (wTrainerNo 2) uses 0x4CCD.
	; Giovanni: 0x199A for story fights (wTrainerNo 1–3), rematch is wTrainerNo 4 -> 0x4CCD.
	ld a, [wTrainerClass]
	cp KOGA
	jr z, .gymLeaderLateMaybeRematch2
	cp SABRINA
	jr z, .gymLeaderLateMaybeRematch2
	cp BLAINE
	jr z, .gymLeaderLateMaybeRematch2
	cp GIOVANNI
	jr z, .giovanniMaybeRematch4
	jr .checkRocketExecsStatExp

.gymLeaderLateMaybeRematch2
	ld a, [wTrainerNo]
	cp 2
	jp z, .setRematchStatExp
	ld b, $19
	ld c, $9a
	jp .writeTrainerStatExp

.giovanniMaybeRematch4
	ld a, [wTrainerNo]
	cp 4
	jp z, .setRematchStatExp
	ld b, $19
	ld c, $9a
	jp .writeTrainerStatExp

.checkRocketExecsStatExp
	; Janine / Rocket executives: ~10% of max Stat EXP -> 0x199A (~6554) each stat.
	ld a, [wTrainerClass]
	cp JANINE
	jr z, .setRocketExecStatExp
	cp PETREL
	jr z, .setRocketExecStatExp
	cp PROTON
	jr z, .setRocketExecStatExp
	cp ARIANA
	jr z, .setRocketExecStatExp
	cp ARCHER
	jr z, .setRocketExecStatExp
	jr .checkRival2MidgameStatExp

.setRocketExecStatExp
	ld b, $19
	ld c, $9a
	jp .writeTrainerStatExp

.checkRival2MidgameStatExp
	; Rival midgame fights (RIVAL2):
	; - Cerulean / SS Anne / Pokémon Tower (wTrainerNo 1–6): 10% -> 0x199A (6554)
	; - Silph Co / late Route 22 (wTrainerNo 7–12): 15% -> 0x2666 (9830)
	ld a, [wTrainerClass]
	cp RIVAL2
	jr nz, .checkEliteFourAndChampionStatExp
	ld a, [wTrainerNo]
	cp 7
	jr c, .setRival2TenPercent
	ld b, $26
	ld c, $66
	jp .writeTrainerStatExp
.setRival2TenPercent
	ld b, $19
	ld c, $9a
	jp .writeTrainerStatExp

.checkEliteFourAndChampionStatExp
	; Elite Four + Champion:
	; - Elite Four (wTrainerNo 1): 0x3333 each stat; rematch (wTrainerNo 2): 0x4CCD.
	; - Champion rival (RIVAL3 wTrainerNo 1–3): 0x3333; rematch (wTrainerNo 4–6): 0x4CCD.
	ld a, [wTrainerClass]
	cp LORELEI
	jr z, .eliteFourMaybeRematch2
	cp BRUNO
	jr z, .eliteFourMaybeRematch2
	cp AGATHA
	jr z, .eliteFourMaybeRematch2
	cp LANCE
	jr z, .eliteFourMaybeRematch2
	cp RIVAL3
	jr z, .championRivalMaybeRematch456
IF DEF(_BLUE)
	jp .checkExileBrunoStatExp
ELSE
	jp .checkProfOakStatExp
ENDC

.eliteFourMaybeRematch2
	ld a, [wTrainerNo]
	cp 2
	jp z, .setRematchStatExp
	ld b, $33
	ld c, $33
	jp .writeTrainerStatExp

.championRivalMaybeRematch456
	ld a, [wTrainerNo]
	cp 4
	jp nc, .setRematchStatExp
	ld b, $33
	ld c, $33
	jp .writeTrainerStatExp

IF DEF(_BLUE)
.checkExileBrunoStatExp
	; Exile Bruno (Cerulean Cave): 40% of max Stat EXP -> 0x6666 each stat.
	ld a, [wTrainerClass]
	cp EXILE_BRUNO
	jp nz, .checkProfOakStatExp
	ld b, $66
	ld c, $66
	jp .writeTrainerStatExp
ENDC

.checkProfOakStatExp
	; Route 1 dex reward: 45% of max Stat EXP -> 0x7333 (~29491) each stat.
	ld a, [wTrainerClass]
	cp PROF_OAK
	jp nz, .maybeZeroTrainerStatExp
	ld b, $73
	ld c, $33
	jp .writeTrainerStatExp

.setRematchStatExp
	; Rematches (gym leaders + Elite Four + Champion rematch): 0x4CCD each stat.
	ld b, $4c
	ld c, $cd
	jp .writeTrainerStatExp

.maybeZeroTrainerStatExp
	ld a, b
	or c
	jr z, .zeroStatExp

.writeTrainerStatExp
	; Write bc (hi/lo) to all Stat EXP fields.
	ld h, b
	ld l, c
	ld b, NUM_STATS
.writeTrainerStatExpLoop
	inc de
	ld a, h
	ld [de], a
	inc de
	ld a, l
	ld [de], a
	dec b
	jr nz, .writeTrainerStatExpLoop
	jr .statExpDone
.zeroStatExp
	xor a
	ld b, NUM_STATS * 2
.writeZeroStatExpLoop      ; set all stat exp to 0
	inc de
	ld [de], a
	dec b
	jr nz, .writeZeroStatExpLoop
.statExpDone
	inc de
	inc de
	pop hl
	call AddPartyMon_WriteMovePP
	inc de
	ld a, [wCurEnemyLevel]
	ld [de], a
	inc de
	pop hl
	push hl
	ld bc, MON_HP_EXP - 1
	add hl, bc
	ld b, $0
	ld a, [wMonDataLocation]
	and $f
	jr z, .calcStatsDone
	inc b
.calcStatsDone
	call CalcStats
	pop hl
	ld a, [wMonDataLocation]
	and $f
	jr z, .done
	ld bc, MON_MAXHP
	add hl, bc
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld e, a
	ld bc, MON_HP - (MON_MAXHP + 1)
	add hl, bc
	ld [hl], d
	inc hl
	ld [hl], e
.done
	scf
	ret

LoadMovePPs:
	call GetPredefRegisters
	; fallthrough
AddPartyMon_WriteMovePP:
	ld b, NUM_MOVES
.pploop
	ld a, [hli]     ; read move ID
	and a
	jr z, .empty
	dec a
	push hl
	push de
	push bc
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wMoveData
	ld a, BANK(Moves)
	call FarCopyData
	pop bc
	pop de
	pop hl
	ld a, [wMoveData + MOVE_PP]
.empty
	inc de
	ld [de], a
	dec b
	jr nz, .pploop ; there are still moves to read
	ret

; adds enemy mon [wCurPartySpecies] (at position [wWhichPokemon] in enemy list) to own party
; used in the cable club trade center
_AddEnemyMonToPlayerParty::
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	scf
	ret z            ; party full, return failure
	inc a
	ld [hl], a       ; add 1 to party members
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [wCurPartySpecies]
	ld [hli], a      ; add mon as last list entry
	ld [hl], $ff     ; write new sentinel
	ld hl, wPartyMons
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld e, l
	ld d, h
	push de
	ld hl, wLoadedMon
	call CopyData    ; write new mon's data (from wLoadedMon)
	pop hl
	ld b, h
	ld c, l
	ld a, [bc]
	ld [wCurSpecies], a
	call GetMonHeader
	ld h, b
	ld l, c
	ld bc, MON_DVS
	add hl, bc
	ld a, PERFECT_DV_BYTE
	ld [hli], a
	ld [hl], a
	ld h, b
	ld l, c
	ld bc, MON_HP_EXP - 1
	add hl, bc
	ld b, $0
	call CalcStats
	ld hl, wPartyMonOT
	ld a, [wPartyCount]
	dec a
	call SkipFixedLengthTextEntries
	ld d, h
	ld e, l
	ld hl, wEnemyMonOT
	ld a, [wWhichPokemon]
	call SkipFixedLengthTextEntries
	ld bc, NAME_LENGTH
	call CopyData    ; write new mon's OT name (from an enemy mon)
	ld hl, wPartyMonNicks
	ld a, [wPartyCount]
	dec a
	call SkipFixedLengthTextEntries
	ld d, h
	ld e, l
	ld hl, wEnemyMonNicks
	ld a, [wWhichPokemon]
	call SkipFixedLengthTextEntries
	ld bc, NAME_LENGTH
	call CopyData    ; write new mon's nickname (from an enemy mon)
	ld a, [wCurPartySpecies]
	ld [wPokedexNum], a
	predef IndexToPokedex
	ld a, [wPokedexNum]
	dec a
	ld c, a
	ld b, FLAG_SET
	ld hl, wPokedexOwned
	push bc
	call FlagAction ; add to owned pokemon
	pop bc
	ld hl, wPokedexSeen
	call FlagAction ; add to seen pokemon
	and a
	ret                  ; return success

_MoveMon::
	ld a, [wMoveMonType]
	and a   ; BOX_TO_PARTY
	jr z, .checkPartyMonSlots
	cp DAYCARE_TO_PARTY
	jr z, .checkPartyMonSlots
	cp PARTY_TO_DAYCARE
	ld hl, wDayCareMon
	jr z, .findMonDataSrc
	; else it's PARTY_TO_BOX
	ld hl, wBoxCount
	ld a, [hl]
	cp MONS_PER_BOX
	jr nz, .partyOrBoxNotFull
	jr .boxFull
.checkPartyMonSlots
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	jr nz, .partyOrBoxNotFull
.boxFull
	scf
	ret
.partyOrBoxNotFull
	inc a
	ld [hl], a           ; increment number of mons in party/box
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wMoveMonType]
	cp DAYCARE_TO_PARTY
	ld a, [wDayCareMon]
	jr z, .copySpecies
	ld a, [wCurPartySpecies]
.copySpecies
	ld [hli], a          ; write new mon ID
	ld [hl], $ff         ; write new sentinel
; find mon data dest
	ld a, [wMoveMonType]
	dec a
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wPartyCount]
	jr nz, .addMonOffset
	; if it's PARTY_TO_BOX
	ld hl, wBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, [wBoxCount]
.addMonOffset
	dec a
	call AddNTimes
.findMonDataSrc
	push hl
	ld e, l
	ld d, h
	ld a, [wMoveMonType]
	and a
	ld hl, wBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	jr z, .addMonOffset2
	cp DAYCARE_TO_PARTY
	ld hl, wDayCareMon
	jr z, .copyMonData
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
.addMonOffset2
	ld a, [wWhichPokemon]
	call AddNTimes
.copyMonData
	push hl
	push de
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyData
	pop de
	pop hl
	ld a, [wMoveMonType]
	and a ; BOX_TO_PARTY
	jr z, .findOTdest
	cp DAYCARE_TO_PARTY
	jr z, .findOTdest
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	ld a, [hl] ; hl = Level
	inc de
	inc de
	inc de
	ld [de], a ; de = BoxLevel
.findOTdest
	ld a, [wMoveMonType]
	cp PARTY_TO_DAYCARE
	ld de, wDayCareMonOT
	jr z, .findOTsrc
	dec a
	ld hl, wPartyMonOT
	ld a, [wPartyCount]
	jr nz, .addOToffset
	ld hl, wBoxMonOT
	ld a, [wBoxCount]
.addOToffset
	dec a
	call SkipFixedLengthTextEntries
	ld d, h
	ld e, l
.findOTsrc
	ld hl, wBoxMonOT
	ld a, [wMoveMonType]
	and a
	jr z, .addOToffset2
	ld hl, wDayCareMonOT
	cp DAYCARE_TO_PARTY
	jr z, .copyOT
	ld hl, wPartyMonOT
.addOToffset2
	ld a, [wWhichPokemon]
	call SkipFixedLengthTextEntries
.copyOT
	ld bc, NAME_LENGTH
	call CopyData
	ld a, [wMoveMonType]
; find nick dest
	cp PARTY_TO_DAYCARE
	ld de, wDayCareMonName
	jr z, .findNickSrc
	dec a
	ld hl, wPartyMonNicks
	ld a, [wPartyCount]
	jr nz, .addNickOffset
	ld hl, wBoxMonNicks
	ld a, [wBoxCount]
.addNickOffset
	dec a
	call SkipFixedLengthTextEntries
	ld d, h
	ld e, l
.findNickSrc
	ld hl, wBoxMonNicks
	ld a, [wMoveMonType]
	and a
	jr z, .addNickOffset2
	ld hl, wDayCareMonName
	cp DAYCARE_TO_PARTY
	jr z, .copyNick
	ld hl, wPartyMonNicks
.addNickOffset2
	ld a, [wWhichPokemon]
	call SkipFixedLengthTextEntries
.copyNick
	ld bc, NAME_LENGTH
	call CopyData
	pop hl
	ld a, [wMoveMonType]
	cp PARTY_TO_BOX
	jr z, .done
	cp PARTY_TO_DAYCARE
	jr z, .done
	; returning mon to party, compute level and stats
	push hl
	srl a
	add $2
	ld [wMonDataLocation], a
	call LoadMonData
	farcall CalcLevelFromExperience
	ld a, d
	ld [wCurEnemyLevel], a
	pop hl
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc ; hl = wPartyMon*Level
	ld [hli], a
	ld d, h
	ld e, l
	ld bc, (MON_HP_EXP - 1) - MON_STATS
	add hl, bc ; hl = wPartyMon*HPExp - 1
	ld b, $1
	call CalcStats
.done
	and a
	ret
