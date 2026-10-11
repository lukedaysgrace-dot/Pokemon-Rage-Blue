; Palette and tile data from jojobear13/shinpokered, func_enhancedcolor.asm.
; See color/README.md for source revision and integration details.

MACRO ShinGBCEnh_Dark1
		dw (11 << 10 | 5 << 5 | 7)
ENDM
MACRO ShinGBCEnh_Dark2
		dw (6 << 10 | 3 << 5 | 3)
ENDM

MACRO ShinGBCEnh_Black
		dw (3 << 10 | 3 << 5 | 3)
ENDM
MACRO ShinGBCEnh_White
		dw (31 << 10 | 31 << 5 | 31)
ENDM

	const_def

	const ShinPAL_ENH_OVW_RED     	; $00
	const ShinPAL_ENH_OVW_PINK  	; $01
	const ShinPAL_ENH_OVW_PURPLE 	; $02
	const ShinPAL_ENH_OVW_GRAY   	; $03
	const ShinPAL_ENH_OVW_GREEN    	; $04
	const ShinPAL_ENH_OVW_YELLOW  	; $05
	const ShinPAL_ENH_OVW_BROWN    	; $06
	const ShinPAL_ENH_OVW_BLUE  	; $07

ShinGBCEnhancedOverworldPalettes:	
	; ShinPAL_ENH_OVW_RED     	; $00
	ShinGBCEnh_White
	RGB 31, 10,  0
	RGB 21,  0,  0
	ShinGBCEnh_Black
	
	; ShinPAL_ENH_OVW_PINK  	; $01
	ShinGBCEnh_White
	RGB 31, 15, 18
	RGB 31,  0,  6
	ShinGBCEnh_Black

	; ShinPAL_ENH_OVW_PURPLE 	; $02
	ShinGBCEnh_White
	RGB 25, 15, 31
	RGB 19,  0, 22
	ShinGBCEnh_Black

	; ShinPAL_ENH_OVW_GRAY   	; $03
	ShinGBCEnh_White
	RGB 20, 23, 10
	RGB 11, 11,  5
	ShinGBCEnh_Black

	; ShinPAL_ENH_OVW_GREEN    	; $04
	ShinGBCEnh_White
	RGB 17, 31, 11
	RGB  1, 22,  6
	ShinGBCEnh_Black
	
	; ShinPAL_ENH_OVW_YELLOW  	; $05
	ShinGBCEnh_White
	RGB 31, 31,  0
	RGB 28, 14,  0
	ShinGBCEnh_Black

	; ShinPAL_ENH_OVW_BROWN    	; $06
	ShinGBCEnh_White
	RGB 22, 16,  5
	RGB 15,  7,  3
	ShinGBCEnh_Black

	; ShinPAL_ENH_OVW_BLUE  	; $07
	ShinGBCEnh_White
	RGB 12, 14, 31
	RGB  0,  1, 25
	ShinGBCEnh_Black


	
ShinGBCEnhancedOverworldPalettes_ColdCavern:	;just used for seafoam islands for aesthetic
	; ShinPAL_ENH_OVW_RED     	; $00
	ShinGBCEnh_White
	RGB 31, 10,  0
	RGB 21,  0,  0
	ShinGBCEnh_Black
	
	; ShinPAL_ENH_OVW_PINK  	; $01
	ShinGBCEnh_White
	RGB 31, 15, 18
	RGB 31,  0,  6
	ShinGBCEnh_Black

	; ShinPAL_ENH_OVW_PURPLE 	; $02
	ShinGBCEnh_White
	RGB 25, 15, 31
	RGB 19,  0, 22
	ShinGBCEnh_Black

	; ShinPAL_ENH_OVW_GRAY   	; $03
	ShinGBCEnh_White
	RGB $12, $12, $18
	RGB $A, $A,  $F
	ShinGBCEnh_Black

	; ShinPAL_ENH_OVW_GREEN    	; $04
	ShinGBCEnh_White
	RGB 17, 31, 11
	RGB  1, 22,  6
	ShinGBCEnh_Black
	
	; ShinPAL_ENH_OVW_YELLOW  	; $05
	ShinGBCEnh_White
	RGB 31, 31,  0
	RGB 28, 14,  0
	ShinGBCEnh_Black

	; ShinPAL_ENH_OVW_BROWN    	; $06
	ShinGBCEnh_White
	RGB $10, $5, $16
	RGB $7, $3,  $F
	ShinGBCEnh_Black

	; ShinPAL_ENH_OVW_BLUE  	; $07
	ShinGBCEnh_White
	RGB 12, 14, 31
	RGB  0,  1, 25
	ShinGBCEnh_Black


	
