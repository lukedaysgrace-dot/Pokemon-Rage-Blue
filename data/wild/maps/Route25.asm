Route25WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db   8, ODDISH
	db   9, ODDISH
	db   12, BELLSPROUT
	db   12, ODDISH
	db   12, VENONAT
	db  12, ABRA
	db   12, BELLSPROUT
	db   12, ODDISH
	db   12, BELLSPROUT
	db   8, ABRA
	end_grass_wildmons

	def_water_wildmons 10 ; encounter rate
	db   5, PSYDUCK
	db  10, POLIWAG
	db  33, PSYDUCK
	db  33, POLIWAG
	db  10, KRABBY
	db  28, KINGLER
	db  20, SHELLDER
	db  30, SHELLDER
	db   33, STARYU
	db   33, HORSEA
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db   8, ODDISH
	db   9, ODDISH
	db   12, BELLSPROUT
	db   12, ODDISH
	db   12, VENONAT
	db  12, ABRA
	db   12, BELLSPROUT
	db   12, ODDISH
	db     8, JYNX
	db   8, SNORUNT
	end_grass_wildmons

	def_water_wildmons 10 ; encounter rate
	db   5, PSYDUCK
	db  10, POLIWAG
	db  33, PSYDUCK
	db  33, POLIWAG
	db  10, KRABBY
	db  28, KINGLER
	db  20, SHELLDER
	db  30, SHELLDER
	db   33, STARYU
	db   33, HORSEA
	end_water_wildmons
ENDC
