_MewtwoBattleText::
	text "Mew!@"
	text_end

IF DEF(_BLUE)
_ExileBrunoBeforeBattleText::
	text "Who goes"
	line "there?"

	para "Ah, the newly"
	line "crowned CHAMPION."

	para "We have never"
	line "had the chance"
	cont "to meet."

	para "I am BRUNO."
	line "Not long ago,"
	cont "I was cast out"

	para "of the ELITE"
	line "FOUR for that"
	cont "pompous woman"
	cont "KAREN."

	para "But she made"
	line "one good point."

	para "I relied too"
	line "much on strength"
	cont "alone to win."

	para "So I have trained"
	line "in this cave"
	cont "every day since."

	para "Let me see if"
	line "you are truly"
	cont "worthy of the"
	cont "title CHAMPION."
	done

_ExileBrunoEndBattleText::
	text "You"
	line "are worthy"
	cont "of that"
	cont "title."
	prompt

_ExileBrunoAfterBattleText::
	text "That was"
	line "a great battle,"
	cont "forgive me for"
	cont "doubting you."

	para "I am going to"
	line "keep on with"
	cont "my training."

	para "It was good"
	line "to meet you."

	para "Before you go,"
	line "I must warn you."

	para "There is a"
	line "disgustingly"
	cont "strong creature"
	cont "up ahead."

	para "I have kept"
	line "clear of it"
	cont "ever since I"
	cont "came here."

	para "It is not like"
	line "regular #MON."

	para "Be safe."
	done
ENDC
