PokemonMansion2FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  45, RATTATA
	db  46, RATICATE
	db  46, KOFFING
	db  45, GRIMER
	db  45, MAGMAR
	db   46, KOFFING
	db   46, GRIMER
	db  45, GROWLITHE
	db   47, RATICATE
	db   47, RATTATA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  45, RATTATA
	db  46, RATICATE
	db  46, KOFFING
	db  45, GRIMER
	db  45, MAGMAR
	db   46, KOFFING
	db   46, GRIMER
	db  45, GROWLITHE
	db   47, RATICATE
	db   47, MAGMAR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

