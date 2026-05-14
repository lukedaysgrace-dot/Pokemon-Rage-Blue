SafariZoneWestWildMons:
IF DEF(_RED)
	def_grass_wildmons 30 ; encounter rate
	db  25, VENONAT
	db  26, DODUO
	db  23, NIDORINO
	db  24, EXEGGCUTE
	db  33, RHYHORN
	db  26, PARASECT
	db  25, NIDORINA
	db  31, TAUROS
	db  26, DRATINI
	db  28, CHANSEY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 30 ; encounter rate
	db  25, VENONAT
	db  26, DODUO
	db  23, NIDORINO
	db  24, EXEGGCUTE
	db  33, RHYHORN
	db  26, PARASECT
	db  25, NIDORINA
	db  31, TAUROS
	db  26, DRATINI
	db  28, SNEASEL
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

