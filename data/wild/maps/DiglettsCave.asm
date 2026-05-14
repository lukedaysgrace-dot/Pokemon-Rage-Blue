DiglettsCaveWildMons:
IF DEF(_RED)
	def_grass_wildmons 20 ; encounter rate
	db  18, DIGLETT
	db  19, DIGLETT
	db  17, DIGLETT
	db  26, DUGTRIO
	db  16, DIGLETT
	db  26, DUGTRIO
	db  21, DIGLETT
	db  26, DUGTRIO
	db  29, DIGLETT
	db  31, DUGTRIO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 20 ; encounter rate
	db  18, DIGLETT
	db  19, DIGLETT
	db  17, DIGLETT
	db  26, DUGTRIO
	db  16, DIGLETT
	db  26, DUGTRIO
	db  21, DIGLETT
	db  26, DUGTRIO
	db  29, DIGLETT
	db  31, DONPHAN
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

