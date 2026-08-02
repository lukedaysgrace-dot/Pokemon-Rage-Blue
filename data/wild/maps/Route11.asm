Route11WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  17, DROWZEE
	db  18, MAGNEMITE
	db  17, DROWZEE
	db   19, EKANS
	db  17, MAGNEMITE
	db  17, SPEAROW
	db  18, EKANS
	db   19, SPEAROW
	db   19, DROWZEE
	db  18, DROWZEE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  17, PONYTA
	db   18, PONYTA
	db   18, MAGNEMITE
	db   18, RHYHORN
	db  17, PINSIR
	db   18, MAGNEMITE
	db  19, SCYTHER
	db   18, RHYHORN
	db  16, GOLETT
	db   19, GOLETT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
