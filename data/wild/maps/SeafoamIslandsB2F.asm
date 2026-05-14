SeafoamIslandsB2FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  30, SEEL
	db  34, DEWGONG
	db  37, SLOWBRO
	db  32, GOLBAT
	db  28, SLOWPOKE
	db  30, JYNX
	db  30, SEEL
	db  34, DEWGONG
	db  30, SHELLDER
	db  37, GOLBAT
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  30, SEEL
	db  34, DEWGONG
	db  37, SLOWBRO
	db  32, GOLBAT
	db  28, SLOWPOKE
	db  30, JYNX
	db  30, SEEL
	db  34, DEWGONG
	db  30, SHELLDER
	db  36, MAMOSWINE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

