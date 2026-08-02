SeafoamIslandsB2FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  41, SEEL
	db  43, DEWGONG
	db   43, SLOWPOKE
	db  42, GOLBAT
	db  41, SLOWPOKE
	db  41, JYNX
	db  41, SEEL
	db  43, DEWGONG
	db  41, SHELLDER
	db   43, GOLBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  41, SEEL
	db  43, DEWGONG
	db   43, SLOWPOKE
	db  42, GOLBAT
	db  41, SLOWPOKE
	db  41, JYNX
	db  41, SEEL
	db  43, DEWGONG
	db  41, SHELLDER
	db   43, LANTURN
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
