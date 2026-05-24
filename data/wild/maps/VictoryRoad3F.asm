VictoryRoad3FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  28, MACHOKE
	db  26, GOLBAT
	db  22, ONIX
	db  42, HYPNO
	db  40, MAROWAK
	db  45, KADABRA
	db  43, GOLEM
	db  41, PARASECT
	db  42, VENOMOTH
	db  45, DODRIO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  24, LARVITAR
	db  30, PUPITAR
	db  30, SHELGON
	db  42, GARDEVOIR
	db  40, KIRLIA
	db  45, LUCARIO
	db   45, SHELGON
	db   45, PUPITAR
	db  42, WIMPOD
	db  45, GOLISOPOD
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

