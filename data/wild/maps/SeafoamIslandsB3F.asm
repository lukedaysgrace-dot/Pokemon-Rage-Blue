SeafoamIslandsB3FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  43, DEWGONG
	db  42, SEEL
	db  42, GOLBAT
	db  44, SLOWBRO
	db  42, JYNX
	db  43, DEWGONG
	db  44, SLOWBRO
	db  42, GOLBAT
	db   44, SHELLDER
	db  44, SEEL
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  43, DEWGONG
	db  42, SEEL
	db  42, SWINUB
	db  44, SLOWBRO
	db  42, JYNX
	db  43, DEWGONG
	db  44, SLOWBRO
	db  42, GOLBAT
	db   44, SHELLDER
	db  44, GLACEON
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
