DEF _green_channel = 1
DEF _green_speed = 12
DEF _green_volume = 8
DEF _green_fade = 0
DEF _green_wave = 0
DEF _green_octave = 4
DEF _green_loop_id = 0
DEF _green_loop_depth = 0

PURGE stereo_panning
MACRO stereo_panning
ENDM

MACRO green_channel
	DEF _green_channel = \1
	DEF _green_speed = 12
	DEF _green_volume = 8
	DEF _green_fade = 0
	DEF _green_wave = 0
	DEF _green_octave = 4
ENDM

MACRO green_note_type
	IF _green_channel == 4
		drum_speed _green_speed
	ELIF _green_channel == 3
		note_type _green_speed, _green_volume, _green_wave
	ELSE
		note_type _green_speed, _green_volume, _green_fade
	ENDC
ENDM

MACRO MainLoop
.mainloop
ENDM

MACRO EndMainLoop
	sound_loop 0, .mainloop
ENDM

MACRO Loop
	DEF _green_loop_id += 1
	DEF _green_loop_depth += 1
	DEF _green_loop_stack_{d:_green_loop_depth} = _green_loop_id
	DEF _green_loop_count_{d:_green_loop_id} = \1
.green_loop_{d:_green_loop_id}
ENDM

MACRO EndLoop
	DEF _green_loop_current = {_green_loop_stack_{d:_green_loop_depth}}
	sound_loop {_green_loop_count_{d:_green_loop_current}}, .green_loop_{d:_green_loop_current}
	DEF _green_loop_depth -= 1
ENDM

MACRO speed
	DEF _green_speed = \1
	green_note_type
ENDM

MACRO volume_envelope
	DEF _green_volume = \1
	DEF _green_fade = \2
	IF _green_channel != 4
		green_note_type
	ENDC
ENDM

MACRO wave
	DEF _green_wave = \1
	IF _green_channel == 3
		green_note_type
	ENDC
ENDM

PURGE octave
MACRO octave
	DEF _green_octave = \1
	db octave_cmd | (8 - \1)
ENDM

MACRO inc_octave
	DEF _green_octave += 1
	octave _green_octave
ENDM

MACRO dec_octave
	DEF _green_octave -= 1
	octave _green_octave
ENDM

MACRO duty
	duty_cycle \1
ENDM

MACRO cutoff
ENDM

MACRO echo
ENDM

MACRO vibrato_type
ENDM

MACRO vibrato_delay
ENDM

MACRO tie
ENDM

MACRO music_call
	sound_call \1
ENDM

MACRO music_ret
	sound_ret
ENDM

MACRO bass
	drum_note 4, \1
ENDM

MACRO snare1
	drum_note 8, \1
ENDM

MACRO snare2
	drum_note 9, \1
ENDM

MACRO snare3
	drum_note 10, \1
ENDM

MACRO snare4
	drum_note 11, \1
ENDM

MACRO snare5
	drum_note 12, \1
ENDM
