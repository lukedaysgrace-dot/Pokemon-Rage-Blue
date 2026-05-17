Route23WildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  26, HITMONLEE
	db  33, HITMONCHAN
	db  26, MR_MIME
	db  38, LICKITUNG
	db  38, SHELLDER
	db  38, HORSEA
	db  41, NIDORINO
	db   41, GROWLITHE
	db  41, POLIWHIRL
	db   41, DRAGONAIR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  26, HITMONLEE
	db  33, HITMONCHAN
	db  26, MR_MIME
	db  38, LICKITUNG
	db  38, SHELLDER
	db  38, HORSEA
	db  41, NIDORINO
	db   41, GROWLITHE
	db  41, POLIWHIRL
	db   41, DRAGONAIR
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

