PokemonMansion3FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  46, WEEZING
	db  48, MUK
	db  46, MAGMAR
	db  46, RATICATE
	db  47, KOFFING
	db   48, MAGMAR
	db  47, GRIMER
	db  48, GROWLITHE
	db  47, WEEZING
	db   48, MUK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  46, WEEZING
	db  48, MUK
	db  46, MAGMAR
	db  46, KOFFING
	db  47, KOFFING
	db   48, MAGMAR
	db  47, GRIMER
	db  48, GROWLITHE
	db  47, WEEZING
	db   48, MAGMORTAR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
