Route12WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  28, PIDGEOTTO
	db  29, VENONAT
	db  27, ODDISH
	db  28, WEEPINBELL
	db  27, GLOOM
	db   30, PIDGEOTTO
	db  30, TANGELA
	db   30, VENONAT
	db   30, WEEPINBELL
	db   30, PARASECT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  28, PIDGEOTTO
	db  29, VENONAT
	db  27, ODDISH
	db  28, WEEPINBELL
	db  27, GLOOM
	db   30, PIDGEOTTO
	db   30, TANGELA
	db   30, CROAGUNK
	db   30, WEEPINBELL
	db   30, DROWZEE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
