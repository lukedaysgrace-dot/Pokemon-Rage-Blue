_MtMoonB2FDomeFossilYouWantText::
	text "You want the"
	line "DOME FOSSIL?"
	done

_MtMoonB2FHelixFossilYouWantText::
	text "You want the"
	line "HELIX FOSSIL?"
	done

_MtMoonB2FReceivedFossilText::
	text "<PLAYER> got the"
	line "@"
	text_ram wStringBuffer
	text "!@"
	text_end

_MtMoonB2FYouHaveNoRoomText::
	text "Look, you've got"
	line "no room for this.@"
	text_end

_MtMoonB2FSuperNerdTheyreBothMineText::
	text "Hey, stop!"

	para "I found these"
	line "fossils! They're"
	cont "both mine!"
	done

_MtMoonB2FSuperNerdOkIllShareText::
	text "OK!"
	line "I'll share!"
	prompt

_MtMoonB2fSuperNerdEachTakeOneText::
	text "Fine! We'll each"
	line "take one!"

	para "But if you find"
	line "any more fossils"
	cont "in MT.MOON, come"
	cont "show me!"
	done

_MtMoonB2FSuperNerdTheresAPokemonLabText::
	text "I'm looking for"
	line "six kinds: SAIL,"
	cont "ARMOR, CLAW,"
	cont "SKULL, JAW, and"
	cont "ROOT."

IF DEF(_RED)
	para "Bring me all six,"
	line "and I'll trade"
	cont "you the fossil I"
	cont "kept."

	para "I also heard a"
ELSE
	para "Find all six and"
	line "show me. I'll"
	cont "even give you the"
	cont "fossil I kept."

	para "You can keep the"
	line "others. I just"
	cont "wanted to get a"
	cont "good look at"
	cont "them."

	para "I heard a"
ENDC
	line "scientist from"
	cont "CINNABAR moved to"
	cont "CERULEAN CITY. He"
	cont "might know how to"
	cont "revive them."
	done

_MtMoonB2FSuperNerdFoundThemAllText::
	text "You found all"
IF DEF(_RED)
	line "six? Let me see!"

	para "These are just"
	line "what I was"
	cont "looking for."

	para "A deal's a deal."
	line "Here's the fossil"
	cont "I kept."
ELSE
	line "six? Let me have"
	cont "a look."

	para "So these all came"
	line "from MT.MOON..."

	para "Thanks for"
	line "showing me. Here,"
	cont "take the fossil"
	cont "I kept."
ENDC
	done

_MtMoonB2FSuperNerdAfterRewardText::
IF DEF(_RED)
	text "That scientist in"
	line "CERULEAN might be"
	cont "able to revive"
	cont "your fossils."

	para "I'd love to see"
	line "what comes out of"
	cont "them."
ELSE
	text "Take those"
	line "fossils to the"
	cont "scientist in"
	cont "CERULEAN."
ENDC
	done

_MtMoonB2FSuperNerdThenThisIsMineText::
	text "All right. Then"
	line "this is mine!@"
	text_end

IF DEF(_RED)
_MtMoonB2FSuperNerdFourFossilsText::
	text "If you find those"
	line "six fossils in"
	cont "MT.MOON, bring"
	cont "them back here."

	para "I'll trade you"
	line "the one I kept."
	done

_MtMoonB2FSuperNerdSellWarningText::
	text "You're going to"
	line "sell them?"

	para "Think it over."
	line "You'll need all"
	cont "six if you want"
	cont "to trade for my"
	cont "fossil."
	done
ENDC

_MtMoonB2FRocket1BattleText::
	text "TEAM ROCKET will"
	line "find the fossils,"
	cont "revive and sell"
	cont "them for cash!"
	done

_MtMoonB2FRocket1EndBattleText::
	text "Urgh!"
	line "Now I'm mad!"
	prompt

_MtMoonB2FRocket1AfterBattleText::
	text "You made me mad!"
	line "TEAM ROCKET will"
	cont "blacklist you!"
	done

_MtMoonB2FRocket2BattleText::
	text "We, TEAM ROCKET,"
	line "are #MON"
	cont "gangsters!"
	done

_MtMoonB2FRocket2EndBattleText::
	text "I blew"
	line "it!"
	prompt

_MtMoonB2FRocket2AfterBattleText::
	text "Darn it all! My"
	line "associates won't"
	cont "stand for this!"
	done

_MtMoonB2FRocket3BattleText::
	text "We're pulling a"
	line "big job here!"
	cont "Get lost, kid!"
	done

_MtMoonB2FRocket3EndBattleText::
	text "So, you"
	line "are good."
	prompt

_MtMoonB2FRocket3AfterBattleText::
	text "If you find a"
	line "fossil, give it"
	cont "to me and scram!"
	done

_MtMoonB2FRocket4BattleText::
	text "Little kids"
	line "should leave"
	cont "grown-ups alone!"
	done

_MtMoonB2FRocket4EndBattleText::
	text "I'm"
	line "steamed!"
	prompt

_MtMoonB2FRocket4AfterBattleText::
	text "#MON lived"
	line "here long before"
	cont "people came."
	done
