; Testing aid: start a new game with the BICYCLE and SKATEBOARD already in the
; bag, so both riding sprites can be checked without playing to the BIKE SHOP.
; Set this to 0 (or delete the block at the end of InitPlayerData) for normal play.
DEF DEBUG_START_WITH_RIDES EQU 1

InitPlayerData:
InitPlayerData2:

	call Random
	ldh a, [hRandomSub]
	ld [wPlayerID], a

	call Random
	ldh a, [hRandomAdd]
	ld [wPlayerID + 1], a

	ld a, $ff
	ld [wUnusedPlayerDataByte], a

	ld hl, wPartyCount
	call InitializeEmptyList
	ld hl, wBoxCount
	call InitializeEmptyList
	ld hl, wNumBagItems
	call InitializeEmptyList
	ld hl, wNumBoxItems
	call InitializeEmptyList

DEF START_MONEY EQU $3000
	ld hl, wPlayerMoney + 1
	ld a, HIGH(START_MONEY)
	ld [hld], a
	xor a ; LOW(START_MONEY)
	ld [hli], a
	inc hl
	ld [hl], a

	ld [wMonDataLocation], a

	xor a
	ld hl, wPlayerCoins
	ld [hli], a
	ld [hl], a

	ld hl, wGameProgressFlags
	ld bc, wGameProgressFlagsEnd - wGameProgressFlags
	call FillMemory ; clear all game progress flags (FillMemory uses a; must be 0)

	xor a
	ld [wObtainedBadges], a
	ld [wBeatGymFlags], a
	ld [wUnusedObtainedBadges], a

	ResetEvent EVENT_GOT_BICYCLE
	ResetEvent EVENT_GOT_SKATEBOARD_FROM_BIKE_SHOP
	ResetEvent EVENT_GOT_BIKE_VOUCHER

IF DEBUG_START_WITH_RIDES
	; Overwrite the empty bag with BICYCLE + SKATEBOARD, and flag both as
	; already obtained so the BIKE SHOP scripts stay consistent.
	ld hl, wNumBagItems
	ld a, 2 ; item count
	ld [hli], a
	ld a, BICYCLE
	ld [hli], a
	ld a, 1 ; quantity
	ld [hli], a
	ld a, SKATEBOARD
	ld [hli], a
	ld a, 1 ; quantity
	ld [hli], a
	ld a, -1 ; list terminator
	ld [hl], a

	SetEvent EVENT_GOT_BICYCLE
	SetEvent EVENT_GOT_SKATEBOARD_FROM_BIKE_SHOP
ENDC

	jp InitializeToggleableObjectsFlags

InitializeEmptyList:
	xor a ; count
	ld [hli], a
	dec a ; terminator
	ld [hl], a
	ret
