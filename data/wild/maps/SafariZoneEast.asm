SafariZoneEastWildMons:
IF DEF(_RED)
	def_grass_wildmons 30 ; encounter rate
	db  35, EXEGGCUTE
	db  37, PARAS
	db  35, PARASECT
	db  36, VENONAT
	db   38, KANGASKHAN
	db  34, NIDORINO
	db  35, NIDORINA
	db  36, RHYHORN
	db  36, TAUROS
	db   38, PINSIR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 30 ; encounter rate
	db  35, EXEGGCUTE
	db  37, PARAS
	db  35, PARASECT
	db  36, VENONAT
	db   38, KANGASKHAN
	db  34, NIDORINO
	db  35, NIDORINA
	db  36, RHYHORN
	db  36, TAUROS
	db   38, PHANPY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

