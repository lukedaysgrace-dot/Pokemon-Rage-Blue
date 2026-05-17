Route11WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  14, PIDGEY
	db  15, RATTATA
	db  12, DROWZEE
	db   16, RATTATA
	db  13, MAGNEMITE
	db  13, SPEAROW
	db  15, EKANS
	db   16, SPEAROW
	db   16, DROWZEE
	db  15, DROWZEE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  14, PINSIR
	db   15, PONYTA
	db   15, HORSEA
	db   15, ZUBAT
	db  13, STEELIX
	db   15, MAGNEMITE
	db  15, SCYTHER
	db   15, RHYHORN
	db  11, TANGELA
	db   15, GOLETT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

