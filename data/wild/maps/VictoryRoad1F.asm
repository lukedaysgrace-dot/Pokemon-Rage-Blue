VictoryRoad1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  48, GOLBAT
	db  49, MACHOKE
	db  48, ONIX
	db  49, MACHOKE
	db  50, GRAVELER
	db  51, MAROWAK
	db  51, KADABRA
	db  50, GOLBAT
	db  51, HYPNO
	db  52, GOLDUCK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  48, VICTREEBEL
	db  49, GOLDUCK
	db  48, LEAFEON
	db  49, SCYTHER
	db  50, GRAVELER
	db  51, SCIZOR
	db  51, ANNIHILAPE
	db  50, BLISSEY
	db  51, AMPHAROS
	db  52, GOLETT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
