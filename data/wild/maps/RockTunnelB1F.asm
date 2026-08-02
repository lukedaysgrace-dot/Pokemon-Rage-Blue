RockTunnelB1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  19, ZUBAT
	db  21, GEODUDE
	db  21, MACHOP
	db  19, RHYHORN
	db   20, ZUBAT
	db   21, GEODUDE
	db  19, ONIX
	db  21, GEODUDE
	db  20, ZUBAT
	db   22, ZUBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  19, AXEW
	db  21, GEODUDE
	db  21, MACHOP
	db  19, RHYHORN
	db  20, RIOLU
	db   21, DEINO
	db   21, MACHOP
	db   21, GEODUDE
	db  19, ONIX
	db   22, DEINO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
