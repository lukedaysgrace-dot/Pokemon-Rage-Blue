PokemonTower1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 8 ; encounter rate
	db  15, GASTLY
	db  16, GASTLY
	db  17, GASTLY
	db   17, CUBONE
	db  14, GASTLY
	db  13, CUBONE
	db   17, GASTLY
	db  15, ZUBAT
	db   17, GASTLY
	db   17, ZUBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 8 ; encounter rate
	db  15, GASTLY
	db  16, GASTLY
	db  17, DUSKULL
	db   17, CUBONE
	db  14, DUSKULL
	db  13, CUBONE
	db   17, MISDREAVUS
	db  15, ZUBAT
	db   17, GASTLY
	db   17, ZUBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
