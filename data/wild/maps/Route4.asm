Route4WildMons:
IF DEF(_RED)
	def_grass_wildmons 20 ; encounter rate
	db  12, MAGNEMITE
	db  12, MAGNEMITE
	db  11, MACHOP
	db  11, FARFETCHD
	db  11, MACHOP
	db  12, FARFETCHD
	db  14, PARAS
	db  14, CLEFAIRY
	db  11, PSYDUCK
	db  14, CLEFAIRY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 20 ; encounter rate
	db  12, MAGNEMITE
	db  12, MAGNEMITE
	db  11, MACHOP
	db  11, FARFETCHD
	db  11, MACHOP
	db  12, FARFETCHD
	db  14, PARAS
	db  14, CLEFAIRY
	db  11, PSYDUCK
	db  14, CLEFAIRY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
