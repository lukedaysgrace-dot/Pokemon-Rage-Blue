Route13WildMons:
IF DEF(_RED)
	def_grass_wildmons 20 ; encounter rate
	db  24, ODDISH
	db  25, VENONAT
	db  27, GLOOM
	db  24, DITTO
	db  22, WEEPINBELL
	db  26, PIDGEOTTO
	db  26, TANGELA
	db   28, VENONAT
	db  28, PARASECT
	db   28, GLOOM
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 20 ; encounter rate
	db  24, ODDISH
	db  25, VENONAT
	db  27, GLOOM
	db  24, DITTO
	db  22, WEEPINBELL
	db  26, PIDGEOTTO
	db   28, TANGELA
	db   28, VENONAT
	db  28, PARASECT
	db   28, GLOOM
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

