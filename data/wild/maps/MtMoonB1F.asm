MtMoonB1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db   8, ZUBAT
	db   7, GEODUDE
	db   7, PARAS
	db   8, DIGLETT
	db   9, ZUBAT
	db  10, MACHOP
	db  10, GEODUDE
	db  11, CLEFAIRY
	db   9, ONIX
	db   9, ZUBAT
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

