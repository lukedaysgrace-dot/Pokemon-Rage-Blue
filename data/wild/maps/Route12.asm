Route12WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  24, PIDGEOTTO
	db  25, VENONAT
	db  23, ODDISH
	db  24, WEEPINBELL
	db  22, GLOOM
	db  36, PIDGEOT
	db  26, TANGELA
	db  31, VENOMOTH
	db  28, WEEPINBELL
	db  30, PARASECT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  24, PIDGEOTTO
	db  25, VENONAT
	db  23, ODDISH
	db  24, WEEPINBELL
	db  22, GLOOM
	db  36, PIDGEOT
	db  36, TANGROWTH
	db  31, VENOMOTH
	db  28, DROWZEE
	db  30, HYPNO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

