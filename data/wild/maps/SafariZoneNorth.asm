SafariZoneNorthWildMons:
IF DEF(_RED)
	def_grass_wildmons 30 ; encounter rate
	db  22, NIDORINO
	db  26, NIDORINA
	db  24, PARASECT
	db  25, RHYHORN
	db  30, EXEGGCUTE
	db  31, VENOMOTH
	db  30, DRATINI
	db  32, CHANSEY
	db  26, KANGASKHAN
	db  28, TAUROS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 30 ; encounter rate
	db  22, NIDORINO
	db  26, NIDORINA
	db  24, PARASECT
	db  25, RHYHORN
	db  30, EXEGGCUTE
	db  31, VENOMOTH
	db  30, DRATINI
	db  32, CHANSEY
	db  26, BAGON
	db  28, TAUROS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

