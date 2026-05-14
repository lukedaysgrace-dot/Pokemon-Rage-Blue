CeruleanCaveB1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db  55, EXEGGUTOR
	db  55, VAPOREON
	db  55, JOLTEON
	db  64, FLAREON
	db  64, ALAKAZAM
	db  64, SEADRA
	db  57, CLOYSTER
	db  65, STARMIE
	db  63, CLOYSTER
	db  67, DRAGONITE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db  55, EEVEE
	db  55, VAPOREON
	db  55, JOLTEON
	db  64, FLAREON
	db  64, ESPEON
	db  64, UMBREON
	db  57, STARMIE
	db  65, CLOYSTER
	db  63, SEADRA
	db  67, CLOYSTER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

