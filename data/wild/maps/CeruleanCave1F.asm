CeruleanCave1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  55, NIDOKING
	db  55, NIDOQUEEN
	db  55, ALAKAZAM
	db  57, SANDSLASH
	db  57, VICTREEBEL
	db  59, VENOMOTH
	db  57, WIGGLYTUFF
	db  59, CLEFABLE
	db  60, NINETALES
	db  60, DITTO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  55, NIDOKING
	db  55, NIDOQUEEN
	db  55, ALAKAZAM
	db  57, SANDSLASH
	db  57, VICTREEBEL
	db  59, VENOMOTH
	db  57, AMPHAROS
	db  57, PAWNIARD
	db  60, NINETALES
	db  60, DITTO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
