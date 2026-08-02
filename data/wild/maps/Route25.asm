Route25WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db   13, ODDISH
	db   13, ODDISH
	db   16, BELLSPROUT
	db   16, ODDISH
	db   16, VENONAT
	db  15, ABRA
	db   16, BELLSPROUT
	db   16, ODDISH
	db   16, BELLSPROUT
	db   13, ABRA
	end_grass_wildmons

	def_water_wildmons 10 ; encounter rate
	db   13, PSYDUCK
	db  14, POLIWAG
	db  16, PSYDUCK
	db  16, POLIWAG
	db  14, KRABBY
	db  16, KINGLER
	db  15, SHELLDER
	db  16, SHELLDER
	db   16, STARYU
	db   16, HORSEA
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db   13, ODDISH
	db   13, ODDISH
	db   16, BELLSPROUT
	db   16, ODDISH
	db   16, VENONAT
	db  15, ABRA
	db   16, BELLSPROUT
	db   16, ODDISH
	db     13, JYNX
	db   13, SNORUNT
	end_grass_wildmons

	def_water_wildmons 10 ; encounter rate
	db   13, PSYDUCK
	db  14, POLIWAG
	db  16, PSYDUCK
	db  16, POLIWAG
	db  14, KRABBY
	db  16, KINGLER
	db  15, SHELLDER
	db  16, SHELLDER
	db   16, STARYU
	db   16, HORSEA
	end_water_wildmons
ENDC
