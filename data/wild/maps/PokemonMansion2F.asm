PokemonMansion2FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  32, RATTATA
	db  34, RATICATE
	db  34, KOFFING
	db  30, GRIMER
	db  30, MAGMAR
	db   34, KOFFING
	db   34, GRIMER
	db  28, GROWLITHE
	db   34, RATICATE
	db   34, RATTATA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  32, RATTATA
	db  34, RATICATE
	db  34, KOFFING
	db  30, GRIMER
	db  30, MAGMAR
	db   34, KOFFING
	db   34, GRIMER
	db  28, GROWLITHE
	db   34, RATICATE
	db   34, MAGMAR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

