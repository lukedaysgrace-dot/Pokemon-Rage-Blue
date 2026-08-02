Route3WildMons:
IF DEF(_RED)
	def_grass_wildmons 20 ; encounter rate
	db   8, PIDGEY
	db   7, SPEAROW
	db   9, MANKEY
	db   8, EKANS
	db  10, SPEAROW
	db  10, JIGGLYPUFF
	db   7, SANDSHREW
	db   7, MANKEY
	db   9, EKANS
	db   8, SANDSHREW
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 20 ; encounter rate
	db   8, PIDGEY
	db   7, SPEAROW
	db   9, MANKEY
	db   8, EKANS
	db  10, SPEAROW
	db  10, JIGGLYPUFF
	db   7, RHYHORN
	db   7, MANKEY
	db   9, PHANPY
	db   8, RHYHORN
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
