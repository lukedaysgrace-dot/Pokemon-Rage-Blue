Route2WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db   3, PIDGEY
	db   3, RATTATA
	db   4, SPEAROW
	db   5, GROWLITHE
	db   4, JIGGLYPUFF
	db   5, POLIWAG
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db   3, PIDGEY
	db   3, GROWLITHE
	db   4, SPEAROW
	db   5, HOUNDOUR
	db   5, BUNEARY
	db   4, JIGGLYPUFF
	db   5, PHANPY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

