Route6WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db   16, MAGNEMITE
	db  13, MEOWTH
	db  15, POLIWAG
	db  10, MEOWTH
	db  12, PSYDUCK
	db  15, MAGNEMITE
	db   16, MAGNEMITE
	db   16, POLIWAG
	db   16, POLIWAG
	db  16, PSYDUCK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  18, MAGNEMITE
	db  13, MEOWTH
	db  15, POLIWAG
	db  10, MEOWTH
	db  12, PSYDUCK
	db  15, MAGNEMITE
	db   18, MAGNEMITE
	db   16, POLIWAG
	db   16, POLIWAG
	db  18, PSYDUCK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
