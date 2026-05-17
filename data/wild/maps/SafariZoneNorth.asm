SafariZoneNorthWildMons:
IF DEF(_RED)
	def_grass_wildmons 30 ; encounter rate
	db  22, NIDORINO
	db  26, NIDORINA
	db  24, PARASECT
	db  25, RHYHORN
	db   26, EXEGGCUTE
	db   26, VENONAT
	db   26, DRATINI
	db   26, CHANSEY
	db  26, KANGASKHAN
	db   26, TAUROS
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
	db   26, EXEGGCUTE
	db   26, VENONAT
	db   26, DRATINI
	db   26, CHANSEY
	db  26, BAGON
	db   26, TAUROS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

