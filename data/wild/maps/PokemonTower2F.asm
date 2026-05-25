PokemonTower2FWildMons:
	def_grass_wildmons 0 ; encounter rate
IF DEF(_RED)
	def_grass_wildmons 1 ; encounter rate
	db  17, GASTLY
	db  18, GASTLY
	db   19, GASTLY
	db   19, CUBONE
	db  16, ZUBAT
	db  15, GASTLY
	db   19, CUBONE
	db   19, ZUBAT
	db   19, GASTLY
	db   19, CUBONE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 1 ; encounter rate
	db  17, GASTLY
	db  18, GASTLY
	db   19, GASTLY
	db   19, CUBONE
	db  16, DUSKULL
	db  15, DUSKULL
	db   19, CUBONE
	db   19, ZUBAT
	db   19, GASTLY
	db   19, CUBONE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
