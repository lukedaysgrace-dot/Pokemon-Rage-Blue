RockTunnel1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  19, ZUBAT
	db  20, GEODUDE
	db  20, MACHOP
	db  19, ZUBAT
	db  19, GEODUDE
	db   21, RHYHORN
	db  19, MACHOP
	db  21, ONIX
	db  22, ONIX
	db   19, ZUBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  19, PAWNIARD
	db  20, GEODUDE
	db  20, MACHOP
	db  19, DRILBUR
	db  19, DRILBUR
	db   21, RHYHORN
	db  19, PAWNIARD
	db  21, ONIX
	db  22, DEINO
	db  19, DEINO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
