Route14WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  24, VENONAT
	db  26, ODDISH
	db  23, GLOOM
	db  36, PIDGEOT
	db  22, WEEPINBELL
	db  26, VILEPLUME
	db  26, TANGELA
	db  31, VENOMOTH
	db  28, DITTO
	db  30, PARASECT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  24, VENONAT
	db  26, ODDISH
	db  23, GLOOM
	db  36, PIDGEOT
	db  22, WEEPINBELL
	db  26, VILEPLUME
	db  36, TANGROWTH
	db  31, VENOMOTH
	db  28, DITTO
	db  30, PARASECT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

