Route18WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db  20, FEAROW
	db  22, RATICATE
	db  25, DODUO
	db   29, DODUO
	db   29, PIDGEOTTO
	db  26, RATICATE
	db  28, FEAROW
	db  29, DODUO
	db  27, RATICATE
	db  29, DODUO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db  20, FEAROW
	db  22, RATICATE
	db  25, DODUO
	db   29, DODUO
	db   29, PIDGEOTTO
	db  26, RATICATE
	db  28, FEAROW
	db  29, MURKROW
	db  27, RATICATE
	db   29, MURKROW
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
