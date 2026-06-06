PokemonMansion3FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  35, WEEZING
	db  38, MUK
	db  35, MAGMAR
	db  32, RATICATE
	db  34, KOFFING
	db   38, MAGMAR
	db  34, GRIMER
	db  38, GROWLITHE
	db  36, WEEZING
	db   38, MUK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  35, WEEZING
	db  38, MUK
	db  35, MAGMAR
	db  32, KOFFING
	db  34, KOFFING
	db   38, MAGMAR
	db  34, GRIMER
	db  38, GROWLITHE
	db  36, WEEZING
	db   38, MAGMORTAR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
