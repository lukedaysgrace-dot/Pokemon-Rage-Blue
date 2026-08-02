SeafoamIslandsB1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  41, SLOWPOKE
	db  41, SEEL
	db  42, GOLBAT
	db   42, SEEL
	db   42, SLOWPOKE
	db  41, ZUBAT
	db   42, SLOWPOKE
	db  41, SHELLDER
	db   42, JYNX
	db   42, GOLBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  41, SLOWPOKE
	db  41, SEEL
	db  42, GOLBAT
	db   42, SEEL
	db   42, SLOWPOKE
	db  41, ZUBAT
	db   42, SLOWPOKE
	db  41, SHELLDER
	db   42, JYNX
	db   42, CHINCHOU
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
