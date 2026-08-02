Route10WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  19, VOLTORB
	db  19, MAGNEMITE
	db  18, VOLTORB
	db  18, MAGNEMITE
	db   20, CUBONE
	db   20, MAGNEMITE
	db  21, ELECTABUZZ
	db   20, CUBONE
	db  18, EKANS
	db   21, EKANS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  19, VOLTORB
	db  19, MAGNEMITE
	db  18, VOLTORB
	db  18, MAGNEMITE
	db   20, CUBONE
	db   20, MAGNEMITE
	db  21, ELECTABUZZ
	db   20, CUBONE
	db  18, EKANS
	db   21, ELECTABUZZ
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
