Route23WildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  46, HITMONLEE
	db  47, HITMONCHAN
	db  46, MR_MIME
	db  48, LICKITUNG
	db  48, SHELLDER
	db  48, HORSEA
	db  49, HITMONLEE
	db   49, HITMONCHAN
	db  50, POLIWHIRL
	db   50, GROWLITHE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  46, HITMONLEE
	db  47, HITMONCHAN
	db  46, MR_MIME
	db  48, LICKITUNG
	db  48, SHELLDER
	db  48, HORSEA
	db  49, HITMONLEE
	db   49, HITMONCHAN
	db  50, POLIWHIRL
	db   50, GROWLITHE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
