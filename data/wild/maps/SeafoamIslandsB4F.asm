SeafoamIslandsB4FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  34, DEWGONG
	db  31, GOLBAT
	db   34, SLOWPOKE
	db  33, JYNX
	db  29, SEEL
	db  31, JYNX
	db  31, GOLBAT
	db  34, DEWGONG
	db   34, SLOWPOKE
	db  32, SHELLDER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  34, DEWGONG
	db  31, GOLBAT
	db   34, SLOWPOKE
	db  33, JYNX
	db  29, SEEL
	db  31, JYNX
	db  31, GOLBAT
	db  34, DEWGONG
	db   34, SLOWPOKE
	db   34, SNEASEL
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

