Scriptname _SLS_IntAnd Hidden
{Wrappers around Advanced Nudity Detection's SKSE natives (AND_ModEventListener). The only
script allowed to reference AND types - global calls resolve lazily, so this is safe to ship
whether or not "Advanced Nudity Detection.esp" is present, as long as callers gate on it.}

Bool Function IsNude(Actor akActor) Global
	; GetNude is AND's strictest class (its AND_NudeActorFaction): pasties, curtains or
	; underwear-class items keep an actor out of it even though nothing meaningful is
	; covered. Topless + bottomless together is AND's "effectively naked", which is what
	; SLS's naked mechanics actually care about.
	Return AND_ModEventListener.GetNude(akActor) || (AND_ModEventListener.GetTopless(akActor) && AND_ModEventListener.GetBottomless(akActor))
EndFunction

Bool Function IsRevealing(Actor akActor) Global
	; Any exposure short of full nudity: topless/bottomless, or chest/genitals/ass visible
	; through transparent or skimpy coverage. AND resolves this from the rendered meshes,
	; which the raw body-slot check can't see.
	Return AND_ModEventListener.GetTopless(akActor) || AND_ModEventListener.GetBottomless(akActor) || AND_ModEventListener.GetShowingChest(akActor) || AND_ModEventListener.GetShowingGenitals(akActor) || AND_ModEventListener.GetShowingAss(akActor)
EndFunction

Int Function GetModestyRank(Actor akActor) Global
	Return AND_ModEventListener.GetModestyRank(akActor)
EndFunction
