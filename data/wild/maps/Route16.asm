Route16WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db  29, RATICATE
	db  31, RATICATE
	db  29, FEAROW
	db  30, FEAROW
	db  30, DODUO
	db  29, RATICATE
	db  31, FEAROW
	db   31, PIDGEOTTO
	db   31, DODUO
	db   31, DODUO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db  29, RATICATE
	db  31, RATICATE
	db  29, FEAROW
	db  30, FEAROW
	db  30, DODUO
	db  29, RATICATE
	db  31, FEAROW
	db   31, PIDGEOTTO
	db   31, DODUO
	db   31, MURKROW
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
