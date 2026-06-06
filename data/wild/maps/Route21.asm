Route21WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db  21, PIDGEOTTO
	db  23, TANGELA
	db  30, MEOWTH
	db  23, RATICATE
	db  21, PIDGEOTTO
	db  30, TANGELA
	db   32, PIDGEOTTO
	db  28, FARFETCHD
	db  30, TANGELA
	db  32, CHANSEY
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db   5, TENTACOOL
	db  10, HORSEA
	db  15, KRABBY
	db   5, TENTACOOL
	db  10, HORSEA
	db  30, TENTACRUEL
	db  33, STARYU
	db  30, STARYU
	db   33, SEADRA
	db   33, SEADRA
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db  21, PIDGEOTTO
	db  23, TANGELA
	db   25, MEOWTH
	db  23, RATICATE
	db  21, PIDGEOTTO
	db   25, TANGELA
	db   25, PIDGEOTTO
	db   25, FARFETCHD
	db   25, TANGELA
	db   25, CHANSEY
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db   5, TENTACOOL
	db  10, HORSEA
	db  15, KRABBY
	db   5, TENTACOOL
	db  10, HORSEA
	db  30, TENTACRUEL
	db  33, STARYU
	db  30, STARYU
	db   33, SEADRA
	db   33, SEADRA
	end_water_wildmons
ENDC
