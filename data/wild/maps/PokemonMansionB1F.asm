PokemonMansionB1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  46, GRIMER
	db  46, KOFFING
	db  47, RATICATE
	db   47, GRIMER
	db  47, WEEZING
	db   46, VULPIX
	db  47, MAGMAR
	db   48, GRIMER
	db   47, RATTATA
	db   48, WEEZING
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  46, GRIMER
	db  46, KOFFING
	db   47, GRIMER
	db  47, WEEZING
	db   47, VULPIX
	db  46, MAGMAR
	db   47, GRIMER
	db   48, MAGMAR
	db  47, RATICATE
	db   48, RATTATA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
