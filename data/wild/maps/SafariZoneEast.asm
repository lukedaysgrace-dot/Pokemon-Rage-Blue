SafariZoneEastWildMons:
IF DEF(_RED)
	def_grass_wildmons 30 ; encounter rate
	db  24, EXEGGCUTE
	db  26, PARAS
	db  24, PARASECT
	db  25, VENONAT
	db   27, VENONAT
	db  23, NIDORINO
	db  24, NIDORINA
	db  25, RHYHORN
	db  25, TAUROS
	db   27, PINSIR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 30 ; encounter rate
	db  24, EXEGGCUTE
	db  26, PARAS
	db  24, PARASECT
	db  25, VENONAT
	db   27, VENONAT
	db  23, NIDORINO
	db  24, NIDORINA
	db  25, RHYHORN
	db  25, TAUROS
	db   27, PHANPY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

