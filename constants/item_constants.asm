; item ids
; indexes for:
; - ItemNames (see data/items/names.asm)
; - ItemPrices (see data/items/prices.asm)
; - TechnicalMachinePrices (see data/items/tm_prices.asm)
; - KeyItemFlags (see data/items/key_items.asm)
; - ItemUsePtrTable (see engine/items/item_effects.asm)
	const_def
	const NO_ITEM       ; $00
	const MASTER_BALL   ; $01
	const ULTRA_BALL    ; $02
	const GREAT_BALL    ; $03
	const POKE_BALL     ; $04
	const TOWN_MAP      ; $05
	const BICYCLE       ; $06
	const SURFBOARD     ; $07
	const SAFARI_BALL   ; $08
	const POKEDEX       ; $09
	const MOON_STONE    ; $0A
	const ANTIDOTE      ; $0B
	const BURN_HEAL     ; $0C
	const ICE_HEAL      ; $0D
	const AWAKENING     ; $0E
	const PARLYZ_HEAL   ; $0F
	const FULL_RESTORE  ; $10
	const MAX_POTION    ; $11
	const HYPER_POTION  ; $12
	const SUPER_POTION  ; $13
	const POTION        ; $14
; badges use item IDs (see badges / party display)
	const BOULDERBADGE  ; $15
DEF SAFARI_BAIT EQU BOULDERBADGE ; overload
	const CASCADEBADGE  ; $16
DEF SAFARI_ROCK EQU CASCADEBADGE ; overload
	const THUNDERBADGE  ; $17
	const RAINBOWBADGE  ; $18
	const SOULBADGE     ; $19
	const MARSHBADGE    ; $1A
	const VOLCANOBADGE  ; $1B
	const EARTHBADGE    ; $1C
	const ESCAPE_ROPE   ; $1D
	const REPEL         ; $1E
	const OLD_AMBER     ; $1F
	const FIRE_STONE    ; $20
	const THUNDER_STONE ; $21
	const WATER_STONE   ; $22
	const ICE_STONE     ; $23
	const HP_UP         ; $24
	const PROTEIN       ; $25
	const IRON          ; $26
	const CARBOS        ; $27
	const CALCIUM       ; $28
	const RARE_CANDY    ; $29
	const DOME_FOSSIL   ; $2A
	const HELIX_FOSSIL  ; $2B
	const SECRET_KEY    ; $2C
	const SKATEBOARD    ; $2D
	const BIKE_VOUCHER  ; $2E
	const X_ACCURACY    ; $2F
	const LEAF_STONE    ; $30
	const CARD_KEY      ; $31
	const NUGGET        ; $32
	const METAL_COAT    ; $33
	const POKE_DOLL     ; $34
	const FULL_HEAL     ; $35
	const REVIVE        ; $36
	const MAX_REVIVE    ; $37
	const GUARD_SPEC    ; $38
	const SUPER_REPEL   ; $39
	const MAX_REPEL     ; $3A
	const DIRE_HIT      ; $3B
	const COIN          ; $3C
	const FRESH_WATER   ; $3D
	const SODA_POP      ; $3E
	const LEMONADE      ; $3F
	const S_S_TICKET    ; $40
	const GOLD_TEETH    ; $41
	const X_ATTACK      ; $42
	const X_DEFEND      ; $43
	const X_SPEED       ; $44
	const X_SPECIAL     ; $45
	const COIN_CASE     ; $46
	const OAKS_PARCEL   ; $47
	const ITEMFINDER    ; $48
	const SILPH_SCOPE   ; $49
	const POKE_FLUTE    ; $4A
	const LIFT_KEY      ; $4B
	const EXP_ALL       ; $4C
	const OLD_ROD       ; $4D
	const GOOD_ROD      ; $4E
	const SUPER_ROD     ; $4F
	const PP_UP         ; $50
	const ETHER         ; $51
	const MAX_ETHER     ; $52
	const ELIXER        ; $53
	const MAX_ELIXER    ; $54
	const SKULL_FOSSIL  ; $55
	const ARMOR_FOSSIL  ; $56
	const CLAW_FOSSIL   ; $57
	const ROOT_FOSSIL   ; $58
DEF NUM_ITEMS EQU const_value - 1

; elevator floors use item IDs (see scripts/CeladonMartElevator.asm and scripts/SilphCoElevator.asm)
	const FLOOR_B2F     ; $59
	const FLOOR_B1F     ; $5A
	const FLOOR_1F      ; $5B
	const FLOOR_2F      ; $5C
	const FLOOR_3F      ; $5D
	const FLOOR_4F      ; $5E
	const FLOOR_5F      ; $5F
	const FLOOR_6F      ; $60
	const FLOOR_7F      ; $61
	const FLOOR_8F      ; $62
	const FLOOR_9F      ; $63
	const FLOOR_10F     ; $64
	const FLOOR_11F     ; $65
	const FLOOR_B4F     ; $66
