DiglettsCaveWildMons:
IF DEF(_RED)
	def_grass_wildmons 20 ; encounter rate
	db  18, DIGLETT
	db  19, DIGLETT
	db  17, DIGLETT
	db   20, DIGLETT
	db  16, DIGLETT
	db   20, DIGLETT
	db   20, DIGLETT
	db   20, DIGLETT
	db   20, DIGLETT
	db   20, DIGLETT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 20 ; encounter rate
	db  18, DIGLETT
	db  19, DIGLETT
	db  17, DIGLETT
	db   20, DIGLETT
	db  16, DIGLETT
	db   20, DIGLETT
	db   20, DIGLETT
	db   20, DIGLETT
	db   20, DIGLETT
	db   20, PHANPY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

