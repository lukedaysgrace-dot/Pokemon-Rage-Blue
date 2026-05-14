Route10WildMons:
IF DEF(_RED)
	def_grass_wildmons 15 ; encounter rate
	db  16, VOLTORB
	db  16, SPEAROW
	db  14, RATTATA
	db  11, MAGNEMITE
	db  20, RATICATE
	db  20, FEAROW
	db  17, ELECTABUZZ
	db  28, MAROWAK
	db  13, EKANS
	db  22, ARBOK
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 15 ; encounter rate
	db  16, VOLTORB
	db  16, SPEAROW
	db  14, RATTATA
	db  11, MAGNEMITE
	db  20, RATICATE
	db  20, FEAROW
	db  17, ELECTABUZZ
	db  28, MAROWAK
	db  13, EKANS
	db  38, ELECTIVIRE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

