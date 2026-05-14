PokemonTower1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 8 ; encounter rate
	db  15, GASTLY
	db  16, GASTLY
	db  17, GASTLY
	db  18, CUBONE
	db  14, GASTLY
	db  13, CUBONE
	db  19, GASTLY
	db  15, ZUBAT
	db  25, HAUNTER
	db  22, GOLBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 8 ; encounter rate
	db  15, GASTLY
	db  16, GASTLY
	db  17, DUSKULL
	db  18, CUBONE
	db  14, DUSKULL
	db  13, CUBONE
	db  19, MISDREAVUS
	db  15, ZUBAT
	db  25, HAUNTER
	db  22, GOLBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
