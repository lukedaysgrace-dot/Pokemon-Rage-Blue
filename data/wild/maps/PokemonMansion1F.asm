PokemonMansion1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  45, KOFFING
	db  44, GRIMER
	db   45, KOFFING
	db  44, MAGMAR
	db   45, KOFFING
	db  45, GRIMER
	db   45, GRIMER
	db  44, GROWLITHE
	db   46, VULPIX
	db   46, GRIMER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  45, KOFFING
	db  44, GRIMER
	db   45, KOFFING
	db  44, MAGMAR
	db   45, KOFFING
	db  45, GRIMER
	db   45, GRIMER
	db  44, GROWLITHE
	db   46, VULPIX
	db   46, HOUNDOOM
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
