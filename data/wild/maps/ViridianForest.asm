ViridianForestWildMons:
IF DEF(_RED)
	def_grass_wildmons 8 ; encounter rate
	db   4, CATERPIE
	db   5, WEEDLE
	db   7, METAPOD
	db   7, KAKUNA
	db   4, PIDGEY
	db   6, PARAS
	db   4, VENONAT
	db   5, PIKACHU
	db   6, SCYTHER
	db  18, BEEDRILL
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 8 ; encounter rate
	db   4, CATERPIE
	db   5, VENIPEDE
	db   7, METAPOD
	db   4, WEEDLE
	db   4, PIDGEY
	db   7, KAKUNA
	db   5, PIKACHU
	db   6, SCYTHER
	db   7, METAPOD
	db  18, BEEDRILL
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

