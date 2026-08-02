Route24WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db   13, WEEDLE
	db   13, CATERPIE
	db  15, ODDISH
	db  14, ODDISH
	db  15, BELLSPROUT
	db  15, ABRA
	db   15, BELLSPROUT
	db  14, VENONAT
	db  14, METAPOD
	db   14, ABRA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db   13, WIMPOD
	db   13, VENIPEDE
	db   15, WIMPOD
	db  14, ODDISH
	db   15, BELLSPROUT
	db   15, ABRA
	db   12, RALTS
	db   15, VENONAT
	db  15, VENIPEDE
	db     13, RALTS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
