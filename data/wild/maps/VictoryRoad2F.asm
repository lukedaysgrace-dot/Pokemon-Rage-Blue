VictoryRoad2FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  49, GOLBAT
	db  50, MACHOKE
	db  50, ONIX
	db  50, HYPNO
	db  51, MAROWAK
	db  52, GRAVELER
	db  52, GRAVELER
	db  51, MACHOKE
	db  51, GOLBAT
	db  53, RHYDON
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  49, PORYGON
	db  50, DRILBUR
	db  50, EXCADRILL
	db  50, POLIWHIRL
	db  51, ARCANINE
	db  52, STEELIX
	db  52, RHYDON
	db  51, GOLEM
	db  51, HITMONTOP
	db   53, RHYDON
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
