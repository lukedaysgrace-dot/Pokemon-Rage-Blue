CeruleanCaveB1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db  62, EXEGGUTOR
	db  62, VAPOREON
	db  62, JOLTEON
	db  66, FLAREON
	db  66, ALAKAZAM
	db  66, SEADRA
	db  63, CLOYSTER
	db  67, STARMIE
	db  65, CLOYSTER
	db  68, DRAGONITE
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db  62, EEVEE
	db  62, VAPOREON
	db  62, JOLTEON
	db  66, FLAREON
	db  66, ESPEON
	db  66, UMBREON
	db  63, STARMIE
	db  67, CLOYSTER
	db  65, SEADRA
	db  68, CLOYSTER
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

