Route8WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  21, VULPIX
	db  21, MEOWTH
	db  20, VULPIX
	db  20, EKANS
	db  23, GROWLITHE
	db  23, MANKEY
	db  22, SANDSHREW
	db   23, MEOWTH
	db   23, EKANS
	db   24, MANKEY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  21, RIOLU
	db  21, MEOWTH
	db  20, RIOLU
	db  20, EKANS
	db  23, GROWLITHE
	db  23, MANKEY
	db  22, SANDSHREW
	db   23, MEOWTH
	db   23, EKANS
	db   24, MANKEY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
