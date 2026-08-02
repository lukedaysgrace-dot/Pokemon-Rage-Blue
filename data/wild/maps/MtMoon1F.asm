MtMoon1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db   9, ZUBAT
	db   8, GEODUDE
	db  10, PARAS
	db   9, ZUBAT
	db   9, CLEFAIRY
	db  11, MACHOP
	db  11, GEODUDE
	db   9, ZUBAT
	db   11, ONIX
	db   9, PARAS
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db   9, ZUBAT
	db   8, GEODUDE
	db  10, PARAS
	db   9, ZUBAT
	db   9, CLEFAIRY
	db  11, MACHOP
	db  11, BAGON
	db   9, GEODUDE
	db  10, LARVITAR
	db   9, LARVITAR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
