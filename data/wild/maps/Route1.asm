Route1WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db   3, PIDGEY
	db   3, RATTATA
	db   3, SPEAROW
	db   3, NIDORAN_M
	db   3, NIDORAN_F
	db   4, PIKACHU
	db   4, POLIWAG
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db   3, PIDGEY
	db   3, RATTATA
	db   3, SPEAROW
	db   4, POLIWAG
	db   3, NIDORAN_M
	db   3, NIDORAN_F
	db   4, PIKACHU
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

