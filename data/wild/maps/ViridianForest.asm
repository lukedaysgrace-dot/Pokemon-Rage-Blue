ViridianForestWildMons:
IF DEF(_RED)
	def_grass_wildmons 8 ; encounter rate
	db   4, CATERPIE
	db   5, WEEDLE
	db   7, CATERPIE
	db   5, CATERPIE
	db   5, WEEDLE
	db   6, ODDISH
	db   4, BELLSPROUT
	db   5, PIKACHU
	db   6, WEEDLE
	db    6, SCYTHER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 8 ; encounter rate
	db   4, CATERPIE
	db   5, VENIPEDE
	db   5, BELLSPROUT
	db   4, WEEDLE
	db   5, ODDISH
	db   7, VENIPEDE
	db   5, PIKACHU
	db   6, SCYTHER
	db   7, CATERPIE
	db    8, WEEDLE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
