PokemonTower5FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  25, HAUNTER
	db  25, HAUNTER
	db  22, GASTLY
	db  23, GOLBAT
	db  19, CUBONE
	db  25, HAUNTER
	db  20, VULPIX
	db  25, HAUNTER
	db  25, GOLBAT
	db  43, HYPNO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  25, HAUNTER
	db  25, HAUNTER
	db  22, GASTLY
	db  23, GOLBAT
	db  19, CUBONE
	db  25, HAUNTER
	db  20, VULPIX
	db  25, HAUNTER
	db  23, MAROWAK
	db  31, MAROWAK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

