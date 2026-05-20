CeruleanCave2FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  55, DRAGONITE
	db  51, RHYDON
	db  51, SALAMENCE
	db  52, SNORLAX
	db  52, LAPRAS
	db  55, DRAGONITE
	db   55, EXEGGUTOR
	db  54, POLIWRATH
	db  55, MACHAMP
	db   55, GYARADOS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  55, TYRANITAR
	db  51, RHYPERIOR
	db  51, SALAMENCE
	db  52, SNORLAX
	db  52, LAPRAS
	db  55, TYRANTRUM
	db  55, AURORUS
	db  54, POLIWRATH
	db  55, MACHAMP
	db   55, GYARADOS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
