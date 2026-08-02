Route15WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  32, ODDISH
	db  34, GLOOM
	db  32, VENONAT
	db  34, DITTO
	db  32, WEEPINBELL
	db   34, DITTO
	db  34, TANGELA
	db   33, VENONAT
	db   33, VILEPLUME
	db   33, VILEPLUME
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  32, ODDISH
	db  34, GLOOM
	db  32, VENONAT
	db  34, DITTO
	db  32, WEEPINBELL
	db   34, DITTO
	db   34, TANGELA
	db   33, VENONAT
	db   33, VILEPLUME
	db   33, VILEPLUME
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
