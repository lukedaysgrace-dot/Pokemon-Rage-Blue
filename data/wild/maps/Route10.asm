Route10WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  16, VOLTORB
	db  16, SPEAROW
	db  14, RATTATA
	db  11, MAGNEMITE
	db   17, RATTATA
	db   17, SPEAROW
	db  17, ELECTABUZZ
	db   17, CUBONE
	db  13, EKANS
	db   17, EKANS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  16, VOLTORB
	db  16, SPEAROW
	db  14, RATTATA
	db  11, MAGNEMITE
	db   17, RATTATA
	db   17, SPEAROW
	db  17, ELECTABUZZ
	db   17, CUBONE
	db  13, EKANS
	db   17, ELECTABUZZ
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

