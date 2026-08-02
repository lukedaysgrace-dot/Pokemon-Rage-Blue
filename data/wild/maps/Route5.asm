Route5WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  15, ODDISH
	db  15, BELLSPROUT
	db  16, ODDISH
	db  17, BELLSPROUT
	db  14, MEOWTH
	db  16, MEOWTH
	db  17, JIGGLYPUFF
	db  17, ODDISH
	db  15, ABRA
	db  17, JIGGLYPUFF
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  15, ODDISH
	db  15, BELLSPROUT
	db  16, ODDISH
	db  17, BELLSPROUT
	db  14, MEOWTH
	db  16, MEOWTH
	db  17, RALTS
	db  17, RALTS
	db  15, ABRA
	db  17, ODDISH
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
