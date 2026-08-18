PokemonTower1FWildMons:
; No wild encounters on Pokemon Tower 1F/2F by design.
; A rate-0 block must contain no mon entries (the wildmons asserts in
; macros/asserts.asm enforce this): a 0 rate byte followed by a mon list makes
; LoadWildData skip grass and read that list as the water table instead.
; Previous unused draft lists kept here for reference only:
; Red db  15, GASTLY
; Red db  16, GASTLY
; Red db  17, GASTLY
; Red db  17, CUBONE
; Red db  14, GASTLY
; Red db  13, CUBONE
; Red db  17, GASTLY
; Red db  15, ZUBAT
; Red db  17, GASTLY
; Red db  17, ZUBAT
; Blue db  15, GASTLY
; Blue db  16, GASTLY
; Blue db  17, DUSKULL
; Blue db  17, CUBONE
; Blue db  14, DUSKULL
; Blue db  13, CUBONE
; Blue db  17, MISDREAVUS
; Blue db  15, ZUBAT
; Blue db  17, GASTLY
; Blue db  17, ZUBAT
	def_grass_wildmons 0 ; encounter rate
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
