; super rod encounters
SuperRodData:
IF DEF(_RED)
	dbw PALLET_TOWN,         .Group1R
	dbw VIRIDIAN_CITY,       .Group1R
	dbw CERULEAN_CITY,       .Group3R
	dbw VERMILION_CITY,      .Group4R
	dbw CELADON_CITY,        .Group5R
	dbw FUCHSIA_CITY,        .Group10R
	dbw CINNABAR_ISLAND,     .Group8R
	dbw ROUTE_4,             .Group3R
	dbw ROUTE_6,             .Group4R
	dbw ROUTE_10,            .Group5R
	dbw ROUTE_11,            .Group4R
	dbw ROUTE_12,            .Group7R
	dbw ROUTE_13,            .Group7R
	dbw ROUTE_17,            .Group7R
	dbw ROUTE_18,            .Group7R
	dbw ROUTE_19,            .Group8R
	dbw ROUTE_20,            .Group8R
	dbw ROUTE_21,            .Group8R
	dbw ROUTE_22,            .Group2R
	dbw ROUTE_23,            .Group9R
	dbw ROUTE_24,            .Group3R
	dbw ROUTE_25,            .Group3R
	dbw CERULEAN_GYM,        .Group3R
	dbw VERMILION_DOCK,      .Group4R
	dbw SEAFOAM_ISLANDS_B3F, .Group8R
	dbw SEAFOAM_ISLANDS_B4F, .Group8R
	dbw SAFARI_ZONE_EAST,    .Group6R
	dbw SAFARI_ZONE_NORTH,   .Group6R
	dbw SAFARI_ZONE_WEST,    .Group6R
	dbw SAFARI_ZONE_CENTER,  .Group6R
	dbw CERULEAN_CAVE_2F,    .Group9R
	dbw CERULEAN_CAVE_B1F,   .Group9R
	dbw CERULEAN_CAVE_1F,    .Group9R
	db -1 ; end

.Group1R:
	db 2
	db   15, TENTACOOL
	db   15, POLIWAG

.Group2R:
	db 2
	db   15, GOLDEEN
	db   15, POLIWAG

.Group3R:
	db 3
	db   15, PSYDUCK
	db   15, GOLDEEN
	db   15, KRABBY

.Group4R:
	db 2
	db   15, KRABBY
	db   15, SHELLDER

.Group5R:
	db 2
	db    19, POLIWAG
	db   15, SLOWPOKE

.Group6R:
	db 4
	db   15, DRATINI
	db   15, KRABBY
	db   15, PSYDUCK
	db   15, SLOWPOKE

.Group7R:
	db 4
	db     5, TENTACOOL
	db   15, KRABBY
	db   15, GOLDEEN
	db    15, HORSEA

.Group8R:
	db 4
	db   15, STARYU
	db   15, HORSEA
	db    19, SHELLDER
	db    19, HORSEA

.Group9R:
	db 4
	db   37, SLOWBRO
	db   33, SEAKING
	db   28, KINGLER
	db   23, SEADRA

.Group10R:
	db 4
	db    19, GOLDEEN
	db   15, KRABBY
	db   15, GOLDEEN
	db   15, MAGIKARP
ENDC
IF DEF(_BLUE)
	dbw PALLET_TOWN,         .Group1B
	dbw VIRIDIAN_CITY,       .Group1B
	dbw CERULEAN_CITY,       .Group3B
	dbw VERMILION_CITY,      .Group4B
	dbw CELADON_CITY,        .Group5B
	dbw FUCHSIA_CITY,        .Group10B
	dbw CINNABAR_ISLAND,     .Group8B
	dbw ROUTE_4,             .Group3B
	dbw ROUTE_6,             .Group4B
	dbw ROUTE_10,            .Group5B
	dbw ROUTE_11,            .Group4B
	dbw ROUTE_12,            .Group7B
	dbw ROUTE_13,            .Group7B
	dbw ROUTE_17,            .Group7B
	dbw ROUTE_18,            .Group7B
	dbw ROUTE_19,            .Group8B
	dbw ROUTE_20,            .Group8B
	dbw ROUTE_21,            .Group8B
	dbw ROUTE_22,            .Group2B
	dbw ROUTE_23,            .Group9B
	dbw ROUTE_24,            .Group3B
	dbw ROUTE_25,            .Group3B
	dbw CERULEAN_GYM,        .Group3B
	dbw VERMILION_DOCK,      .Group4B
	dbw SEAFOAM_ISLANDS_B3F, .Group8B
	dbw SEAFOAM_ISLANDS_B4F, .Group8B
	dbw SAFARI_ZONE_EAST,    .Group6B
	dbw SAFARI_ZONE_NORTH,   .Group6B
	dbw SAFARI_ZONE_WEST,    .Group6B
	dbw SAFARI_ZONE_CENTER,  .Group6B
	dbw CERULEAN_CAVE_2F,    .Group9B
	dbw CERULEAN_CAVE_B1F,   .Group9B
	dbw CERULEAN_CAVE_1F,    .Group9B
	db -1 ; end

.Group1B:
	db 2
	db   15, TENTACOOL
	db   15, POLIWAG

.Group2B:
	db 2
	db   15, GOLDEEN
	db   15, POLIWAG

.Group3B:
	db 3
	db   15, PSYDUCK
	db   15, GOLDEEN
	db   15, KRABBY

.Group4B:
	db 2
	db   15, KRABBY
	db   15, SHELLDER

.Group5B:
	db 2
	db    19, POLIWAG
	db   15, SLOWPOKE

.Group6B:
	db 4
	db   15, DRATINI
	db   15, KRABBY
	db   15, PSYDUCK
	db    19, HORSEA

.Group7B:
	db 4
	db     5, TENTACOOL
	db   15, KRABBY
	db   15, GOLDEEN
	db    15, HORSEA

.Group8B:
	db 4
	db   15, STARYU
	db   15, HORSEA
	db    19, SHELLDER
	db    19, HORSEA

.Group9B:
	db 4
	db   37, SLOWBRO
	db   33, SEAKING
	db   28, KINGLER
	db    37, SEADRA

.Group10B:
	db 4
	db    19, GOLDEEN
	db   15, KRABBY
	db   15, GOLDEEN
	db   15, MAGIKARP
ENDC
