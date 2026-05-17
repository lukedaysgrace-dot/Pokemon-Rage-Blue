RockTunnelB1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  16, ZUBAT
	db  17, GEODUDE
	db  17, MACHOP
	db  15, RHYHORN
	db   17, ZUBAT
	db   17, GEODUDE
	db  13, ONIX
	db  17, GEODUDE
	db  16, ZUBAT
	db   17, ZUBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  16, ZUBAT
	db  17, GEODUDE
	db  17, MACHOP
	db  15, RHYHORN
	db  17, RIOLU
	db   17, GEODUDE
	db   17, MACHOP
	db   17, CUBONE
	db  13, ONIX
	db   17, ZUBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

