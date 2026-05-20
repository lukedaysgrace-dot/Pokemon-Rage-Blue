_Route1Youngster1MartSampleText::
	text "Hi! I work at a"
	line "#MON MART."

	para "It's a convenient"
	line "shop, so please"
	cont "visit us in"
	cont "VIRIDIAN CITY."

	para "I know, I'll give"
	line "you a sample!"
	cont "Here you go!"
	prompt

_Route1Youngster1GotPotionText::
	text "<PLAYER> got"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_Route1Youngster1AlsoGotPokeballsText::
	text "We also carry"
	line "# BALLs for"
	cont "catching #MON!"
	done

_Route1Youngster1NoRoomText::
	text "You have too much"
	line "stuff with you!"
	done

_Route1Youngster2Text::
	text "See those ledges"
	line "along the road?"

	para "It's a bit scary,"
	line "but you can jump"
	cont "from them."

	para "You can get back"
	line "to PALLET TOWN"
	cont "quicker that way."
	done

_Route1SignText::
	text "ROUTE 1"
	line "PALLET TOWN -"
	cont "VIRIDIAN CITY"
	done

_Route1OakBeforeBattleText::
	text "Ah, <PLAYER>!"

	para "You've completed"
	line "the #DEX!"

	para "Every single one"
	line "of the original"
	cont "151 #MON, MEW"
	cont "included."

	para "I'm impressed."
	line "Let me see how"
	cont "far you've come!"
	done

_Route1OakEndBattleText::
	text "Splendid! You've"
	line "grown into a fine"
	cont "#MON TRAINER!"
	done

_Route1OakPlayerLoseText::
	text "Don't give up!"
	line "Study your #MON"
	cont "and try again!"
	done

_Route1OakAfterBattleText::
	text "You remind me of"
	line "myself at your"
	cont "age."

	para "Keep training,"
	line "and take good"
	cont "care of your"
	cont "#MON!"
	done
