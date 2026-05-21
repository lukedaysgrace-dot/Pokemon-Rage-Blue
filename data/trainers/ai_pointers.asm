TrainerAIPointers:
	table_width 3
	; one entry per trainer class
	; first byte, number of times (per Pokémon) it can occur
	; next two bytes, pointer to AI subroutine for trainer class
	; subroutines are defined in engine/battle/trainer_ai.asm
	dbw 3, AgathaAI        ; YOUNGSTER
	dbw 3, AgathaAI        ; BUG_CATCHER
	dbw 3, AgathaAI        ; LASS
	dbw 3, AgathaAI        ; SAILOR
	dbw 3, AgathaAI        ; JR_TRAINER_M
	dbw 3, AgathaAI        ; JR_TRAINER_F
	dbw 3, AgathaAI        ; POKEMANIAC
	dbw 3, AgathaAI        ; SUPER_NERD
	dbw 3, AgathaAI        ; HIKER
	dbw 3, AgathaAI        ; BIKER
	dbw 3, AgathaAI        ; BURGLAR
	dbw 3, AgathaAI        ; ENGINEER
	dbw 4, EliteFourAI     ; ARIANA
	dbw 3, AgathaAI        ; FISHER
	dbw 3, AgathaAI        ; SWIMMER
	dbw 3, AgathaAI        ; SWIMMER_F
	dbw 3, AgathaAI        ; CUE_BALL
	dbw 3, AgathaAI        ; GAMBLER
	dbw 3, AgathaAI        ; BEAUTY
	dbw 3, AgathaAI        ; PSYCHIC_TR
	dbw 3, AgathaAI        ; ROCKER
	dbw 4, CoolTrainerF    ; JUGGLER
	dbw 3, AgathaAI        ; TAMER
	dbw 3, AgathaAI        ; BIRD_KEEPER
	dbw 3, BlackbeltAI     ; BLACKBELT
	dbw 4, BlueAI          ; RIVAL1
	dbw 4, BlueAI          ; PROF_OAK
	dbw 4, AgathaAI        ; CHIEF
	dbw 3, AgathaAI        ; SCIENTIST
	dbw 4, EliteFourAI     ; GIOVANNI
	dbw 3, CooltrainerMAI  ; ROCKET
	dbw 4, CooltrainerMAI  ; COOLTRAINER_M
	dbw 4, CooltrainerFAI  ; COOLTRAINER_F
	dbw 4, EliteFourAI     ; BRUNO/KAREN
	dbw 4, EliteFourAI     ; BROCK
	dbw 4, EliteFourAI     ; MISTY
	dbw 4, EliteFourAI     ; LT_SURGE
	dbw 4, EliteFourAI     ; ERIKA
	dbw 4, EliteFourAI     ; KOGA
	dbw 4, EliteFourAI     ; BLAINE
	dbw 4, EliteFourAI     ; SABRINA
	dbw 4, CooltrainerFAI  ; GENTLEMAN
	dbw 4, BlueAI          ; RIVAL2
	dbw 4, BlueAI          ; RIVAL3
	dbw 4, EliteFourAI     ; LORELEI
	dbw 3, AgathaAI        ; CHANNELER
	dbw 4, EliteFourAI     ; AGATHA
	dbw 4, EliteFourAI     ; LANCE
	dbw 4, BlueAI          ; BLUE_CLOAK
	dbw 4, BlueAI          ; GREEN
	dbw 4, BlueAI          ; GREEN_ROCKET
	dbw 4, CooltrainerMAI  ; NINJA
	dbw 4, EliteFourAI     ; JANINE
	dbw 4, EliteFourAI     ; PETREL
	dbw 4, EliteFourAI     ; PROTON
	dbw 4, BlueAI          ; ARCHER
	dbw 4, CooltrainerMAI  ; SOLDIER
	dbw 3, CooltrainerMAI  ; ROCKET_F
IF DEF(_BLUE)
	dbw 4, EliteFourAI     ; EXILE_BRUNO
ENDC
	assert_table_length NUM_TRAINERS
