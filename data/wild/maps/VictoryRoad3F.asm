VictoryRoad3FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  50, MACHOKE
	db  51, GOLBAT
	db  51, ONIX
	db  52, HYPNO
	db  52, MAROWAK
	db  53, HYPNO
	db  53, GOLEM
	db  53, MACHOKE
	db  52, VENOMOTH
	db  54, DODRIO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  50, RHYHORN
	db  51, RHYDON
	db  51, SCIZOR
	db  52, GARDEVOIR
	db  52, STEELIX
	db  53, LUCARIO
	db   53, ALAKAZAM
	db   53, GOLEM
	db  52, MACHAMP
	db  54, GENGAR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
