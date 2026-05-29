; Custom trainer moves — applied at end of ReadTrainer (after LoneMoves / TeamMoves / champion patches).
;
; Table format (see custom_trainer_moves_table.asm):
;   db CLASS, wTrainerNo, party_slot (1–6), move, move, move, move
;   … then db $ff
; Use trainer class constants (BROCK, RIVAL1, …), not OPP_*.
;
; Party data matches the active version's party file:
;   _RED  -> data/trainers/parties_red.asm
;   _BLUE -> data/trainers/parties_blue.asm
; Moves were filled with Gen 1 level-up sets (base_stats level-1 moves +
; evos_moves.asm), same rules as WriteMonMoves. Edit the matching version table:
;   data/trainers/custom_trainer_moves_table_red.asm
;   data/trainers/custom_trainer_moves_table_blue.asm
;
; Note: These rows replace vanilla post-build patches, including Lorelei’s TeamMoves
; (e.g. Lapras slot-3 Blizzard) and the champion rival’s Sky Attack / starter TM slot.
;
; Linked in SECTION "Custom Trainer Moves Data" (bank $2C) after the table: same ROM
; bank as CustomTrainerMoves, so no rROMB change here. Invoked via farcall from ReadTrainer.

ApplyCustomTrainerMoves:
	ld hl, CustomTrainerMoves
.recordLoop
	ld a, [hli]
	cp $ff
	ret z
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld d, a

	ld a, [wCurOpponent]
	sub OPP_ID_OFFSET
	cp b
	jr nz, .skipFourMoves
	ld a, c
	and a
	jr z, .trainerOk
	ld a, [wTrainerNo]
	cp c
	jr nz, .skipFourMoves
.trainerOk
	ld a, d
	and a
	jr z, .skipFourMoves
	cp PARTY_LENGTH + 1
	jr nc, .skipFourMoves

	push hl
	ld a, d
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wEnemyMon1Moves
	call AddNTimes
	push hl
	pop de
	pop hl
	push de
	ld b, NUM_MOVES
.copyMoveLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copyMoveLoop
	pop de
	push hl
	call RefreshCustomTrainerMonMovePP
	pop hl
	jr .recordLoop

.skipFourMoves
	ld bc, NUM_MOVES
	add hl, bc
	jr .recordLoop

RefreshCustomTrainerMonMovePP:
; de = wEnemyMonNMoves (same layout as AddPartyMon_WriteMovePP: hl moves, de starts one below PP[0])
	ld h, d
	ld l, e
	push hl
	ld bc, MON_PP - MON_MOVES - 1
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld b, NUM_MOVES
.ppLoop
	ld a, [hli]
	and a
	jr z, .ppEmpty
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
	jr .ppWrite
.ppEmpty
	xor a
.ppWrite
	inc de
	ld [de], a
	dec b
	jr nz, .ppLoop
	ret
