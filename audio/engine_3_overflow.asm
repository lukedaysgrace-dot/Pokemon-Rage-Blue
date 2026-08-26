Audio3_InitMusic::
; Initialize music channel state without accessing bank-local audio data.
	xor a
	ld [wUnusedMusicByte], a
	ld [wDisableChannelOutputWhenSfxEnds], a
	ld [wMusicTempo + 1], a
	ld [wMusicWaveInstrument], a
	ld [wSfxWaveInstrument], a
	ld d, NUM_CHANNELS
	ld hl, wChannelReturnAddresses
	call .FillMem
	ld hl, wChannelCommandPointers
	call .FillMem
	ld d, NUM_MUSIC_CHANS
	ld hl, wChannelSoundIDs
	call .FillMem
	ld hl, wChannelFlags1
	call .FillMem
	ld hl, wChannelDutyCycles
	call .FillMem
	ld hl, wChannelDutyCyclePatterns
	call .FillMem
	ld hl, wChannelVibratoDelayCounters
	call .FillMem
	ld hl, wChannelVibratoExtents
	call .FillMem
	ld hl, wChannelVibratoRates
	call .FillMem
	ld hl, wChannelFrequencyLowBytes
	call .FillMem
	ld hl, wChannelVibratoDelayCounterReloadValues
	call .FillMem
	ld hl, wChannelFlags2
	call .FillMem
	ld hl, wChannelPitchSlideLengthModifiers
	call .FillMem
	ld hl, wChannelPitchSlideFrequencySteps
	call .FillMem
	ld hl, wChannelPitchSlideFrequencyStepsFractionalPart
	call .FillMem
	ld hl, wChannelPitchSlideCurrentFrequencyFractionalPart
	call .FillMem
	ld hl, wChannelPitchSlideCurrentFrequencyHighBytes
	call .FillMem
	ld hl, wChannelPitchSlideCurrentFrequencyLowBytes
	call .FillMem
	ld hl, wChannelPitchSlideTargetFrequencyHighBytes
	call .FillMem
	ld hl, wChannelPitchSlideTargetFrequencyLowBytes
	call .FillMem
	ld a, $1
	ld hl, wChannelLoopCounters
	call .FillMem
	ld hl, wChannelNoteDelayCounters
	call .FillMem
	ld hl, wChannelNoteSpeeds
	call .FillMem
	ld [wMusicTempo], a
	ld a, $ff
	ld [wStereoPanning], a
	xor a
	ldh [rAUDVOL], a
	ld a, AUD1SWEEP_DOWN
	ldh [rAUD1SWEEP], a
	xor a
	ldh [rAUDTERM], a
	ldh [rAUD3ENA], a
	ld a, AUD3ENA_ON
	ldh [rAUD3ENA], a
	ld a, $77
	ldh [rAUDVOL], a
	ret

.FillMem
	ld b, d
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret
