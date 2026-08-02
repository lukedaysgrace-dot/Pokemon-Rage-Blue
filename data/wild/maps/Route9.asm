Route9WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  18, EKANS
	db  18, SANDSHREW
	db  17, EKANS
	db  17, SANDSHREW
	db  19, NIDORINO
	db  19, NIDORINA
	db  21, FEAROW
	db   21, EKANS
	db  21, RATICATE
	db  19, SANDSHREW
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  18, EKANS
	db  18, SANDSHREW
	db  17, EKANS
	db  17, SANDSHREW
	db  19, NIDORINO
	db  19, NIDORINA
	db  21, FEAROW
	db   21, EKANS
	db  21, RATICATE
	db  19, HOUNDOUR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
