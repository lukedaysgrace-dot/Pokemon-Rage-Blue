SeaRoutesWildMons:
IF DEF(_RED)
	def_grass_wildmons 0 ; encounter rate
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db  37, TENTACOOL
	db  39, KRABBY
	db  39, HORSEA
	db   40, PSYDUCK
	db  39, SHELLDER
	db   40, MAGIKARP
	db   40, GOLDEEN
	db   41, GOLDEEN
	db   39, TENTACOOL
	db   41, MAGIKARP
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 0 ; encounter rate
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db  37, TENTACOOL
	db  39, KRABBY
	db  39, HORSEA
	db   40, PSYDUCK
	db  39, SHELLDER
	db   40, MAGIKARP
	db   40, GOLDEEN
	db   41, GOLDEEN
	db   39, TENTACOOL
	db   41, MAGIKARP
	end_water_wildmons
ENDC

