Route11WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  14, PIDGEY
	db  15, RATTATA
	db  12, DROWZEE
	db  20, RATICATE
	db  13, MAGNEMITE
	db  13, SPEAROW
	db  15, EKANS
	db  20, FEAROW
	db  26, HYPNO
	db  15, DROWZEE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  14, PINSIR
	db  40, RAPIDASH
	db  38, KINGDRA
	db  36, CROBAT
	db  13, STEELIX
	db  30, MAGNETON
	db  15, SCYTHER
	db  42, RHYPERIOR
	db  11, TANGELA
	db  43, GOLURK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

