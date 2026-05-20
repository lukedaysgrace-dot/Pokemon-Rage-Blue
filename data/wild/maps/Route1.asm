Route1WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db   3, SQUIRTLE
	db   3, WARTORTLE
	db   3, CHARMANDER
	db   3, CHARMELEON
	db   3, CHARIZARD
	db   4, BULBASAUR
	db   4, IVYSAUR
	db   4, VENUSAUR
	db   3, RATTATA
	db   4, PIKACHU
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db   3, SQUIRTLE
	db   3, WARTORTLE
	db   3, CHARMANDER
	db   3, CHARMELEON
	db   3, CHARIZARD
	db   4, BULBASAUR
	db   4, IVYSAUR
	db   4, VENUSAUR
	db   3, RATTATA
	db   4, RATTATA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

