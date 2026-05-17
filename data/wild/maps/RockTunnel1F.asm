RockTunnel1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  16, ZUBAT
	db  17, GEODUDE
	db  17, MACHOP
	db  15, ZUBAT
	db  16, GEODUDE
	db   17, RHYHORN
	db  15, MACHOP
	db  17, ONIX
	db  13, ONIX
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
	db  15, ZUBAT
	db  16, GEODUDE
	db   17, RHYHORN
	db  15, MACHOP
	db  17, ONIX
	db  13, SNEASEL
	db  15, SNEASEL
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

