PokemonTower2FWildMons:
; No wild encounters on Pokemon Tower 1F/2F by design.
; A rate-0 block must contain no mon entries (the wildmons asserts in
; macros/asserts.asm enforce this): a 0 rate byte followed by a mon list makes
; LoadWildData skip grass and read that list as the water table instead.
; Previous unused draft lists kept here for reference only:
; Red db  17, GASTLY
; Red db  18, GASTLY
; Red db  19, GASTLY
; Red db  19, CUBONE
; Red db  16, ZUBAT
; Red db  15, GASTLY
; Red db  19, CUBONE
; Red db  19, ZUBAT
; Red db  19, GASTLY
; Red db  19, CUBONE
; Blue db  17, GASTLY
; Blue db  18, GASTLY
; Blue db  19, GASTLY
; Blue db  19, CUBONE
; Blue db  16, DUSKULL
; Blue db  15, DUSKULL
; Blue db  19, CUBONE
; Blue db  19, ZUBAT
; Blue db  19, GASTLY
; Blue db  19, CUBONE
	def_grass_wildmons 0 ; encounter rate
	end_grass_wildmons

	def_water_wildmons 0 ; encounter rate
	end_water_wildmons
