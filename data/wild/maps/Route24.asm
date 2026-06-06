Route24WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db   7, WEEDLE
	db   8, CATERPIE
	db  13, ODDISH
	db  10, ODDISH
	db  14, BELLSPROUT
	db  13, ABRA
	db   14, BELLSPROUT
	db  12, VENONAT
	db  11, METAPOD
	db   12, ABRA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db   9, WIMPOD
	db   9, VENIPEDE
	db   11, WIMPOD
	db  10, ODDISH
	db   11, BELLSPROUT
	db   11, ABRA
	db   8, RALTS
	db   11, VENONAT
	db  11, VENIPEDE
	db     9, RALTS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
