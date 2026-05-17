PokemonTower4FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  20, GASTLY
	db  25, HAUNTER
	db  25, HAUNTER
	db  23, CUBONE
	db  22, GOLBAT
	db  18, GASTLY
	db   25, HAUNTER
	db  25, HAUNTER
	db  24, GOLBAT
	db   25, DROWZEE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  20, GASTLY
	db  25, HAUNTER
	db  25, HAUNTER
	db  23, CUBONE
	db  22, GOLBAT
	db  18, DUSKULL
	db  25, HAUNTER
	db   25, CUBONE
	db  25, GOLBAT
	db  21, GASTLY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

