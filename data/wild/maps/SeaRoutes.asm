SeaRoutesWildMons:
IF DEF(_RED)
	def_grass_wildmons 0 ; encounter rate
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db  10, TENTACOOL
	db  15, KRABBY
	db  15, HORSEA
	db   15, PSYDUCK
	db  15, SHELLDER
	db   15, MAGIKARP
	db   15, GOLDEEN
	db   15, GOLDEEN
	db   15, TENTACOOL
	db   15, MAGIKARP
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 0 ; encounter rate
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db  10, TENTACOOL
	db  15, KRABBY
	db  15, HORSEA
	db   15, PSYDUCK
	db  15, SHELLDER
	db   15, MAGIKARP
	db   15, GOLDEEN
	db   15, GOLDEEN
	db   15, TENTACOOL
	db   15, MAGIKARP
	end_water_wildmons
ENDC

