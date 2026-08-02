Route13WildMons:
IF DEF(_RED)
	def_grass_wildmons 20 ; encounter rate
	db  29, ODDISH
	db  29, VENONAT
	db  31, GLOOM
	db  29, DITTO
	db  29, WEEPINBELL
	db  30, DITTO
	db  30, TANGELA
	db   31, VENONAT
	db  31, PARASECT
	db   31, GLOOM
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 20 ; encounter rate
	db  29, ODDISH
	db  29, VENONAT
	db  31, GLOOM
	db  29, DITTO
	db  29, WEEPINBELL
	db  30, DITTO
	db   31, TANGELA
	db   31, VENONAT
	db  31, PARASECT
	db   31, GLOOM
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
