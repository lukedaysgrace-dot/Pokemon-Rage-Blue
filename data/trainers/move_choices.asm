DEF __move_choices__ = 0

MACRO move_choices
	IF _NARG
		db \# ; all args
	ENDC
	db 0 ; end
	DEF __move_choices__ += 1
ENDM

; move choice modification methods that are applied for each trainer class
; (Phase 1: expanded layers 1–3 from Shin Pokémon Red; layer 4 reserved for future switching AI)
TrainerClassMoveChoiceModifications:
	move_choices 1       ; YOUNGSTER
	move_choices 1, 2    ; BUG CATCHER
	move_choices 1, 2    ; LASS
	move_choices 1, 3    ; SAILOR
	move_choices 1, 3    ; JR_TRAINER_M
	move_choices 1, 3    ; JR_TRAINER_F
	move_choices 1, 2, 3 ; POKEMANIAC
	move_choices 1, 3    ; SUPER_NERD
	move_choices 1, 2    ; HIKER
	move_choices 1, 2    ; BIKER
	move_choices 1, 3    ; BURGLAR
	move_choices 1, 3    ; ENGINEER
	move_choices 1, 2, 3 ; ARIANA
	move_choices 1, 3    ; FISHER
	move_choices 1, 3    ; SWIMMER
	move_choices 1, 3    ; SWIMMER_F
	move_choices 1, 3    ; CUE_BALL
	move_choices 1, 3    ; GAMBLER
	move_choices 1, 3    ; BEAUTY
	move_choices 1, 3    ; PSYCHIC_TR
	move_choices 1, 3    ; ROCKER
	move_choices 1, 3    ; JUGGLER
	move_choices 1, 3    ; TAMER
	move_choices 1, 3    ; BIRD_KEEPER
	move_choices 1, 3    ; BLACKBELT
	move_choices 1, 2, 3 ; RIVAL1
	move_choices 1, 2, 3 ; PROF_OAK
	move_choices 1, 2, 3 ; CHIEF
	move_choices 1, 2, 3 ; SCIENTIST
	move_choices 1, 3, 4 ; GIOVANNI
	move_choices 1, 3    ; ROCKET
	move_choices 1, 2, 3 ; COOLTRAINER_M
	move_choices 1, 2, 3 ; COOLTRAINER_F
	move_choices 1, 3, 4 ; KAREN
	move_choices 1, 3, 4 ; BROCK
	move_choices 1, 3, 4 ; MISTY
	move_choices 1, 3, 4 ; LT_SURGE
	move_choices 1, 3, 4 ; ERIKA
	move_choices 1, 3, 4 ; KOGA
	move_choices 1, 3, 4 ; BLAINE
	move_choices 1, 3, 4 ; SABRINA
	move_choices 1, 2, 3 ; GENTLEMAN
	move_choices 1, 2, 3 ; RIVAL2
	move_choices 1, 2, 3 ; RIVAL3
	move_choices 1, 3, 4 ; LORELEI
	move_choices 1, 3    ; CHANNELER
	move_choices 1, 3, 4 ; AGATHA
	move_choices 1, 3, 4 ; LANCE
	move_choices 1, 3, 4 ; BLUE_CLOAK
	move_choices 1, 2, 3 ; GREEN
	move_choices 1, 2, 3 ; GREEN_ROCKET
	move_choices 1, 2, 3 ; NINJA
	move_choices 1, 3, 4 ; JANINE
	move_choices 1, 2, 3 ; PETREL
	move_choices 1, 2, 3 ; PROTON
	move_choices 1, 2, 3 ; ARCHER
	move_choices 1, 3    ; SOLDIER
	assert __move_choices__ == NUM_TRAINERS, \
		"TrainerClassMoveChoiceModifications: expected {d:NUM_TRAINERS} entries, got {d:__move_choices__}"
