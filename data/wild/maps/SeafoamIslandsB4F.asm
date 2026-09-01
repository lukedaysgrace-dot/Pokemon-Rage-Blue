SeafoamIslandsB4FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  43, DEWGONG
	db  42, GOLBAT
	db   43, SLOWPOKE
	db  43, JYNX
	db  42, SEEL
	db  42, JYNX
	db  42, GOLBAT
	db  43, DEWGONG
	db   43, SLOWPOKE
	db  43, SHELLDER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  43, DEWGONG
	db  42, GOLBAT
	db   43, AMAURA
	db  43, JYNX
	db  42, SEEL
	db  42, JYNX
	db  42, GOLBAT
	db  43, DEWGONG
	db   43, SLOWPOKE
	db   43, SNEASEL
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
