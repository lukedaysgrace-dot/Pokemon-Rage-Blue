Route7WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  21, GROWLITHE
	db  21, PIDGEOTTO
	db  20, MEOWTH
	db  24, DODUO
	db  24, MANKEY
	db   24, MANKEY
	db  20, GROWLITHE
	db  22, VULPIX
	db  21, VULPIX
	db  22, ARCANINE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  21, GROWLITHE
	db  21, PIDGEOTTO
	db  20, MEOWTH
	db  24, DODUO
	db  24, MANKEY
	db   24, MANKEY
	db  20, GROWLITHE
	db  22, HOUNDOUR
	db  21, VULPIX
	db   24, HOUNDOUR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
