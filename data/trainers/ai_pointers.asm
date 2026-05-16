TrainerAIPointers:
	table_width 3
	; one entry per trainer class
	; first byte, number of times (per Pokémon) it can occur
	; next two bytes, pointer to AI subroutine for trainer class
	; subroutines are defined in engine/battle/trainer_ai.asm
	dbw 3, GenericAI       ; YOUNGSTER
	dbw 3, GenericAI       ; BUG_CATCHER
	dbw 3, GenericAI       ; LASS
	dbw 3, GenericAI       ; SAILOR
	dbw 3, GenericAI       ; JR_TRAINER_M
	dbw 3, GenericAI       ; JR_TRAINER_F
	dbw 3, GenericAI       ; POKEMANIAC
	dbw 3, GenericAI       ; SUPER_NERD
	dbw 3, GenericAI       ; HIKER
	dbw 3, GenericAI       ; BIKER
	dbw 3, GenericAI       ; BURGLAR
	dbw 3, GenericAI       ; ENGINEER
	dbw 4, BlueAI          ; ARIANA
	dbw 3, GenericAI       ; FISHER
	dbw 3, GenericAI       ; SWIMMER
	dbw 3, GenericAI       ; SWIMMER_F
	dbw 3, GenericAI       ; CUE_BALL
	dbw 3, GenericAI       ; GAMBLER
	dbw 3, GenericAI       ; BEAUTY
	dbw 3, GenericAI       ; PSYCHIC_TR
	dbw 3, GenericAI       ; ROCKER
	dbw 4, JugglerAI       ; JUGGLER
	dbw 3, GenericAI       ; TAMER
	dbw 3, GenericAI       ; BIRD_KEEPER
	dbw 3, BlackbeltAI     ; BLACKBELT
	dbw 4, BlueAI          ; RIVAL1
	dbw 4, BlueAI          ; PROF_OAK
	dbw 4, GenericAI       ; CHIEF
	dbw 3, GenericAI       ; SCIENTIST
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
	dbw 4, CooltrainerMAI  ; GENTLEMAN
	dbw 4, BlueAI          ; RIVAL2
	dbw 4, BlueAI          ; RIVAL3
	dbw 4, EliteFourAI     ; LORELEI
	dbw 3, GenericAI       ; CHANNELER
	dbw 4, EliteFourAI     ; AGATHA
	dbw 4, EliteFourAI     ; LANCE
	dbw 4, BlueCloakAI     ; BLUE_CLOAK
	dbw 4, BlueAI          ; GREEN
	dbw 4, BlueAI          ; GREEN_ROCKET
	dbw 4, CooltrainerMAI  ; NINJA
	dbw 4, EliteFourAI     ; JANINE
	dbw 4, EliteFourAI     ; PETREL
	dbw 4, EliteFourAI     ; PROTON
	dbw 4, BlueAI          ; ARCHER
	dbw 4, CooltrainerMAI  ; SOLDIER
	assert_table_length NUM_TRAINERS
