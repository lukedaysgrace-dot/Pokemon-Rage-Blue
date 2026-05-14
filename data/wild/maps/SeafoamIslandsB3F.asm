SeafoamIslandsB3FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  34, DEWGONG
	db  31, SEEL
	db  33, GOLBAT
	db  37, SLOWBRO
	db  29, JYNX
	db  34, DEWGONG
	db  37, SLOWBRO
	db  29, GOLBAT
	db  39, SHELLDER
	db  37, SEEL
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  34, DEWGONG
	db  31, SEEL
	db  33, GOLBAT
	db  37, SLOWBRO
	db  29, JYNX
	db  34, DEWGONG
	db  37, SLOWBRO
	db  29, GOLBAT
	db  39, SHELLDER
	db  37, GLACEON
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

