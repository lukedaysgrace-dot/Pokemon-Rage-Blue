RockTunnelB1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  16, ZUBAT
	db  17, GEODUDE
	db  17, MACHOP
	db  15, RHYHORN
	db  22, GOLBAT
	db  25, GRAVELER
	db  13, ONIX
	db  17, GEODUDE
	db  16, ZUBAT
	db  20, ZUBAT
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
	db  25, GRAVELER
	db  25, MACHOKE
	db  25, MAROWAK
	db  13, ONIX
	db  22, GOLBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

