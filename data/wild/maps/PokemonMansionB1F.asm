PokemonMansionB1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  33, GRIMER
	db  31, KOFFING
	db  35, RATICATE
	db  38, MUK
	db  35, WEEZING
	db  40, VULPIX
	db  34, MAGMAR
	db  38, MUK
	db  42, RATTATA
	db  42, WEEZING
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  33, GRIMER
	db  31, KOFFING
	db  38, MUK
	db  35, WEEZING
	db  40, VULPIX
	db  34, MAGMAR
	db  38, MUK
	db  42, TOXICROAK
	db  35, RATICATE
	db  42, RATTATA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
