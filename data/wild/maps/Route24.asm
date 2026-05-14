Route24WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db   7, WEEDLE
	db   8, CATERPIE
	db  13, PIDGEY
	db  10, ODDISH
	db  14, BELLSPROUT
	db  13, ABRA
	db  18, PIDGEOTTO
	db  12, VENONAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db   7, WEEDLE
	db   8, VENIPEDE
	db  13, PIDGEY
	db  10, ODDISH
	db  14, BELLSPROUT
	db  13, ABRA
	db   8, RALTS
	db  12, VENONAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

