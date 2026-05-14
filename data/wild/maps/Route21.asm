Route21WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db  21, RATTATA
	db  23, PIDGEY
	db  30, MEOWTH
	db  23, RATICATE
	db  21, PIDGEOTTO
	db  30, TANGELA
	db  36, PIDGEOT
	db  28, FARFETCHD
	db  30, TANGELA
	db  32, CHANSEY
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db   5, TENTACOOL
	db  10, HORSEA
	db  15, KRABBY
	db   5, SHELLDER
	db  10, STARYU
	db  30, TENTACRUEL
	db  33, SEAKING
	db  30, KINGLER
	db  35, SEADRA
	db  40, GYARADOS
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db  21, RATTATA
	db  23, PIDGEY
	db  30, MEOWTH
	db  23, RATICATE
	db  21, PIDGEOTTO
	db  30, TANGELA
	db  36, PIDGEOT
	db  28, FARFETCHD
	db  36, TANGROWTH
	db  32, CHANSEY
	end_grass_wildmons

	def_water_wildmons 5 ; encounter rate
	db   5, TENTACOOL
	db  10, HORSEA
	db  15, KRABBY
	db   5, SHELLDER
	db  10, STARYU
	db  30, TENTACRUEL
	db  33, SEAKING
	db  30, KINGLER
	db  35, SEADRA
	db  40, GYARADOS
	end_water_wildmons
ENDC

