Route14WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  30, VENONAT
	db  32, ODDISH
	db  30, GLOOM
	db   32, VILEPLUME
	db  30, WEEPINBELL
	db  32, VILEPLUME
	db  32, TANGELA
	db   31, VENONAT
	db   31, DITTO
	db   31, DITTO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  30, VENONAT
	db  32, ODDISH
	db  30, GLOOM
	db   32, VILEPLUME
	db  30, WEEPINBELL
	db  32, VILEPLUME
	db   32, TANGELA
	db   31, VENONAT
	db   31, DITTO
	db   31, DITTO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
