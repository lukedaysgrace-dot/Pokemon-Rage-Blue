PowerPlantWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  21, VOLTORB
	db  21, MAGNEMITE
	db  20, PIKACHU
	db  30, ELECTRODE
	db  23, MAGNEMITE
	db  23, VOLTORB
	db  32, MAGNETON
	db  35, ELECTABUZZ
	db  33, ELECTRODE
	db  36, RAICHU
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  21, VOLTORB
	db  21, MAGNEMITE
	db  20, PIKACHU
	db  30, ELECTRODE
	db  23, MAGNEMITE
	db  23, VOLTORB
	db  35, MAGNEZONE
	db  35, ELECTABUZZ
	db  33, ELECTRODE
	db  36, RAICHU
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

