Route22WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db   3, RATTATA
	db   3, SPEAROW
	db   4, DODUO
	db   4, MANKEY
	db   2, POLIWAG
	db   2, EKANS
	db   3, SANDSHREW
	db   5, DODUO
	db   3, NIDORAN_M
	db   4, NIDORAN_F
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db   3, RATTATA
	db   3, SPEAROW
	db   4, EKANS
	db   4, MANKEY
	db   4, POLIWAG
	db   4, MURKROW
	db   3, SANDSHREW
	db   5, DODUO
	db   3, NIDORAN_M
	db   4, RIOLU
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

