CeruleanCave2FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  62, DRAGONITE
	db  58, RHYDON
	db  58, DRAGONITE
	db  59, SNORLAX
	db  59, LAPRAS
	db  62, DRAGONITE
	db   62, EXEGGUTOR
	db  61, POLIWRATH
	db  62, MACHAMP
	db   63, GYARADOS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  62, TYRANITAR
	db  58, RHYPERIOR
	db  58, SALAMENCE
	db  59, SNORLAX
	db  59, LAPRAS
	db  62, SCRAFTY
	db  62, BISHARP
	db  61, POLIWRATH
	db  62, MACHAMP
	db   63, GYARADOS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
