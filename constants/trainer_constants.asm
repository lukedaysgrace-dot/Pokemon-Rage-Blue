; Must satisfy OPP_ID_OFFSET + last trainer class <= 255 (8-bit wCurOpponent /
; wEngagedTrainerClass). With SOLDIER at $39, 199 + $39 = 256 wraps to 0 and
; breaks trainer battles (wild path, no fight after dialogue).
DEF OPP_ID_OFFSET EQU 198

MACRO trainer_const
	const \1
	DEF OPP_\1 EQU OPP_ID_OFFSET + \1
ENDM

; trainer class ids
; indexes for:
; - TrainerNames (see data/trainers/names.asm)
; - TrainerNamePointers (see data/trainers/name_pointers.asm)
; - TrainerDataPointers (see data/trainers/parties.asm)
; - TrainerPicAndMoneyPointers (see data/trainers/pic_pointers_money.asm)
; - TrainerAIPointers (see data/trainers/ai_pointers.asm)
; - TrainerClassMoveChoiceModifications (see data/trainers/move_choices.asm)
	const_def
	trainer_const NOBODY         ; $00
	trainer_const YOUNGSTER      ; $01
	trainer_const BUG_CATCHER    ; $02
	trainer_const LASS           ; $03
	trainer_const SAILOR         ; $04
	trainer_const JR_TRAINER_M   ; $05
	trainer_const JR_TRAINER_F   ; $06
	trainer_const POKEMANIAC     ; $07
	trainer_const SUPER_NERD     ; $08
	trainer_const HIKER          ; $09
	trainer_const BIKER          ; $0A
	trainer_const BURGLAR        ; $0B
	trainer_const ENGINEER       ; $0C
	trainer_const ARIANA         ; $0D
DEF UNUSED_JUGGLER EQU ARIANA
DEF OPP_UNUSED_JUGGLER EQU OPP_ARIANA
	trainer_const FISHER         ; $0E
	trainer_const SWIMMER        ; $0F
	trainer_const SWIMMER_F      ; $10
	trainer_const CUE_BALL       ; $11
	trainer_const GAMBLER        ; $12
	trainer_const BEAUTY         ; $13
	trainer_const PSYCHIC_TR     ; $14
	trainer_const ROCKER         ; $15
	trainer_const JUGGLER        ; $16
	trainer_const TAMER          ; $17
	trainer_const BIRD_KEEPER    ; $18
	trainer_const BLACKBELT      ; $19
	trainer_const RIVAL1         ; $1A
	trainer_const PROF_OAK       ; $1B
	trainer_const CHIEF          ; $1C
	trainer_const SCIENTIST      ; $1D
	trainer_const GIOVANNI       ; $1E
	trainer_const ROCKET         ; $1F
	trainer_const COOLTRAINER_M  ; $20
	trainer_const COOLTRAINER_F  ; $21
	trainer_const BRUNO          ; $22
DEF KAREN EQU BRUNO
DEF OPP_KAREN EQU OPP_BRUNO
	trainer_const BROCK          ; $23
	trainer_const MISTY          ; $24
	trainer_const LT_SURGE       ; $25
	trainer_const ERIKA          ; $26
	trainer_const KOGA           ; $27
	trainer_const BLAINE         ; $28
	trainer_const SABRINA        ; $29
	trainer_const GENTLEMAN      ; $2A
	trainer_const RIVAL2         ; $2B
	trainer_const RIVAL3         ; $2C
	trainer_const LORELEI        ; $2D
	trainer_const CHANNELER      ; $2E
	trainer_const AGATHA         ; $2F
	trainer_const LANCE          ; $30
	trainer_const BLUE_CLOAK     ; $31
	trainer_const GREEN          ; $32
	trainer_const GREEN_ROCKET   ; $33
	trainer_const NINJA          ; $34
	trainer_const JANINE         ; $35
	trainer_const PETREL         ; $36
	trainer_const PROTON         ; $37
	trainer_const ARCHER         ; $38
	trainer_const SOLDIER        ; $39
DEF NUM_TRAINERS EQU const_value - 1
