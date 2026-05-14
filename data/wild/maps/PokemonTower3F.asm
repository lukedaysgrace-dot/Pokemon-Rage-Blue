PokemonTower3FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  20, GASTLY
	db  21, GASTLY
	db  25, HAUNTER
	db  23, CUBONE
	db  19, ZUBAT
	db  18, GASTLY
	db  25, HAUNTER
	db  22, GOLBAT
	db  19, VULPIX
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  20, GASTLY
	db  21, MISDREAVUS
	db  25, HAUNTER
	db  23, CUBONE
	db  19, DUSKULL
	db  18, DUSKULL
	db  25, HAUNTER
	db  19, VULPIX
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

