Route21WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db  41, PIDGEOTTO
	db  42, TANGELA
	db  43, MEOWTH
	db  42, RATICATE
	db  41, PIDGEOTTO
	db  43, TANGELA
	db   44, PIDGEOTTO
	db  43, FARFETCHD
	db  43, TANGELA
	db  44, CHANSEY
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db   40, TENTACOOL
	db  41, HORSEA
	db  41, KRABBY
	db   40, TENTACOOL
	db  41, HORSEA
	db  42, TENTACRUEL
	db  43, STARYU
	db  42, STARYU
	db   43, SEADRA
	db   43, SEADRA
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db  41, PIDGEOTTO
	db  42, TANGELA
	db   43, MEOWTH
	db  42, RATICATE
	db  41, PIDGEOTTO
	db   43, TANGELA
	db   44, PIDGEOTTO
	db   43, FARFETCHD
	db   43, TANGELA
	db   44, CHANSEY
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db   40, TENTACOOL
	db  41, HORSEA
	db  41, KRABBY
	db   40, TENTACOOL
	db  41, HORSEA
	db  42, TENTACRUEL
	db  43, STARYU
	db  42, STARYU
	db   43, SEADRA
	db   43, SEADRA
	end_water_wildmons
ENDC
