Route7WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  19, GROWLITHE
	db  19, PIDGEOTTO
	db  17, MEOWTH
	db  22, DODUO
	db  22, MANKEY
	db   22, MANKEY
	db  18, GROWLITHE
	db  20, VULPIX
	db  19, VULPIX
	db  20, ARCANINE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  19, GROWLITHE
	db  19, PIDGEOTTO
	db  17, MEOWTH
	db  22, DODUO
	db  22, MANKEY
	db   22, MANKEY
	db  18, GROWLITHE
	db  20, HOUNDOUR
	db  19, VULPIX
	db   22, HOUNDOUR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
