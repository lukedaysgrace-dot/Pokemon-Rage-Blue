Route17WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db  31, FEAROW
	db  31, PONYTA
	db  32, RATICATE
	db  32, DODUO
	db   33, PIDGEOTTO
	db  33, FEAROW
	db   33, DODUO
	db   33, PONYTA
	db  32, PONYTA
	db   33, PONYTA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db  31, FEAROW
	db  31, PONYTA
	db  32, RATICATE
	db  32, DODUO
	db   33, PIDGEOTTO
	db  33, FEAROW
	db   33, DODUO
	db   33, PONYTA
	db  32, PONYTA
	db   33, PONYTA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
