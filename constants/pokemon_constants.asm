; pokemon ids
; indexes for:
; - MonsterNames (see data/pokemon/names.asm)
; - EvosMovesPointerTable (see data/pokemon/evos_moves.asm)
; - CryData (see data/pokemon/cries.asm)
; - PokedexOrder (see data/pokemon/dex_order.asm)
; - PokedexEntryPointers (see data/pokemon/dex_entries.asm)
	const_def
	const NO_MON             ; $00
	const RHYDON             ; $01
	const KANGASKHAN         ; $02
	const NIDORAN_M          ; $03
	const CLEFAIRY           ; $04
	const SPEAROW            ; $05
	const VOLTORB            ; $06
	const NIDOKING           ; $07
	const SLOWBRO            ; $08
	const IVYSAUR            ; $09
	const EXEGGUTOR          ; $0A
	const LICKITUNG          ; $0B
	const EXEGGCUTE          ; $0C
	const GRIMER             ; $0D
	const GENGAR             ; $0E
	const NIDORAN_F          ; $0F
	const NIDOQUEEN          ; $10
	const CUBONE             ; $11
	const RHYHORN            ; $12
	const LAPRAS             ; $13
	const ARCANINE           ; $14
	const MEW                ; $15
	const GYARADOS           ; $16
	const SHELLDER           ; $17
	const TENTACOOL          ; $18
	const GASTLY             ; $19
	const SCYTHER            ; $1A
	const STARYU             ; $1B
	const BLASTOISE          ; $1C
	const PINSIR             ; $1D
	const TANGELA            ; $1E
	const CRANIDOS           ; $1F
	const RAMPARDOS          ; $20
	const GROWLITHE          ; $21
	const ONIX               ; $22
	const FEAROW             ; $23
	const PIDGEY             ; $24
	const SLOWPOKE           ; $25
	const KADABRA            ; $26
	const GRAVELER           ; $27
	const CHANSEY            ; $28
	const MACHOKE            ; $29
	const MR_MIME            ; $2A
	const HITMONLEE          ; $2B
	const HITMONCHAN         ; $2C
	const ARBOK              ; $2D
	const PARASECT           ; $2E
	const PSYDUCK            ; $2F
	const DROWZEE            ; $30
	const GOLEM              ; $31
	const_skip               ; $32
	const MAGMAR             ; $33
	const_skip               ; $34
	const ELECTABUZZ         ; $35
	const MAGNETON           ; $36
	const KOFFING            ; $37
	const_skip               ; $38
	const MANKEY             ; $39
	const SEEL               ; $3A
	const DIGLETT            ; $3B
	const TAUROS             ; $3C
	const_skip               ; $3D
	const_skip               ; $3E
	const_skip               ; $3F
	const FARFETCHD          ; $40
	const VENONAT            ; $41
	const DRAGONITE          ; $42
	const SHIELDON           ; $43
	const BASTIODON          ; $44
	const_skip               ; $45
	const DODUO              ; $46
	const POLIWAG            ; $47
	const JYNX               ; $48
	const MOLTRES            ; $49
	const ARTICUNO           ; $4A
	const ZAPDOS             ; $4B
	const DITTO              ; $4C
	const MEOWTH             ; $4D
	const KRABBY             ; $4E
	const BUNEARY            ; $4F
	const LOPUNNY            ; $50
	const_skip               ; $51
	const VULPIX             ; $52
	const NINETALES          ; $53
	const PIKACHU            ; $54
	const RAICHU             ; $55
	const HIPPOPOTAS         ; $56
	const HIPPOWDON          ; $57
	const DRATINI            ; $58
	const DRAGONAIR          ; $59
	const KABUTO             ; $5A
	const KABUTOPS           ; $5B
	const HORSEA             ; $5C
	const SEADRA             ; $5D
	const_skip               ; $5E
	const_skip               ; $5F
	const SANDSHREW          ; $60
	const SANDSLASH          ; $61
	const OMANYTE            ; $62
	const OMASTAR            ; $63
	const JIGGLYPUFF         ; $64
	const WIGGLYTUFF         ; $65
	const EEVEE              ; $66
	const FLAREON            ; $67
	const JOLTEON            ; $68
	const VAPOREON           ; $69
	const MACHOP             ; $6A
	const ZUBAT              ; $6B
	const EKANS              ; $6C
	const PARAS              ; $6D
	const POLIWHIRL          ; $6E
	const POLIWRATH          ; $6F
	const WEEDLE             ; $70
	const KAKUNA             ; $71
	const BEEDRILL           ; $72
	const_skip               ; $73
	const DODRIO             ; $74
	const PRIMEAPE           ; $75
	const DUGTRIO            ; $76
	const VENOMOTH           ; $77
	const DEWGONG            ; $78
	const_skip               ; $79
	const_skip               ; $7A
	const CATERPIE           ; $7B
	const METAPOD            ; $7C
	const BUTTERFREE         ; $7D
	const MACHAMP            ; $7E
	const_skip               ; $7F
	const GOLDUCK            ; $80
	const HYPNO              ; $81
	const GOLBAT             ; $82
	const MEWTWO             ; $83
	const SNORLAX            ; $84
	const MAGIKARP           ; $85
	const_skip               ; $86
	const_skip               ; $87
	const MUK                ; $88
	const_skip               ; $89
	const KINGLER            ; $8A
	const CLOYSTER           ; $8B
	const_skip               ; $8C
	const ELECTRODE          ; $8D
	const CLEFABLE           ; $8E
	const WEEZING            ; $8F
	const PERSIAN            ; $90
	const MAROWAK            ; $91
	const_skip               ; $92
	const HAUNTER            ; $93
	const ABRA               ; $94
	const ALAKAZAM           ; $95
	const PIDGEOTTO          ; $96
	const PIDGEOT            ; $97
	const STARMIE            ; $98
	const BULBASAUR          ; $99
	const VENUSAUR           ; $9A
	const TENTACRUEL         ; $9B
	const_skip               ; $9C
	const GOLDEEN            ; $9D
	const SEAKING            ; $9E
	const LILEEP             ; $9F
	const CRADILY            ; $A0
	const ANORITH            ; $A1
	const ARMALDO            ; $A2
	const PONYTA             ; $A3
	const RAPIDASH           ; $A4
	const RATTATA            ; $A5
	const RATICATE           ; $A6
	const NIDORINO           ; $A7
	const NIDORINA           ; $A8
	const GEODUDE            ; $A9
	const PORYGON            ; $AA
	const AERODACTYL         ; $AB
	const_skip               ; $AC
	const MAGNEMITE          ; $AD
	const_skip               ; $AE
	const_skip               ; $AF
	const CHARMANDER         ; $B0
	const SQUIRTLE           ; $B1
	const CHARMELEON         ; $B2
	const WARTORTLE          ; $B3
	const CHARIZARD          ; $B4
	const_skip               ; $B5
	const FOSSIL_KABUTOPS    ; $B6
	const FOSSIL_AERODACTYL  ; $B7
	const MON_GHOST          ; $B8
	const ODDISH             ; $B9
	const GLOOM              ; $BA
	const VILEPLUME          ; $BB
	const BELLSPROUT         ; $BC
	const WEEPINBELL         ; $BD
	const VICTREEBEL         ; $BE
	const CHIKORITA          ; $BF
	const BAYLEEF            ; $C0
	const MEGANIUM           ; $C1
	const CYNDAQUIL          ; $C2
	const QUILAVA            ; $C3
	const TYPHLOSION         ; $C4
	const TOTODILE           ; $C5
	const CROCONAW           ; $C6
	const FERALIGATR         ; $C7
	const MURKROW            ; $C8
	const HONCHKROW          ; $C9
	const MISDREAVUS         ; $CA
	const MISMAGIUS          ; $CB
	const SWINUB             ; $CC
	const PILOSWINE          ; $CD
	const MAMOSWINE          ; $CE
	const LARVITAR           ; $CF
	const PUPITAR            ; $D0
	const TYRANITAR          ; $D1
	const RALTS              ; $D2
	const KIRLIA             ; $D3
	const GARDEVOIR          ; $D4
	const RIOLU              ; $D5
	const LUCARIO            ; $D6
	const BAGON              ; $D7
	const SHELGON            ; $D8
	const SALAMENCE          ; $D9
	const DUSKULL            ; $DA
	const DUSCLOPS           ; $DB
	const DUSKNOIR           ; $DC
	const GOLETT             ; $DD
	const GOLURK             ; $DE
	const HERACROSS          ; $DF
	const ESPEON             ; $E0
	const UMBREON            ; $E1
	const GLACEON            ; $E2
	const LEAFEON            ; $E3
	const ANNIHILAPE         ; $E4
	const BLISSEY            ; $E5
	const CROBAT             ; $E6
	const ELECTIVIRE         ; $E7
	const KINGDRA            ; $E8
	const LICKILICKY         ; $E9
	const MAGMORTAR          ; $EA
	const MAGNEZONE          ; $EB
	const PORYGON2           ; $EC
	const PORYGON_Z          ; $ED
	const RHYPERIOR          ; $EE
	const SCIZOR             ; $EF
	const STEELIX            ; $F0
	const TANGROWTH          ; $F1
	const VENIPEDE           ; $F2
	const WHIRLIPEDE         ; $F3
	const SCOLIPEDE          ; $F4
	const SNEASEL            ; $F5
	const WEAVILE            ; $F6
	const MESMERIA           ; $F7
	const CROAGUNK           ; $F8
	const TOXICROAK          ; $F9
	const PHANPY             ; $FA
	const DONPHAN            ; $FB
	const HOUNDOUR           ; $FC
	const HOUNDOOM           ; $FD

; Species-indexed tables (EvosMovesPointerTable, CryData, names.asm, dex_order.asm,
; dex_entries PokedexEntryPointers) must stay in sync with this internal-id order. MonPartyData and
; MonsterPalettes are indexed by National Dex number instead (see engine/gfx/mon_icons.asm).

DEF NUM_POKEMON_INDEXES EQU const_value - 1
; Internal ids at/above OPP_ID_OFFSET collide with trainer OPP_* in InitBattle; grass/fishing set wBattleSpeciesIsWild. OPP begins at $C5 (=197).

; starters
DEF STARTER1 EQU CHARMANDER
DEF STARTER2 EQU SQUIRTLE
DEF STARTER3 EQU BULBASAUR

; ghost Marowak in Pokémon Tower
DEF RESTLESS_SOUL EQU MAROWAK
