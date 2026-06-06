PokemonMansion1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  32, KOFFING
	db  30, GRIMER
	db   32, KOFFING
	db  30, MAGMAR
	db   32, KOFFING
	db  32, GRIMER
	db   32, GRIMER
	db  28, GROWLITHE
	db   32, VULPIX
	db   32, GRIMER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  32, KOFFING
	db  30, GRIMER
	db   32, KOFFING
	db  30, MAGMAR
	db   32, KOFFING
	db  32, GRIMER
	db   32, GRIMER
	db  28, GROWLITHE
	db   32, VULPIX
	db   32, HOUNDOOM
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
