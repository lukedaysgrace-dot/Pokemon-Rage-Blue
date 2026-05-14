PokemonTower7FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  25, HAUNTER
	db  22, GOLBAT
	db  28, HAUNTER
	db  22, CUBONE
	db  25, HAUNTER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  25, HAUNTER
	db  24, GASTLY
	db  22, GOLBAT
	db  28, HAUNTER
	db  25, HAUNTER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

