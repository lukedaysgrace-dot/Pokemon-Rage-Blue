SeafoamIslandsB1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  30, SLOWPOKE
	db  30, SEEL
	db  32, GOLBAT
	db  34, DEWGONG
	db  37, SLOWBRO
	db  30, ZUBAT
	db  37, SLOWBRO
	db  28, SHELLDER
	db  38, JYNX
	db  37, GOLBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  30, SLOWPOKE
	db  30, SEEL
	db  32, GOLBAT
	db  34, DEWGONG
	db  37, SLOWBRO
	db  30, ZUBAT
	db  37, SLOWBRO
	db  28, SHELLDER
	db  38, JYNX
	db  37, PILOSWINE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

