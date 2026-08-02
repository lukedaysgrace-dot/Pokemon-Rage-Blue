SafariZoneNorthWildMons:
IF DEF(_RED)
	def_grass_wildmons 30 ; encounter rate
	db  33, NIDORINO
	db  37, NIDORINA
	db  35, DODUO
	db  36, RHYHORN
	db   37, EXEGGCUTE
	db   37, VENONAT
	db   34, DRATINI
	db   37, CHANSEY
	db  37, KANGASKHAN
	db   37, TAUROS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 30 ; encounter rate
	db  33, NIDORINO
	db  37, NIDORINA
	db  35, PARASECT
	db  36, RHYHORN
	db   37, EXEGGCUTE
	db   37, VENONAT
	db   34, DRATINI
	db   37, CHANSEY
	db  37, KANGASKHAN
	db   37, TAUROS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
