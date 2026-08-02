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

; Pallet / Viridian — pre-Brock
.Group1R:
	db 2
	db   10, TENTACOOL
	db   10, POLIWAG

; Route 22 — pre-Brock
.Group2R:
	db 2
	db   10, GOLDEEN
	db   10, POLIWAG

; Cerulean / Routes 4, 24, 25 — Misty era
.Group3R:
	db 3
	db   15, PSYDUCK
	db   15, GOLDEEN
	db   16, KRABBY

; Vermilion / Routes 6, 11 — Surge era
.Group4R:
	db 2
	db   17, KRABBY
	db   17, SHELLDER

; Celadon / Route 10 — Erika era
.Group5R:
	db 2
	db    21, POLIWAG
	db   20, SLOWPOKE

; Safari Zone — Koga era
.Group6R:
	db 4
	db   34, DRATINI
	db   36, KRABBY
	db   36, PSYDUCK
	db   36, SLOWPOKE

; Routes 12, 13, 17, 18 — mid-game ramp
.Group7R:
	db 4
	db     29, TENTACOOL
	db   30, KRABBY
	db   30, GOLDEEN
	db    31, HORSEA

; Cinnabar / Routes 19-21 / Seafoam — post-Surf
.Group8R:
	db 4
	db   40, STARYU
	db   40, HORSEA
	db    41, SHELLDER
	db    41, HORSEA

; Route 23 / Cerulean Cave — endgame
.Group9R:
	db 4
	db   52, SLOWBRO
	db   51, SEAKING
	db   50, KINGLER
	db   50, SEADRA

; Fuchsia — Koga era
.Group10R:
	db 4
	db    35, GOLDEEN
	db   34, KRABBY
	db   34, GOLDEEN
	db   34, MAGIKARP
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

; Pallet / Viridian — pre-Brock
.Group1B:
	db 2
	db   10, TENTACOOL
	db   10, POLIWAG

; Route 22 — pre-Brock
.Group2B:
	db 2
	db   10, GOLDEEN
	db   10, POLIWAG

; Cerulean / Routes 4, 24, 25 — Misty era
.Group3B:
	db 3
	db   15, PSYDUCK
	db   15, GOLDEEN
	db   16, KRABBY

; Vermilion / Routes 6, 11 — Surge era
.Group4B:
	db 2
	db   17, KRABBY
	db   17, SHELLDER

; Celadon / Route 10 — Erika era
.Group5B:
	db 2
	db    21, POLIWAG
	db   20, SLOWPOKE

; Safari Zone — Koga era
.Group6B:
	db 4
	db   34, DRATINI
	db   36, KRABBY
	db   36, PSYDUCK
	db    37, HORSEA

; Routes 12, 13, 17, 18 — mid-game ramp
.Group7B:
	db 4
	db     29, TENTACOOL
	db   30, KRABBY
	db   30, GOLDEEN
	db    31, HORSEA

; Cinnabar / Routes 19-21 / Seafoam — post-Surf
.Group8B:
	db 4
	db   40, STARYU
	db   40, HORSEA
	db    41, SHELLDER
	db    41, HORSEA

; Route 23 / Cerulean Cave — endgame
.Group9B:
	db 4
	db   52, SLOWBRO
	db   51, SEAKING
	db   50, KINGLER
	db    52, SEADRA

; Fuchsia — Koga era
.Group10B:
	db 4
	db    35, GOLDEEN
	db   34, KRABBY
	db   34, GOLDEEN
	db   34, MAGIKARP
ENDC
