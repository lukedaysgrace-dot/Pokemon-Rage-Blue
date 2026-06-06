VictoryRoad2FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  22, GOLBAT
	db  28, MACHOKE
	db  26, ONIX
	db  36, HYPNO
	db  39, MAROWAK
	db  42, GRAVELER
	db  41, GRAVELER
	db  40, MACHOKE
	db  40, GOLBAT
	db  43, RHYDON
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  22, PORYGON
	db  30, DRILBUR
	db  38, EXCADRILL
	db  36, POLIWHIRL
	db  39, ARCANINE
	db  42, STEELIX
	db  42, RHYDON
	db  40, GOLEM
	db  40, EXCADRILL
	db   42, RHYDON
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
