Route7WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  19, PIDGEY
	db  19, PIDGEOTTO
	db  17, MEOWTH
	db  22, DODUO
	db  22, MANKEY
	db  28, PRIMEAPE
	db  18, GROWLITHE
	db  20, FEAROW
	db  19, VULPIX
	db  20, ARCANINE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  19, PIDGEY
	db  19, PIDGEOTTO
	db  17, MEOWTH
	db  22, DODUO
	db  22, MANKEY
	db  28, PRIMEAPE
	db  18, GROWLITHE
	db  20, FEAROW
	db  19, VULPIX
	db  24, HOUNDOOM
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

