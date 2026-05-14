Route15WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  24, ODDISH
	db  26, GLOOM
	db  23, VENONAT
	db  26, DITTO
	db  22, WEEPINBELL
	db  36, PIDGEOT
	db  26, TANGELA
	db  31, VENOMOTH
	db  28, VILEPLUME
	db  30, PARASECT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  24, ODDISH
	db  26, GLOOM
	db  23, VENONAT
	db  26, DITTO
	db  22, WEEPINBELL
	db  36, PIDGEOT
	db  36, TANGROWTH
	db  31, VENOMOTH
	db  28, VILEPLUME
	db  30, PARASECT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

