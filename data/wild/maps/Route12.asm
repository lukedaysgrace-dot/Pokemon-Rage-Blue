Route12WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  24, PIDGEOTTO
	db  25, VENONAT
	db  23, ODDISH
	db  24, WEEPINBELL
	db  22, GLOOM
	db   26, PIDGEOTTO
	db  26, TANGELA
	db   26, VENONAT
	db   26, WEEPINBELL
	db   26, PARASECT
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
	db   26, PIDGEOTTO
	db   26, TANGELA
	db   26, VENONAT
	db   26, WEEPINBELL
	db   26, TANGELA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