ShinGBCEnhancedOverworldPalettes_DarkCavern:	;palette set used for darkened areas like Rock Tunnel

	; ShinPAL_ENH_OVW_RED     	; $00
	ShinGBCEnh_White
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark2
	
	; ShinPAL_ENH_OVW_PINK  	; $01
	ShinGBCEnh_White
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark2

	; ShinPAL_ENH_OVW_PURPLE 	; $02
	ShinGBCEnh_White
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark2

	; ShinPAL_ENH_OVW_GRAY   	; $03
	ShinGBCEnh_White
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark2

	; ShinPAL_ENH_OVW_GREEN    	; $04
	ShinGBCEnh_White
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark2
	
	; ShinPAL_ENH_OVW_YELLOW  	; $05
	ShinGBCEnh_White
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark2

	; ShinPAL_ENH_OVW_BROWN    	; $06
	ShinGBCEnh_White
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark2

	; ShinPAL_ENH_OVW_BLUE  	; $07
	ShinGBCEnh_White
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark1
	ShinGBCEnh_Dark2


	
ShinOverworldTilePalPointers:
	dw ShinPalSettings_OVERWORLD    ; 0
	dw ShinPalSettings_REDS_HOUSE_1 ; 1
	dw ShinPalSettings_MART         ; 2
	dw ShinPalSettings_FOREST       ; 3
	dw ShinPalSettings_REDS_HOUSE_2 ; 4
	dw ShinPalSettings_DOJO         ; 5
	dw ShinPalSettings_POKECENTER   ; 6
	dw ShinPalSettings_GYM          ; 7
	dw ShinPalSettings_HOUSE        ; 8
	dw ShinPalSettings_FOREST_GATE  ; 9
	dw ShinPalSettings_MUSEUM       ; 10
	dw ShinPalSettings_UNDERGROUND  ; 11
	dw ShinPalSettings_GATE         ; 12
	dw ShinPalSettings_SHIP         ; 13
	dw ShinPalSettings_SHIP_PORT    ; 14
	dw ShinPalSettings_CEMETERY     ; 15
	dw ShinPalSettings_INTERIOR     ; 16
	dw ShinPalSettings_CAVERN       ; 17
	dw ShinPalSettings_LOBBY        ; 18
	dw ShinPalSettings_MANSION      ; 19
	dw ShinPalSettings_LAB          ; 20
	dw ShinPalSettings_CLUB         ; 21
	dw ShinPalSettings_FACILITY     ; 22
	dw ShinPalSettings_PLATEAU      ; 23

;Assign a color register to be used for each tile in every tileset.
;A value of 8 is a "wild card" to set the color register based on the current town.
ShinPalSettings_OVERWORLD:   	; 0		- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	6,	6,	1,	6,	8,	8,	8,	8,	8,	3,	6,	6,	3,	6,	3;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	3,	6,	8,	6,	7,	8,	8,	8,	8,	8,	3,	6,	6,	3,	6,	3;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	3,	3,	3,	3,	6,	8,	8,	6,	8,	8,	3,	3,	4,	4,	4,	3;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	4,	6,	6,	6,	6,	6,	6,	6,	8,	4,	3,	3,	6,	4,	4,	3;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	4,	4,	0,	0,	7,	7,	6,	6,	6,	6,	3,	3,	8,	8,	3,	3;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	4,	4,	4,	8,	6,	6,	6,	6,	6,	6,	8,	0,	8,	8,	3,	3;
ShinPalSettings_REDS_HOUSE_1:	; 1		-done
ShinPalSettings_REDS_HOUSE_2:	; 4
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	6,	3,	3,	3,	2,	3,	7,	7,	4,	4,	6,	6,	6,	6,	3,	3;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	3,	3,	3,	3,	2,	3,	7,	7,	6,	6,	6,	6,	6,	6,	3,	3;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	3,	3,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	3,	3,	6;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	6,	6,	3,	3,	4,	4,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	3,	3,	3;
ShinPalSettings_FOREST:      	; 3		- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	4,	3,	6,	6,	4,	4,	4,	4,	6,	6,	3,	3,	6,	6,	6,	6;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	0,	0,	6,	6,	7,	4,	4,	4,	6,	6,	3,	3,	6,	6,	6,	6;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	4,	6,	6,	4,	4,	4,	4,	4,	6,	6,	6,	6,	6,	6,	6,	6;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	4,	6,	6,	3,	4,	6,	6,	3,	6,	4,	6,	6,	6,	6,	6,	6;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	3,	3,	3,	3,	6,	6,	6,	6,	6,	6,	6,	3,	3,	6,	6,	6;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	6,	6,	6,	6,	4,	4,	4,	4,	6,	6,	6,	6,	6,	6,	4,	4;
ShinPalSettings_MART:        	; 2
ShinPalSettings_POKECENTER:  	; 6		- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	4,	1,	1,	6,	6,	3,	3,	6,	3,	6,	4,	2,	3,	6,	6;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	6,	4,	1,	1,	6,	6,	3,	6,	5,	5,	3,	4,	2,	6,	6,	6;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	4,	4,	6,	6,	0,	0,	0,	0,	6,	6,	0,	0,	7,	7,	7,	7;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	4,	4,	6,	6,	0,	0,	3,	0,	6,	3,	6,	6,	3,	0,	7,	7;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	3,	3,	3,	3,	3,	3,	3,	3,	3,	3,	6,	6,	6,	6,	5,	5;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	3,	3,	3,	3,	3,	3,	3,	3,	3,	6,	0,	0,	3,	3,	3,	3;
ShinPalSettings_DOJO:        	; 5
ShinPalSettings_GYM:          	; 7		- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	6,	6,	1,	6,	7,	5,	6,	6,	7,	7,	6,	6,	3,	3,	3;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	7,	6,	6,	6,	7,	6,	5,	6,	6,	7,	7,	6,	6,	3,	3,	6;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	6,	6,	3,	3,	3,	3,	3,	3,	0,	3,	3,	4,	4,	4,	4,	4;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	6,	6,	3,	3,	7,	3,	3,	3,	6,	3,	7,	3,	2,	2,	7,	6;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	4,	4,	7,	7,	7,	7,	7,	7,	3,	3,	3,	3,	2,	2,	3,	3;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	4,	4,	7,	7,	7,	3,	7,	7,	6,	6,	6,	3,	3,	3,	3,	3;
ShinPalSettings_HOUSE:        	; 8		- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	6,	3,	3,	3,	1,	3,	7,	7,	4,	4,	4,	4,	4,	4,	6,	6;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	3,	3,	3,	3,	1,	3,	7,	7,	6,	6,	6,	6,	3,	3,	6,	6;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	3,	3,	2,	6,	6,	6,	6,	6,	6,	6,	4,	4,	6,	6,	6,	6;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	6,	6,	3,	3,	3,	3,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	3,	3;
ShinPalSettings_FOREST_GATE:  	; 9
ShinPalSettings_MUSEUM:       	; 10
ShinPalSettings_GATE:         	; 12	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	6,	4,	3,	3,	7,	4,	4,	4,	4,	4,	3,	3,	3,	3,	3,	3;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	3,	3,	3,	3,	7,	4,	4,	4,	4,	7,	3,	3,	3,	3,	3,	3;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	3,	3,	3,	3,	3,	6,	6,	7,	7,	6,	6,	6,	7,	7,	7,	4;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	7,	7,	6,	6,	3,	6,	6,	7,	7,	3,	7,	6,	7,	7,	7,	3;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	3,	3,	3,	3,	3,	3,	7,	7,	1,	3,	1,	3,	3,	3,	2,	2;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	3,	3,	3,	3,	3,	3,	3,	3,	3,	3,	3,	3,	3,	3,	7,	3;
ShinPalSettings_UNDERGROUND:  	; 11	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	2,	7,	1,	1,	7,	7,	7,	7,	7,	7,	1,	1,	0,	0,	0;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	3,	7,	7,	1,	1,	1,	7,	7,	1,	0,	0,	0,	0,	0,	0,	0;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0;
ShinPalSettings_SHIP:         	; 13	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	3,	7,	7,	6,	3,	3,	7,	7,	3,	3,	3,	3,	7,	0,	0;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	3,	0,	7,	7,	7,	3,	3,	7,	7,	3,	3,	3,	3,	7,	0,	0;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	3,	3,	0,	6,	0,	3,	3,	3,	3,	3,	3,	0,	3,	3,	5,	5;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	7,	7,	0,	3,	0,	3,	0,	3,	3,	3,	3,	3,	3,	3,	5,	5;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	3,	3,	7,	7,	3,	3,	3,	3,	7,	7,	6,	3,	3,	3,	3,	3;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	3,	3,	3,	3,	7,	7,	3,	3,	7,	7,	3,	3,	3,	3,	3,	3;
ShinPalSettings_SHIP_PORT:    	; 14	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	7,	0,	7,	7,	7,	7,	7,	7,	7,	7,	6,	7,	7,	7,	7,	7;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	7,	3,	6,	7,	7,	7,	7,	7,	7,	7,	6,	6,	6,	7,	7,	7;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	7,	7,	7,	7,	7,	7,	7,	7,	6,	6,	6,	6,	6,	7,	7,	7;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	0,	7,	7,	7,	7,	7,	0,	0,	6,	6,	7,	7,	7,	7,	7,	7;
ShinPalSettings_CEMETERY:     	; 15	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	2,	6,	3,	3,	3,	3,	6,	6,	3,	3,	3,	3,	6,	6,	4;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	4,	3,	6,	3,	3,	3,	3,	6,	6,	3,	3,	3,	3,	6,	6,	4;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	4,	4,	7,	4,	3,	3,	6,	2,	6,	6,	2,	2,	2,	2,	2,	2;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	4,	4,	4,	4,	3,	6,	6,	2,	6,	6,	2,	2,	2,	3,	3,	2;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	3,	3,	4,	3,	6,	6,	6,	3,	6,	6,	3,	3,	3,	3,	7,	6;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	3,	3,	4,	6,	6,	2,	3,	4,	3,	4,	3,	3,	0,	0,	0,	0;
ShinPalSettings_INTERIOR:     	; 16	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	3,	3,	7,	7,	3,	3,	3,	3,	3,	3,	3,	3,	3,	3,	3;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	3,	6,	6,	2,	2,	3,	3,	3,	3,	3,	3,	3,	3,	3,	3,	7;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	7,	6,	6,	2,	2,	7,	7,	3,	3,	3,	3,	3,	3,	6,	6,	3;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	7,	2,	2,	2,	3,	7,	7,	3,	3,	3,	3,	3,	3,	3,	3,	6;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	6,	2,	2,	2,	2,	7,	4,	4,	6,	6,	6,	6,	6,	6,	6,	6;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	3,	6,	6,	1,	1,	1,	1,	6,	6,	6,	6,	6,	6,	3,	3,	3;
ShinPalSettings_CAVERN:       	; 17	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	3,	6,	6,	3,	6,	3,	3,	3,	3,	3,	3,	3,	3,	3,	3;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	6,	6,	6,	6,	7,	6,	6,	6,	3,	3,	3,	3,	3,	3,	3,	3;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	3,	5,	3,	3,	3,	6,	6,	3,	6,	6,	6,	3,	3,	3,	3,	3;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	3,	6,	7,	7,	7,	7,	7,	7,	7,	7,	7,	7,	3,	6,	6,	6;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	6,	6,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0;
ShinPalSettings_LOBBY:        	; 18	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	4,	3,	3,	0,	7,	4,	2,	2,	7,	3,	3,	3,	3,	3,	3;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	3,	7,	3,	3,	0,	7,	4,	2,	2,	7,	3,	3,	3,	3,	3,	3;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	2,	4,	7,	7,	7,	7,	7,	7,	5,	7,	3,	3,	3,	3,	3,	3;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	7,	7,	7,	7,	7,	7,	7,	2,	5,	7,	3,	3,	3,	3,	7,	4;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	3,	3,	3,	3,	7,	3,	7,	7,	4,	4,	3,	7,	7,	7,	7,	7;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	3,	3,	3,	3,	7,	7,	3,	3,	4,	4,	3,	2,	7,	7,	3,	0;
ShinPalSettings_MANSION:      	; 19	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	3,	7,	7,	4,	7,	1,	1,	4,	4,	3,	3,	3,	3,	3,	1;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	3,	7,	7,	7,	4,	5,	1,	1,	6,	6,	3,	3,	3,	3,	1,	1;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	7,	1,	6,	6,	3,	3,	6,	6,	5,	6,	1,	1,	3,	6,	6,	6;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	1,	1,	6,	6,	3,	3,	6,	6,	5,	6,	6,	6,	6,	3,	3,	6;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	3,	3,	3,	3,	4,	4,	6,	6,	1,	1,	1,	1,	3,	3,	1,	3;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	6,	1,	1,	1,	1,	7,	7,	5,	1,	1,	1,	1,	1,	1,	3,	0;
ShinPalSettings_LAB:          	; 20	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	1,	3,	3,	3,	3,	6,	6,	6,	6,	3,	3,	3,	3,	3,	3;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	6,	6,	3,	3,	3,	3,	6,	6,	3,	3,	3,	3,	7,	7,	3,	3;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	6,	6,	6,	6,	7,	7,	3,	7,	6,	6,	6,	6,	4,	4,	6,	6;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	6,	6,	6,	6,	5,	5,	3,	7,	3,	3,	6,	7,	4,	4,	6,	6;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	6,	6,	6,	6,	6,	3,	3,	7,	6,	6,	3,	3,	5,	5,	7,	3;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	6,	6,	6,	6,	6,	3,	3,	7,	7,	7,	3,	3,	3,	0,	0,	0;
ShinPalSettings_CLUB:         	; 21	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	0,	6,	6,	6,	0,	1,	6,	1,	1,	0,	4,	0,	0,	7,	0,	3;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	1,	6,	6,	6,	0,	7,	7,	2,	2,	3,	4,	0,	0,	7,	3,	3;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	7,	7,	7,	7,	7,	7,	7,	7,	0,	0,	7,	7,	0,	0,	0,	0;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	1,	1,	1,	1,	5,	5,	1,	3,	3,	3,	3,	3,	3,	3,	3,	4;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	3,	3,	4,	4,	4,	4,	4,	3,	3,	3,	3,	3,	0,	0,	0,	0;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0;
ShinPalSettings_FACILITY:     	; 22	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	3,	6,	3,	3,	4,	4,	6,	3,	6,	6,	3,	3,	6,	6,	6;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	3,	3,	6,	3,	7,	4,	4,	6,	3,	6,	6,	3,	3,	6,	6,	6;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	2,	2,	1,	5,	3,	3,	6,	2,	6,	6,	7,	7,	7,	7,	7,	2;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	2,	2,	1,	3,	3,	6,	6,	2,	6,	6,	7,	7,	7,	3,	3,	2;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	3,	3,	1,	3,	6,	6,	5,	7,	5,	5,	3,	3,	3,	3,	3,	6;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	3,	3,	1,	6,	6,	3,	3,	7,	3,	7,	3,	3,	7,	7,	3,	7;
ShinPalSettings_PLATEAU:      	; 23	- done
;	00	01	02	03	04	05	06	07	08	09	0A	0B	0C	0D	0E	0F
db	3,	6,	6,	7,	7,	3,	3,	4,	4,	6,	6,	6,	6,	7,	7,	7;
;	10	11	12	13	14	15	16	17	18	19	1A	1B	1C	1D	1E	1F
db	7,	6,	7,	0,	7,	3,	3,	4,	4,	6,	6,	6,	6,	6,	6,	6;
;	20	21	22	23	24	25	26	27	28	29	2A	2B	2C	2D	2E	2F
db	7,	7,	6,	3,	6,	7,	7,	6,	7,	7,	6,	6,	4,	4,	3,	3;
;	30	31	32	33	34	35	36	37	38	39	3A	3B	3C	3D	3E	3F
db	3,	3,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	6,	8,	8,	8;
;	40	41	42	43	44	45	46	47	48	49	4A	4B	4C	4D	4E	4F
db	8,	8,	8,	8,	8,	4,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0;
;	50	51	52	53	54	55	56	57	58	59	5A	5B	5C	5D	5E	5F
db	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0;



ShinPalSettings_TownSpecialPal:
	db	ShinPAL_ENH_OVW_PURPLE	;	PALLET_TOWN,		; $00
	db	ShinPAL_ENH_OVW_GREEN	;	VIRIDIAN_CITY,		; $01
	db	ShinPAL_ENH_OVW_GRAY	;	PEWTER_CITY,		; $02
	db	ShinPAL_ENH_OVW_BLUE	;	CERULEAN_CITY,		; $03
	db	ShinPAL_ENH_OVW_PURPLE	;	LAVENDER_TOWN,		; $04
	db	ShinPAL_ENH_OVW_RED		;	VERMILION_CITY,		; $05
	db	ShinPAL_ENH_OVW_GREEN	;	CELADON_CITY,		; $06
	db	ShinPAL_ENH_OVW_PINK	;	FUCHSIA_CITY,		; $07
	db	ShinPAL_ENH_OVW_RED		;	CINNABAR_ISLAND,	; $08
	db	ShinPAL_ENH_OVW_BLUE	;	INDIGO_PLATEAU,		; $09
	db	ShinPAL_ENH_OVW_YELLOW	;	SAFFRON_CITY,		; $0A

	