DEF NUM_FLOORS EQU const_value - 1 - NUM_ITEMS

	const_next $C4

; HMs are defined before TMs, so the actual number of TM definitions
; is not yet available. The TM quantity is hard-coded here and must
; match the actual number below.
DEF NUM_TMS EQU 50

DEF __tmhm_value__ = NUM_TMS + 1

MACRO add_tmnum
	DEF \1_TMNUM EQU __tmhm_value__
	DEF __tmhm_value__ += 1
ENDM

MACRO add_hm
; Defines three constants:
; - HM_\1: the item id, starting at $C4
; - \1_TMNUM: the learnable TM/HM flag, starting at 51
; - HM##_MOVE: alias for the move id, equal to the value of \1
	const HM_\1
	DEF HM_VALUE = __tmhm_value__ - NUM_TMS
	DEF HM{02d:HM_VALUE}_MOVE EQU \1
	add_tmnum \1
ENDM

DEF HM01 EQU const_value
	add_hm CUT          ; $C4
	add_hm FLY          ; $C5
	add_hm SURF         ; $C6
	add_hm STRENGTH     ; $C7
	add_hm FLASH        ; $C8
DEF NUM_HMS EQU const_value - HM01

DEF __tmhm_value__ = 1

MACRO add_tm
; Defines three constants:
; - TM_\1: the item id, starting at $C9
; - \1_TMNUM: the learnable TM/HM flag, starting at 1
; - TM##_MOVE: alias for the move id, equal to the value of \1
	const TM_\1
	DEF TM{02d:__tmhm_value__}_MOVE EQU \1
	add_tmnum \1
ENDM

DEF TM01 EQU const_value
	add_tm MEGA_PUNCH   ; $C9
	add_tm RAZOR_WIND   ; $CA
	add_tm SWORDS_DANCE ; $CB
	add_tm CRUNCH       ; $CC
	add_tm MEGA_KICK    ; $CD
	add_tm TOXIC        ; $CE
	add_tm SHADOW_BALL  ; $CF
	add_tm BODY_SLAM    ; $D0
	add_tm TAKE_DOWN    ; $D1
	add_tm DOUBLE_EDGE  ; $D2
	add_tm BUBBLEBEAM   ; $D3
	add_tm WATER_GUN    ; $D4
	add_tm ICE_BEAM     ; $D5
	add_tm BLIZZARD     ; $D6
	add_tm HYPER_BEAM   ; $D7
	add_tm PAY_DAY      ; $D8
	add_tm SUBMISSION   ; $D9
	add_tm COUNTER      ; $DA
	add_tm SEISMIC_TOSS ; $DB
	add_tm RAGE         ; $DC
	add_tm MEGA_DRAIN   ; $DD
	add_tm SOLARBEAM    ; $DE
	add_tm DRAGON_RAGE  ; $DF
	add_tm THUNDERBOLT  ; $E0
	add_tm THUNDER      ; $E1
	add_tm EARTHQUAKE   ; $E2
	add_tm FISSURE      ; $E3
	add_tm DIG          ; $E4
	add_tm PSYCHIC_M    ; $E5
	add_tm TELEPORT     ; $E6
	add_tm MIMIC        ; $E7
	add_tm DOUBLE_TEAM  ; $E8
	add_tm REFLECT      ; $E9
	add_tm BIDE         ; $EA
	add_tm METRONOME    ; $EB
	add_tm SELFDESTRUCT ; $EC
	add_tm FLAMETHROWER ; $ED
	add_tm FIRE_BLAST   ; $EE
	add_tm SWIFT        ; $EF
	add_tm SKULL_BASH   ; $F0
	add_tm SOFTBOILED   ; $F1
	add_tm DREAM_EATER  ; $F2
	add_tm SKY_ATTACK   ; $F3
	add_tm REST         ; $F4
	add_tm THUNDER_WAVE ; $F5
	add_tm PSYWAVE      ; $F6
	add_tm EXPLOSION    ; $F7
	add_tm ROCK_SLIDE   ; $F8
	add_tm TRI_ATTACK   ; $F9
	add_tm SUBSTITUTE   ; $FA
ASSERT NUM_TMS == const_value - TM01, "NUM_TMS ({d:NUM_TMS}) does not match the number of add_tm definitions"

DEF NUM_TM_HM EQU NUM_TMS + NUM_HMS

; 50 TMs + 5 HMs = 55 learnable TM/HM flags per Pokémon.
; These fit in 7 bytes, with one unused bit left over.
DEF __tmhm_value__ = NUM_TM_HM + 1
DEF UNUSED_TMNUM EQU __tmhm_value__

DEF MAX_HIDDEN_ITEMS EQU 112
DEF MAX_HIDDEN_COINS EQU 16
