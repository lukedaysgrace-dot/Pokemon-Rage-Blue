Route17WildMons:
IF DEF(_RED)
	def_grass_wildmons 25 ; encounter rate
	db  20, FEAROW
	db  22, PONYTA
	db  25, RATICATE
	db  24, DODUO
	db   26, PIDGEOTTO
	db  26, FEAROW
	db   26, DODUO
	db   26, PONYTA
	db  25, PONYTA
	db   26, PONYTA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 25 ; encounter rate
	db  20, FEAROW
	db  22, PONYTA
	db  25, RATICATE
	db  24, DODUO
	db   26, PIDGEOTTO
	db  26, FEAROW
	db   26, DODUO
	db   26, PONYTA
	db  25, PONYTA
	db   26, PONYTA
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
