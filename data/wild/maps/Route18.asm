Route18WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db  33, FEAROW
	db  33, RATICATE
	db  34, DODUO
	db   35, DODUO
	db   35, PIDGEOTTO
	db  34, RATICATE
	db  34, FEAROW
	db  35, DODUO
	db  34, RATICATE
	db  35, DODUO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db  33, FEAROW
	db  33, RATICATE
	db  34, DODUO
	db   35, DODUO
	db   35, PIDGEOTTO
	db  34, RATICATE
	db  34, FEAROW
	db  35, MURKROW
	db  34, RATICATE
	db   35, MURKROW
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
