Route8WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  18, VULPIX
	db  18, MEOWTH
	db  17, VULPIX
	db  16, EKANS
	db  20, GROWLITHE
	db  20, MANKEY
	db  19, SANDSHREW
	db   20, MEOWTH
	db   20, EKANS
	db   20, MANKEY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  18, RIOLU
	db  18, MEOWTH
	db  17, RIOLU
	db  16, EKANS
	db  20, GROWLITHE
	db  20, MANKEY
	db  19, SANDSHREW
	db   20, MEOWTH
	db   20, EKANS
	db   20, MANKEY
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
