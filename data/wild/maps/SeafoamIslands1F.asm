SeafoamIslands1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  30, SEEL
	db  30, SLOWPOKE
	db  30, ZUBAT
	db  30, GOLBAT
	db  28, SEEL
	db   32, SLOWPOKE
	db  29, JYNX
	db  28, SLOWPOKE
	db   32, SEEL
	db   32, SHELLDER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  30, SEEL
	db  30, SLOWPOKE
	db  30, ZUBAT
	db  30, GOLBAT
	db  28, SEEL
	db   32, SLOWPOKE
	db  29, JYNX
	db  28, SLOWPOKE
	db   32, SEEL
	db   32, GUARDIA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
