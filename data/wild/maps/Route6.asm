Route6WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db   16, MAGNEMITE
	db  15, MEOWTH
	db  16, POLIWAG
	db  14, MEOWTH
	db  15, PSYDUCK
	db  16, MAGNEMITE
	db   17, MAGNEMITE
	db   17, POLIWAG
	db   17, POLIWAG
	db  18, PSYDUCK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  17, MAGNEMITE
	db  15, MEOWTH
	db  16, POLIWAG
	db  14, MEOWTH
	db  15, PSYDUCK
	db  16, MAGNEMITE
	db   18, MAGNEMITE
	db   17, POLIWAG
	db   17, POLIWAG
	db  18, PSYDUCK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
