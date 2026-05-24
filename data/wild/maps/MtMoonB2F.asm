MtMoonB2FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db   9, ZUBAT
	db   9, PARAS
	db  10, CLEFAIRY
	db  10, GEODUDE
	db  11, ZUBAT
	db  10, DIGLETT
	db  12, JIGGLYPUFF
	db  10, MACHOP
	db  12, ONIX
	db  13, PARAS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db   8, ZUBAT
	db   7, GEODUDE
	db   9, PARAS
	db   8, JIGGLYPUFF
	db   8, CLEFAIRY
	db  10, MACHOP
	db  10, ONIX
	db   8, GOLETT
	db   9, WIMPOD
	db   8, LARVITAR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

