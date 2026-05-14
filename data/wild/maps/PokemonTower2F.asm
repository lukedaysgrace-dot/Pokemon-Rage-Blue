PokemonTower2FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  17, GASTLY
	db  18, GASTLY
	db  25, HAUNTER
	db  20, CUBONE
	db  16, ZUBAT
	db  15, GASTLY
	db  21, CUBONE
	db  22, GOLBAT
	db  25, HAUNTER
	db  28, MAROWAK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  17, GASTLY
	db  18, GASTLY
	db  25, HAUNTER
	db  20, CUBONE
	db  16, DUSKULL
	db  15, DUSKULL
	db  21, CUBONE
	db  22, GOLBAT
	db  25, HAUNTER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

