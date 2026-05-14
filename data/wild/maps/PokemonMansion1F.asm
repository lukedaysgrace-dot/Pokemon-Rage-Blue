PokemonMansion1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  32, KOFFING
	db  30, GRIMER
	db  34, RATTATA
	db  30, MAGMAR
	db  35, WEEZING
	db  32, RATICATE
	db  38, MUK
	db  28, GROWLITHE
	db  37, VULPIX
	db  39, MUK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  32, KOFFING
	db  30, GRIMER
	db  34, RATTATA
	db  30, MAGMAR
	db  35, WEEZING
	db  32, RATICATE
	db  38, MUK
	db  28, GROWLITHE
	db  37, VULPIX
	db  39, HOUNDOOM
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

