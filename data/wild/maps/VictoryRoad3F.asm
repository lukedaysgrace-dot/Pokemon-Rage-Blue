VictoryRoad3FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  28, MACHOKE
	db  26, GOLBAT
	db  22, ONIX
	db  42, HYPNO
	db  40, MAROWAK
	db  45, HYPNO
	db  43, GOLEM
	db  41, MACHOKE
	db  42, VENOMOTH
	db  45, DODRIO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  24, RHYHORN
	db  30, RHYDON
	db  30, SCIZOR
	db  42, GARDEVOIR
	db  40, STEELIX
	db  45, LUCARIO
	db   45, ALAKAZAM
	db   45, GOLEM
	db  42, MACHAMP
	db  45, GENGAR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
