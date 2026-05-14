PokemonMansion2FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  32, RATTATA
	db  34, RATICATE
	db  34, KOFFING
	db  30, GRIMER
	db  30, MAGMAR
	db  35, WEEZING
	db  38, MUK
	db  28, GROWLITHE
	db  39, RATICATE
	db  37, RATTATA
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
	db  35, WEEZING
	db  38, MUK
	db  28, GROWLITHE
	db  39, RATICATE
	db  38, MAGMORTAR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

