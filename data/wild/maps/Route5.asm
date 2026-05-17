Route5WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  13, ODDISH
	db  13, BELLSPROUT
	db  15, PIDGEY
	db  16, PIDGEY
	db  12, MEOWTH
	db  15, MANKEY
	db  16, DODUO
	db  16, RATTATA
	db  14, ABRA
	db  16, JIGGLYPUFF
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  13, ODDISH
	db  13, BELLSPROUT
	db  15, PIDGEY
	db  16, PIDGEY
	db  12, MEOWTH
	db  15, MANKEY
	db  16, DODUO
	db  16, RALTS
	db  14, ABRA
	db  16, ODDISH
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

