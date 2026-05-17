PokemonTower6FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  25, HAUNTER
	db  25, HAUNTER
	db  23, GASTLY
	db  22, GOLBAT
	db  25, HAUNTER
	db  24, CUBONE
	db  26, HYPNO
	db   26, HYPNO
	db   26, HYPNO
	db   26, HYPNO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  25, GASTLY
	db  25, HAUNTER
	db  25, HAUNTER
	db  23, GASTLY
	db  22, VULPIX
	db  24, DUSKULL
	db  25, GOLBAT
	db  26, HYPNO
	db   26, HYPNO
	db   26, HYPNO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

