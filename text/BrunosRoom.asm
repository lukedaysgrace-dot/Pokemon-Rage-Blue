IF DEF(_RED)
_BrunoBeforeBattleText::
	text "I am BRUNO of"
	line "the ELITE FOUR!"

	para "Through rigorous"
	line "training, people"
	cont "and #MON can"
	cont "become stronger!"

	para "I've weight"
	line "trained with"
	cont "my #MON!"

	para "<PLAYER>!"

	para "We will grind you"
	line "down with our"
	cont "superior power!"

	para "Hoo hah!"
	done

_BrunoEndBattleText::
	text "Why?"
	line "How could I lose?"
	prompt

_BrunoAfterBattleText::
	text "My job is done!"
	line "Go face your next"
	cont "challenge!"
	done

_BrunosRoomBrunoDontRunAwayText::
	text "Someone's voice:"
	line "Don't run away!"
	done

_BrunoRematchPreBattleText::
	text "CHAMPION! I've"
	line "trained harder"
	cont "since your win."

	para "Let's test our"
	line "strength once"
	cont "more!"
	done

_BrunoRematchDefeatText::
	text "Hah!"
	line "Your strength is"
	cont "undeniable!"

	para "I'll train"
	line "harder!"
	prompt

_BrunoRematchDefeatOverworldText::
	text "Raw power alone"
	line "wasn't enough."

	para "I'll temper my"
	line "body and spirit"
	cont "for our next bout!"
	done

_BrunoRematchMustRestartText::
	text "Want another test"
	line "of strength?"

	para "Start again from"
	line "the #MON LEAGUE"
	cont "LOBBY."
	done
ELSE
_KarenBeforeBattleText::
	text "You've come all"
	line "this way..."

	para "That already"
	line "tells me"
	cont "something about"
	cont "you."

	para "But this isn't"
	line "the same ELITE"
	cont "FOUR KANTO once"
	cont "had."

	para "People cling to"
	line "Strength.."
	cont "Power.."

	para "As if that's all"
	line "that matters."

	para "BRUNO relied"
	line "on those foolish"
	cont "ideals and look"
	cont "where it got him."

	para "So I have taken"
	line "his place."

	para "Strong #MON..."
	line "Weak #MON..."

	para "That's only the"
	line "selfish view"
	cont "of people."

	para "A truly skilled"
	line "trainer brings"
	cont "out the best in"
	cont "the #MON they"
	cont "love."

	para "No matter what"
	line "others think."

	para "I came to KANTO"
	line "to show them"
	cont "that."

	para "Darkness"
	line "Fear..."

	para "The things"
	line "people avoid"

	para "Those are the"
	line "things I trust."

	para "Now..."
	line "tell me."

	para "Are you strong"
	line "because of your"
	cont "#MON?"

	para "Or are they"
	line "strong because"
	cont "of you?"
	done

_KarenEndBattleText::
	text "Your #MON"
	line "really do"
	cont "love you."
	prompt

_KarenAfterBattleText::
	text "...I see."

	para "Your strength..."
	line "It isn't forced."

	para "You and your"
	line "#MON trust"
	cont "each other."

	para "That's why you"
	line "won."

	para "What matters is"
	line "the bond you've"
	cont "built."

	para "Go on."

	para "Show the rest"
	line "of KANTO"
	cont "your strength"
	cont "TRAINER."
	done

_KarensRoomKarenDontRunAwayText::
	text "Someone's voice:"
	line "Don't run away!"
	done

_KarenRematchPreBattleText::
	text "CHAMPION! I've"
	line "changed my team"
	cont "since your win."

	para "Let's test our"
	line "skill once"
	cont "more!"
	done

_KarenRematchDefeatText::
	text "Well done."
	line "That was a good"
	cont "battle."
	prompt

_KarenRematchDefeatOverworldText::
	text "Your #MON chose"
	line "each move with"
	cont "confidence."

	para "That's a bond I"
	line "respect deeply."
	done

_KarenRematchMustRestartText::
	text "Challenge the ELITE"
	line "FOUR again from"
	cont "the LOBBY if you"
	cont "want a rematch."
	done
ENDC
