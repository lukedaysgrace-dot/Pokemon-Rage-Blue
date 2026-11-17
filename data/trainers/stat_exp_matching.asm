TrainerStatExpMatchingPolicy:
; Hard Mode: class, bonus in floor(min(255, ceil(sqrt(Stat EXP))) / 4).
; Match each stat's highest word in the player's party, including fainted
; members. Important characters get two extra training points (max 63).
; Cooltrainers copy the raw words exactly, without a bonus.
	db BROCK, 2
	db MISTY, 2
	db LT_SURGE, 2
	db ERIKA, 2
	db KOGA, 2
	db SABRINA, 2
	db BLAINE, 2
	db GIOVANNI, 2
	db LORELEI, 2
	db BRUNO, 2
	db AGATHA, 2
	db LANCE, 2
	db RIVAL1, 2
	db RIVAL2, 2
	db RIVAL3, 2
	db GREEN, 2
	db GREEN_ROCKET, 2
	db BLUE_CLOAK, 2
	db JANINE, 2
	db ARIANA, 2
	db PETREL, 2
	db PROTON, 2
	db ARCHER, 2
	db PROF_OAK, 2
	db COOLTRAINER_M, 0
	db COOLTRAINER_F, 0
	db -1
