SafariZoneCenterWildMons:
IF DEF(_RED)
	def_grass_wildmons 30 ; encounter rate
	db  33, NIDORAN_M
	db  36, NIDORAN_F
	db  33, RHYHORN
	db  35, VENONAT
	db   37, EXEGGCUTE
	db  36, NIDORINO
	db   37, NIDORINA
	db   37, KANGASKHAN
	db  34, SCYTHER
	db  34, CHANSEY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 30 ; encounter rate
	db  33, NIDORAN_M
	db  36, HERACROSS
	db  33, RHYHORN
	db  35, VENONAT
	db   37, EXEGGCUTE
	db  36, NIDORINO
	db   37, NIDORINA
	db   37, KANGASKHAN
	db  34, SCYTHER
	db  34, CHANSEY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

