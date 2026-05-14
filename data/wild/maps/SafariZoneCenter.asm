SafariZoneCenterWildMons:
IF DEF(_RED)
	def_grass_wildmons 30 ; encounter rate
	db  22, NIDORAN_M
	db  25, NIDORAN_F
	db  22, RHYHORN
	db  24, VENONAT
	db  31, EXEGGCUTE
	db  25, NIDORINO
	db  31, NIDORINA
	db  30, PARASECT
	db  23, SCYTHER
	db  23, CHANSEY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 30 ; encounter rate
	db  22, NIDORAN_M
	db  25, HERACROSS
	db  22, RHYHORN
	db  24, VENONAT
	db  31, EXEGGCUTE
	db  25, NIDORINO
	db  31, NIDORINA
	db  30, PARASECT
	db  23, SCYTHER
	db  23, CHANSEY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

