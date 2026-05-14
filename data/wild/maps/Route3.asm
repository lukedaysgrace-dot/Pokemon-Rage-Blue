Route3WildMons:
IF DEF(_RED)
	def_grass_wildmons 20 ; encounter rate
	db   6, PIDGEY
	db   5, SPEAROW
	db   7, MANKEY
	db   6, EKANS
	db   8, ZUBAT
	db   8, JIGGLYPUFF
	db   3, SANDSHREW
	db   5, NIDORAN_F
	db   7, NIDORAN_M
	db   6, PIDGEY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 20 ; encounter rate
	db   6, PIDGEY
	db   5, SPEAROW
	db   7, MANKEY
	db   6, EKANS
	db   8, ZUBAT
	db   8, JIGGLYPUFF
	db   3, RHYHORN
	db   5, NIDORAN_F
	db   7, PHANPY
	db   6, PIDGEY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

