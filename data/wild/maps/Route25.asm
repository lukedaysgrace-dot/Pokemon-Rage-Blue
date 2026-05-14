Route25WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db   8, PIDGEY
	db   9, ODDISH
	db  13, BELLSPROUT
	db  18, PIDGEOTTO
	db  13, VENONAT
	db  12, ABRA
	db  21, WEEPINBELL
	db  21, GLOOM
	db  21, WEEPINBELL
	db   8, KRABBY
	end_grass_wildmons

	def_water_wildmons 10 ; encounter rate
	db   5, PSYDUCK
	db  10, POLIWAG
	db  33, GOLDUCK
	db  33, SEAKING
	db  10, KRABBY
	db  28, KINGLER
	db  20, SEEL
	db  30, SHELLDER
	db  35, STARYU
	db  40, HORSEA
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db   8, PIDGEY
	db   9, ODDISH
	db  13, BELLSPROUT
	db  18, PIDGEOTTO
	db  13, VENONAT
	db  12, ABRA
	db  21, WEEPINBELL
	db  21, GLOOM
	db   8, MESMERIA
	db   8, CROAGUNK
	end_grass_wildmons

	def_water_wildmons 10 ; encounter rate
	db   5, PSYDUCK
	db  10, POLIWAG
	db  33, GOLDUCK
	db  33, SEAKING
	db  10, KRABBY
	db  28, KINGLER
	db  20, SEEL
	db  30, SHELLDER
	db  35, STARYU
	db  40, HORSEA
	end_water_wildmons
ENDC

