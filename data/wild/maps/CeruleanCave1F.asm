CeruleanCave1FWildMons:
IF DEF(_RED)
	def_grass_wildmons 10 ; encounter rate
	db  46, NIDOKING
	db  46, NIDOQUEEN
	db  46, ALAKAZAM
	db  49, SANDSLASH
	db  49, VICTREEBEL
	db  52, VENOMOTH
	db  49, WIGGLYTUFF
	db  52, CLEFABLE
	db  53, NINETALES
	db  53, DITTO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC

IF DEF(_BLUE)
	def_grass_wildmons 10 ; encounter rate
	db  46, NIDOKING
	db  46, NIDOQUEEN
	db  46, ALAKAZAM
	db  49, SANDSLASH
	db  49, VICTREEBEL
	db  52, VENOMOTH
	db  49, CUFANT
	db  49, TOXEL
	db  53, NINETALES
	db  53, DITTO
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
ENDC
