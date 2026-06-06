Route9WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  16, EKANS
	db  16, SANDSHREW
	db  14, EKANS
	db  11, SANDSHREW
	db  16, NIDORINO
	db  16, NIDORINA
	db  20, FEAROW
	db   20, EKANS
	db  20, RATICATE
	db  17, SANDSHREW
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  16, EKANS
	db  16, SANDSHREW
	db  14, EKANS
	db  11, SANDSHREW
	db  16, NIDORINO
	db  16, NIDORINA
	db  20, FEAROW
	db   20, EKANS
	db  20, RATICATE
	db  17, HOUNDOUR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
