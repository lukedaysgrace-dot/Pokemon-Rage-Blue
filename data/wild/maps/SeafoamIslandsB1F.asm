SeafoamIslandsB1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  30, SLOWPOKE
	db  30, SEEL
	db  32, GOLBAT
	db   32, SEEL
	db   32, SLOWPOKE
	db  30, ZUBAT
	db   32, SLOWPOKE
	db  28, SHELLDER
	db   32, JYNX
	db   32, GOLBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  30, SLOWPOKE
	db  30, SEEL
	db  32, GOLBAT
	db   32, SEEL
	db   32, SLOWPOKE
	db  30, ZUBAT
	db   32, SLOWPOKE
	db  28, SHELLDER
	db   32, JYNX
	db   32, GUARDIA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
