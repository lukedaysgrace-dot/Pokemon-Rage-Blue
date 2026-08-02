SeafoamIslands1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  41, SEEL
	db  41, SLOWPOKE
	db  41, ZUBAT
	db  41, GOLBAT
	db  40, SEEL
	db   42, SLOWPOKE
	db  40, JYNX
	db  40, SLOWPOKE
	db   42, SEEL
	db   42, SHELLDER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  41, SEEL
	db  41, SLOWPOKE
	db  41, ZUBAT
	db  41, GOLBAT
	db  40, SEEL
	db   42, SLOWPOKE
	db  40, JYNX
	db  40, SLOWPOKE
	db   42, SEEL
	db   42, CHINCHOU
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
