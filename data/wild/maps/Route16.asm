Route16WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db  20, RATICATE
	db  22, RATICATE
	db  18, FEAROW
	db  20, FEAROW
	db  20, DODUO
	db  20, RATICATE
	db  22, FEAROW
	db   22, PIDGEOTTO
	db   22, DODUO
	db   22, DODUO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db  20, RATICATE
	db  22, RATICATE
	db  18, FEAROW
	db  20, FEAROW
	db  20, DODUO
	db  20, RATICATE
	db  22, FEAROW
	db   22, PIDGEOTTO
	db   22, DODUO
	db   22, MURKROW
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
