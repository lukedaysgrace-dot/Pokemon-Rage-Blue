DEF OFF EQU $11
DEF ON  EQU $15

MACRO toggle_consts_for
	DEF TOGGLEMAP{\1}_ID EQU const_value
	DEF TOGGLEMAP{\1}_NAME EQUS "\1"
ENDM

; ToggleableObjectStates indexes (see data/maps/toggleable_objects.asm)
; This lists the object_events that can be toggled by ShowObject/HideObject.
; The constants marked with an X are never used, because those object_events
; are not toggled on/off in any map's script.
; (The X-ed ones are either items or static Pokemon encounters that deactivate
; after battle and are detected in wToggleableObjectList.)

	const_def

	toggle_consts_for PALLET_TOWN
	const TOGGLE_PALLET_TOWN_OAK               ; 00
	const TOGGLE_PALLET_TOWN_GREEN             ; 01
	const TOGGLE_PALLET_TOWN_MEW               ; 02

	toggle_consts_for VIRIDIAN_CITY
	const TOGGLE_LYING_OLD_MAN                 ; 01
	const TOGGLE_OLD_MAN                       ; 02

	toggle_consts_for PEWTER_CITY
	const TOGGLE_MUSEUM_GUY                    ; 04
	const TOGGLE_GYM_GUY                       ; 05

	toggle_consts_for CERULEAN_CITY
	const TOGGLE_CERULEAN_RIVAL                ; 06
	const TOGGLE_CERULEAN_ROCKET               ; 07
	const TOGGLE_CERULEAN_GUARD_1              ; 08
	const TOGGLE_CERULEAN_CAVE_GUY             ; 09
	const TOGGLE_CERULEAN_GUARD_2              ; 0A

	toggle_consts_for SAFFRON_CITY
	const TOGGLE_SAFFRON_CITY_1                ; 0B
	const TOGGLE_SAFFRON_CITY_2                ; 0C
	const TOGGLE_SAFFRON_CITY_3                ; 0D
	const TOGGLE_SAFFRON_CITY_4                ; 0E
	const TOGGLE_SAFFRON_CITY_5                ; 0F
	const TOGGLE_SAFFRON_CITY_6                ; 10
	const TOGGLE_SAFFRON_CITY_7                ; 11
	const TOGGLE_SAFFRON_CITY_8                ; 12
	const TOGGLE_SAFFRON_CITY_9                ; 13
	const TOGGLE_SAFFRON_CITY_A                ; 14
	const TOGGLE_SAFFRON_CITY_B                ; 15
	const TOGGLE_SAFFRON_CITY_C                ; 16
	const TOGGLE_SAFFRON_CITY_D                ; 17
	const TOGGLE_SAFFRON_CITY_E                ; 18
	const TOGGLE_SAFFRON_CITY_F                ; 19

	toggle_consts_for ROUTE_2
	const TOGGLE_ROUTE_2_ITEM_1                ; 1A X
	const TOGGLE_ROUTE_2_ITEM_2                ; 1B X

	toggle_consts_for ROUTE_4
	const TOGGLE_ROUTE_4_ITEM                  ; 1C X

	toggle_consts_for ROUTE_5
	const TOGGLE_ROUTE_5_GREEN                 ; 1D

	toggle_consts_for ROUTE_9
	const TOGGLE_ROUTE_9_ITEM                  ; 1E X

	toggle_consts_for ROUTE_12
	const TOGGLE_ROUTE_12_SNORLAX              ; 1F
	const TOGGLE_ROUTE_12_ITEM_1               ; 20 X
	const TOGGLE_ROUTE_12_ITEM_2               ; 21 X

	toggle_consts_for ROUTE_13
	const TOGGLE_ROUTE_13_MEW                  ; 22

	toggle_consts_for ROUTE_15
	const TOGGLE_ROUTE_15_ITEM                 ; 23 X

	toggle_consts_for ROUTE_16
	const TOGGLE_ROUTE_16_SNORLAX              ; 23

	toggle_consts_for ROUTE_22
	const TOGGLE_ROUTE_22_RIVAL_1              ; 24
	const TOGGLE_ROUTE_22_RIVAL_2              ; 25

	toggle_consts_for ROUTE_24
	const TOGGLE_NUGGET_BRIDGE_GUY             ; 26
	const TOGGLE_ROUTE_24_ITEM                 ; 27 X
	const TOGGLE_ROUTE_24_CHARMANDER           ; 28

	toggle_consts_for ROUTE_25
	const TOGGLE_ROUTE_25_ITEM                 ; 29 X
	const TOGGLE_ROUTE_25_GREEN                ; 2A

	toggle_consts_for BLUES_HOUSE
	const TOGGLE_DAISY_SITTING                 ; 2B
	const TOGGLE_DAISY_WALKING                 ; 2C
	const TOGGLE_TOWN_MAP                      ; 2D

	toggle_consts_for OAKS_LAB
	const TOGGLE_OAKS_LAB_RIVAL                ; 2E
	const TOGGLE_OAKS_LAB_GREEN                ; 2F
	const TOGGLE_STARTER_BALL_1                ; 30
	const TOGGLE_STARTER_BALL_2                ; 31
	const TOGGLE_STARTER_BALL_3                ; 32
	const TOGGLE_OAKS_LAB_OAK_1                ; 33
	const TOGGLE_POKEDEX_1                     ; 34
	const TOGGLE_POKEDEX_2                     ; 35
	const TOGGLE_OAKS_LAB_OAK_2                ; 36

	toggle_consts_for VIRIDIAN_GYM
	const TOGGLE_VIRIDIAN_GYM_GIOVANNI         ; 36
	const TOGGLE_VIRIDIAN_GYM_ITEM             ; 37 X

	toggle_consts_for MUSEUM_1F
	const TOGGLE_OLD_AMBER                     ; 37
	const TOGGLE_MUSEUM_1F_CYNDAQUIL

	toggle_consts_for CERULEAN_CAVE_1F
	const TOGGLE_CERULEAN_CAVE_1F_ITEM_1       ; 38 X
	const TOGGLE_CERULEAN_CAVE_1F_ITEM_2       ; 39 X
	const TOGGLE_CERULEAN_CAVE_1F_ITEM_3       ; 3A X

	toggle_consts_for POKEMON_TOWER_2F
	const TOGGLE_POKEMON_TOWER_2F_RIVAL        ; 3B

	toggle_consts_for POKEMON_TOWER_3F
	const TOGGLE_POKEMON_TOWER_3F_ITEM         ; 3A X

	toggle_consts_for POKEMON_TOWER_4F
	const TOGGLE_POKEMON_TOWER_4F_ITEM_1       ; 3B X
	const TOGGLE_POKEMON_TOWER_4F_ITEM_2       ; 3C X
	const TOGGLE_POKEMON_TOWER_4F_ITEM_3       ; 3D X

	toggle_consts_for POKEMON_TOWER_5F
	const TOGGLE_POKEMON_TOWER_5F_ITEM         ; 3E X

	toggle_consts_for POKEMON_TOWER_6F
	const TOGGLE_POKEMON_TOWER_6F_ITEM_1       ; 3F X
	const TOGGLE_POKEMON_TOWER_6F_ITEM_2       ; 40 X

	toggle_consts_for POKEMON_TOWER_7F
	const TOGGLE_POKEMON_TOWER_7F_ROCKET_1     ; 41 X
	const TOGGLE_POKEMON_TOWER_7F_ROCKET_2     ; 42 X
	const TOGGLE_POKEMON_TOWER_7F_ROCKET_3     ; 43 X
	const TOGGLE_POKEMON_TOWER_7F_MR_FUJI      ; 44

	toggle_consts_for CINNABAR_ISLAND
	const TOGGLE_CINNABAR_ISLAND_BLUE_CLOAK    ; 45

	toggle_consts_for MR_FUJIS_HOUSE
	const TOGGLE_MR_FUJIS_HOUSE_MR_FUJI        ; 45

	toggle_consts_for CELADON_MANSION_ROOF_HOUSE
	const TOGGLE_CELADON_MANSION_EEVEE_GIFT    ; 46

	toggle_consts_for GAME_CORNER
	const TOGGLE_GAME_CORNER_ROCKET            ; 47

	toggle_consts_for WARDENS_HOUSE
	const TOGGLE_WARDENS_HOUSE_ITEM            ; 48 X

	toggle_consts_for POKEMON_MANSION_1F
	const TOGGLE_POKEMON_MANSION_1F_ITEM_1     ; 49 X
	const TOGGLE_POKEMON_MANSION_1F_ITEM_2     ; 4A X

	toggle_consts_for FIGHTING_DOJO
	const TOGGLE_FIGHTING_DOJO_GIFT_1          ; 4B
	const TOGGLE_FIGHTING_DOJO_GIFT_2          ; 4C

	toggle_consts_for SILPH_CO_1F
	const TOGGLE_SILPH_CO_1F_RECEPTIONIST      ; 4D
	const TOGGLE_SILPH_CO_1F_PETREL

	toggle_consts_for POWER_PLANT
	const TOGGLE_VOLTORB_1                     ; 4E X
	const TOGGLE_VOLTORB_2                     ; 4F X
	const TOGGLE_VOLTORB_3                     ; 50 X
	const TOGGLE_ELECTRODE_1                   ; 51 X
	const TOGGLE_VOLTORB_4                     ; 52 X
	const TOGGLE_VOLTORB_5                     ; 53 X
	const TOGGLE_ELECTRODE_2                   ; 54 X
	const TOGGLE_VOLTORB_6                     ; 55 X
	const TOGGLE_ZAPDOS                        ; 56 X
	const TOGGLE_POWER_PLANT_ITEM_1            ; 57 X
	const TOGGLE_POWER_PLANT_ITEM_2            ; 58 X
	const TOGGLE_POWER_PLANT_ITEM_3            ; 59 X
	const TOGGLE_POWER_PLANT_ITEM_4            ; 5A X
	const TOGGLE_POWER_PLANT_ITEM_5            ; 5B X

	toggle_consts_for CERULEAN_TRADE_HOUSE
	const TOGGLE_CERULEAN_TRADE_HOUSE_BULBASAUR

	toggle_consts_for VERMILION_CITY
	const TOGGLE_VERMILION_CITY_SQUIRTLE

	toggle_consts_for VICTORY_ROAD_2F
	const TOGGLE_MOLTRES                       ; 5C X
	const TOGGLE_VICTORY_ROAD_2F_ITEM_1        ; 5D X
	const TOGGLE_VICTORY_ROAD_2F_ITEM_2        ; 5E X
	const TOGGLE_VICTORY_ROAD_2F_ITEM_3        ; 5F X
	const TOGGLE_VICTORY_ROAD_2F_ITEM_4        ; 60 X
	const TOGGLE_VICTORY_ROAD_2F_BOULDER       ; 61

	toggle_consts_for BILLS_HOUSE
	const TOGGLE_BILL_POKEMON                  ; 62
	const TOGGLE_BILL_1                        ; 63
	const TOGGLE_BILL_2                        ; 64

	toggle_consts_for VIRIDIAN_FOREST
	const TOGGLE_VIRIDIAN_FOREST_ITEM_1        ; 65 X
	const TOGGLE_VIRIDIAN_FOREST_ITEM_2        ; 66 X
	const TOGGLE_VIRIDIAN_FOREST_ITEM_3        ; 67 X

	toggle_consts_for MT_MOON_1F
	const TOGGLE_MT_MOON_1F_ITEM_1             ; 68 X
	const TOGGLE_MT_MOON_1F_ITEM_2             ; 69 X
	const TOGGLE_MT_MOON_1F_ITEM_3             ; 6A X
	const TOGGLE_MT_MOON_1F_ITEM_4             ; 6B X
	const TOGGLE_MT_MOON_1F_ITEM_5             ; 6C X
	const TOGGLE_MT_MOON_1F_ITEM_6             ; 6D X
	const TOGGLE_MT_MOON_1F_ITEM_7             ; 6E X

	toggle_consts_for MT_MOON_B2F
	const TOGGLE_MT_MOON_B2F_FOSSIL_1          ; 6E
	const TOGGLE_MT_MOON_B2F_FOSSIL_2          ; 6F
	const TOGGLE_MT_MOON_B2F_ITEM_1            ; 70 X
	const TOGGLE_MT_MOON_B2F_ITEM_2            ; 71 X
	const TOGGLE_MT_MOON_B2F_ITEM_3            ; 72 X

	toggle_consts_for SS_ANNE_2F
	const TOGGLE_SS_ANNE_2F_RIVAL              ; 72

	toggle_consts_for SS_ANNE_1F_ROOMS
	const TOGGLE_SS_ANNE_1F_ROOMS_ITEM         ; 73 X

	toggle_consts_for SS_ANNE_2F_ROOMS
	const TOGGLE_SS_ANNE_2F_ROOMS_ITEM_1       ; 74 X
	const TOGGLE_SS_ANNE_2F_ROOMS_ITEM_2       ; 75 X

	toggle_consts_for SS_ANNE_B1F_ROOMS
	const TOGGLE_SS_ANNE_B1F_ROOMS_ITEM_1      ; 76 X
	const TOGGLE_SS_ANNE_B1F_ROOMS_ITEM_2      ; 77 X
	const TOGGLE_SS_ANNE_B1F_ROOMS_ITEM_3      ; 78 X

	toggle_consts_for VICTORY_ROAD_3F
	const TOGGLE_VICTORY_ROAD_3F_ITEM_1        ; 79 X
	const TOGGLE_VICTORY_ROAD_3F_ITEM_2        ; 7A X
	const TOGGLE_VICTORY_ROAD_3F_BOULDER       ; 7B

	toggle_consts_for ROCKET_HIDEOUT_B1F
	const TOGGLE_ROCKET_HIDEOUT_B1F_ITEM_1     ; 7C X
	const TOGGLE_ROCKET_HIDEOUT_B1F_ITEM_2     ; 7D X

	toggle_consts_for ROCKET_HIDEOUT_B2F
	const TOGGLE_ROCKET_HIDEOUT_B2F_ITEM_1     ; 7E X
	const TOGGLE_ROCKET_HIDEOUT_B2F_ITEM_2     ; 7F X
	const TOGGLE_ROCKET_HIDEOUT_B2F_ITEM_3     ; 80 X
	const TOGGLE_ROCKET_HIDEOUT_B2F_ITEM_4     ; 81 X
	const TOGGLE_ROCKET_HIDEOUT_B2F_GREEN      ; GREEN (toggle)

	toggle_consts_for ROCKET_HIDEOUT_B3F
	const TOGGLE_ROCKET_HIDEOUT_B3F_ITEM_1     ; 82 X
	const TOGGLE_ROCKET_HIDEOUT_B3F_ITEM_2     ; 83 X

	toggle_consts_for ROCKET_HIDEOUT_B4F
	const TOGGLE_ROCKET_HIDEOUT_B4F_GIOVANNI   ; 84
	const TOGGLE_ROCKET_HIDEOUT_B4F_ITEM_1     ; 85 X
	const TOGGLE_ROCKET_HIDEOUT_B4F_ITEM_2     ; 86 X
	const TOGGLE_ROCKET_HIDEOUT_B4F_ITEM_3     ; 87 X
	const TOGGLE_ROCKET_HIDEOUT_B4F_ITEM_4     ; 88
	const TOGGLE_ROCKET_HIDEOUT_B4F_ITEM_5     ; 89

	toggle_consts_for SILPH_CO_2F
	const TOGGLE_SILPH_CO_2F_1                 ; 8A XXX never (de)activated?
	const TOGGLE_SILPH_CO_2F_2                 ; 8B
	const TOGGLE_SILPH_CO_2F_3                 ; 8C
	const TOGGLE_SILPH_CO_2F_4                 ; 8D
	const TOGGLE_SILPH_CO_2F_5                 ; 8E

	toggle_consts_for SILPH_CO_3F
	const TOGGLE_SILPH_CO_3F_1                 ; 8F
	const TOGGLE_SILPH_CO_3F_2                 ; 90
	const TOGGLE_SILPH_CO_3F_ITEM              ; 91 X
	const TOGGLE_SILPH_CO_3F_PROTON

	toggle_consts_for SILPH_CO_4F
	const TOGGLE_SILPH_CO_4F_1                 ; 92
	const TOGGLE_SILPH_CO_4F_2                 ; 93
	const TOGGLE_SILPH_CO_4F_3                 ; 94
	const TOGGLE_SILPH_CO_4F_ITEM_1            ; 95 X
	const TOGGLE_SILPH_CO_4F_ITEM_2            ; 96 X
	const TOGGLE_SILPH_CO_4F_ITEM_3            ; 97 X

	toggle_consts_for SILPH_CO_5F
	const TOGGLE_SILPH_CO_5F_1                 ; 98
	const TOGGLE_SILPH_CO_5F_2                 ; 99
	const TOGGLE_SILPH_CO_5F_3                 ; 9A
	const TOGGLE_SILPH_CO_5F_4                 ; 9B
	const TOGGLE_SILPH_CO_5F_ITEM_1            ; 9C X
	const TOGGLE_SILPH_CO_5F_ITEM_2            ; 9D X
	const TOGGLE_SILPH_CO_5F_ITEM_3            ; 9E X

	toggle_consts_for SILPH_CO_6F
	const TOGGLE_SILPH_CO_6F_1                 ; 9F
	const TOGGLE_SILPH_CO_6F_2                 ; A0
	const TOGGLE_SILPH_CO_6F_3                 ; A1
	const TOGGLE_SILPH_CO_6F_ITEM_1            ; A2 X
	const TOGGLE_SILPH_CO_6F_ITEM_2            ; A3 X

	toggle_consts_for SILPH_CO_7F
	const TOGGLE_SILPH_CO_7F_1                 ; A4
	const TOGGLE_SILPH_CO_7F_2                 ; A5
	const TOGGLE_SILPH_CO_7F_3                 ; A6
	const TOGGLE_SILPH_CO_7F_4                 ; A7
	const TOGGLE_SILPH_CO_7F_RIVAL             ; A8
	const TOGGLE_SILPH_CO_7F_ITEM_1            ; A9 X
	const TOGGLE_SILPH_CO_7F_ITEM_2            ; AA X
	const TOGGLE_SILPH_CO_7F_8                 ; AB XXX sprite doesn't exist

	toggle_consts_for SILPH_CO_8F
	const TOGGLE_SILPH_CO_8F_1                 ; AC
	const TOGGLE_SILPH_CO_8F_2                 ; AD
	const TOGGLE_SILPH_CO_8F_3                 ; AE

	toggle_consts_for SILPH_CO_9F
	const TOGGLE_SILPH_CO_9F_1                 ; AF
	const TOGGLE_SILPH_CO_9F_2                 ; B0
	const TOGGLE_SILPH_CO_9F_3                 ; B1

	toggle_consts_for SILPH_CO_10F
	const TOGGLE_SILPH_CO_10F_1                ; B2
	const TOGGLE_SILPH_CO_10F_2                ; B3
	const TOGGLE_SILPH_CO_10F_3                ; B4 XXX never (de)activated?
	const TOGGLE_SILPH_CO_10F_ITEM_1           ; B5 X
	const TOGGLE_SILPH_CO_10F_ITEM_2           ; B6 X
	const TOGGLE_SILPH_CO_10F_ITEM_3           ; B7 X

	toggle_consts_for SILPH_CO_11F
	const TOGGLE_SILPH_CO_11F_1                ; B8
	const TOGGLE_SILPH_CO_11F_2                ; B9
	const TOGGLE_SILPH_CO_11F_3                ; BA

	toggle_consts_for UNUSED_MAP_F4
	const TOGGLE_UNUSED_MAP_F4_1               ; BB XXX sprite doesn't exist

	toggle_consts_for POKEMON_MANSION_2F
	const TOGGLE_POKEMON_MANSION_2F_ITEM       ; BC X

	toggle_consts_for POKEMON_MANSION_3F
	const TOGGLE_POKEMON_MANSION_3F_ITEM_1     ; BD X
	const TOGGLE_POKEMON_MANSION_3F_ITEM_2     ; BE X

	toggle_consts_for POKEMON_MANSION_B1F
	const TOGGLE_POKEMON_MANSION_B1F_ITEM_1    ; BF X
	const TOGGLE_POKEMON_MANSION_B1F_ITEM_2    ; C0 X
	const TOGGLE_POKEMON_MANSION_B1F_ITEM_3    ; C1 X
	const TOGGLE_POKEMON_MANSION_B1F_ITEM_4    ; C2 X
	const TOGGLE_POKEMON_MANSION_B1F_ITEM_5    ; C3 X
	const TOGGLE_POKEMON_MANSION_B1F_GREEN     ; C4
	const TOGGLE_POKEMON_MANSION_B1F_MEW       ; C5
	const TOGGLE_POKEMON_MANSION_B1F_BALL      ; C6

	toggle_consts_for SAFARI_ZONE_EAST
	const TOGGLE_SAFARI_ZONE_EAST_ITEM_1       ; C7 X
	const TOGGLE_SAFARI_ZONE_EAST_ITEM_2       ; C8 X
	const TOGGLE_SAFARI_ZONE_EAST_ITEM_3       ; C9 X
	const TOGGLE_SAFARI_ZONE_EAST_ITEM_4       ; CA X

	toggle_consts_for SAFARI_ZONE_NORTH
	const TOGGLE_SAFARI_ZONE_NORTH_ITEM_1      ; C8 X
	const TOGGLE_SAFARI_ZONE_NORTH_ITEM_2      ; C9 X

	toggle_consts_for SAFARI_ZONE_WEST
	const TOGGLE_SAFARI_ZONE_WEST_ITEM_1       ; CA X
	const TOGGLE_SAFARI_ZONE_WEST_ITEM_2       ; CB X
	const TOGGLE_SAFARI_ZONE_WEST_ITEM_3       ; CC X
	const TOGGLE_SAFARI_ZONE_WEST_ITEM_4       ; CD X

	toggle_consts_for SAFARI_ZONE_CENTER
	const TOGGLE_SAFARI_ZONE_CENTER_ITEM       ; CE X

	toggle_consts_for CERULEAN_CAVE_2F
	const TOGGLE_CERULEAN_CAVE_2F_ITEM_1       ; CF X
	const TOGGLE_CERULEAN_CAVE_2F_ITEM_2       ; D0 X
	const TOGGLE_CERULEAN_CAVE_2F_ITEM_3       ; D1 X

	toggle_consts_for CERULEAN_CAVE_B1F
	const TOGGLE_MEWTWO                        ; D2 X
	const TOGGLE_CERULEAN_CAVE_B1F_ITEM_1      ; D3 X
	const TOGGLE_CERULEAN_CAVE_B1F_ITEM_2      ; D4 X

	toggle_consts_for VICTORY_ROAD_1F
	const TOGGLE_VICTORY_ROAD_1F_ITEM_1        ; D5 X
	const TOGGLE_VICTORY_ROAD_1F_ITEM_2        ; D6 X

	toggle_consts_for CHAMPIONS_ROOM
	const TOGGLE_CHAMPIONS_ROOM_OAK            ; D7

	toggle_consts_for SEAFOAM_ISLANDS_1F
	const TOGGLE_SEAFOAM_ISLANDS_1F_BOULDER_1  ; D8
	const TOGGLE_SEAFOAM_ISLANDS_1F_BOULDER_2  ; D9

	toggle_consts_for SEAFOAM_ISLANDS_B1F
	const TOGGLE_SEAFOAM_ISLANDS_B1F_BOULDER_1 ; DA
	const TOGGLE_SEAFOAM_ISLANDS_B1F_BOULDER_2 ; DB

	toggle_consts_for SEAFOAM_ISLANDS_B2F
	const TOGGLE_SEAFOAM_ISLANDS_B2F_BOULDER_1 ; DC
	const TOGGLE_SEAFOAM_ISLANDS_B2F_BOULDER_2 ; DD

	toggle_consts_for SEAFOAM_ISLANDS_B3F
	const TOGGLE_SEAFOAM_ISLANDS_B3F_BOULDER_1 ; DE
	const TOGGLE_SEAFOAM_ISLANDS_B3F_BOULDER_2 ; DF
	const TOGGLE_SEAFOAM_ISLANDS_B3F_BOULDER_3 ; E0
	const TOGGLE_SEAFOAM_ISLANDS_B3F_BOULDER_4 ; E1

	toggle_consts_for SEAFOAM_ISLANDS_B4F
	const TOGGLE_SEAFOAM_ISLANDS_B4F_BOULDER_1 ; E2
	const TOGGLE_SEAFOAM_ISLANDS_B4F_BOULDER_2 ; E3
	const TOGGLE_ARTICUNO                      ; E4 X

	toggle_consts_for ROUTE_10
	const TOGGLE_ROUTE_10_GREEN                ; E5

	toggle_consts_for INDIGO_PLATEAU_LOBBY
	const TOGGLE_INDIGO_PLATEAU_LOBBY_GREEN

	toggle_consts_for FUCHSIA_GYM
	const TOGGLE_FUCHSIA_GYM_JANINE            ; E6

	toggle_consts_for BIKE_SHOP
	const TOGGLE_BIKE_SHOP_TOTODILE

	toggle_consts_for VERMILION_TRADE_HOUSE
	const TOGGLE_VERMILION_TRADE_HOUSE_CHIKORITA

DEF NUM_TOGGLEABLE_OBJECTS EQU const_value
