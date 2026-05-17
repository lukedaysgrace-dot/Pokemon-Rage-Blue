PokemonMansionB1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  33, GRIMER
	db  31, KOFFING
	db  35, RATICATE
	db   35, GRIMER
	db  35, WEEZING
	db   35, VULPIX
	db  34, MAGMAR
	db   35, GRIMER
	db   35, RATTATA
	db   35, WEEZING
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  33, GRIMER
	db  31, KOFFING
	db   35, GRIMER
	db  35, WEEZING
	db   35, VULPIX
	db  34, MAGMAR
	db   35, GRIMER
	db   35, CROAGUNK
	db  35, RATICATE
	db   35, RATTATA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
