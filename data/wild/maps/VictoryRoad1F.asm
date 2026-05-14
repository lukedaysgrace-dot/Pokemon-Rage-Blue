VictoryRoad1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  24, GOLBAT
	db  28, MACHOKE
	db  22, ONIX
	db  36, MACHOKE
	db  39, GRAVELER
	db  42, MAROWAK
	db  41, KADABRA
	db  41, GOLBAT
	db  42, HYPNO
	db  43, GOLDUCK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  24, VICTREEBEL
	db  33, GOLDUCK
	db  22, LEAFEON
	db  36, SCIZOR
	db  39, LICKILICKY
	db  42, LOPUNNY
	db  41, ANNIHILAPE
	db  41, BLISSEY
	db  42, DRAGONAIR
	db  43, GOLETT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

