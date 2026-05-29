; Version-specific custom trainer moves table selector.
; Keep these tables in sync with data/trainers/parties_red.asm and parties_blue.asm.

IF DEF(_RED)
INCLUDE "data/trainers/custom_trainer_moves_table_red.asm"
ELSE
INCLUDE "data/trainers/custom_trainer_moves_table_blue.asm"
ENDC
