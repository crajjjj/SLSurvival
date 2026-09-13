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

Bool Function IsInUnderwear(Actor akActor) Global
	; Bra and/or panties worn as the outermost layer - the "half naked" tier SLS otherwise
	; fakes with the _SLS_HalfNakedCoverArmor marker. AND tracks it natively (showing bra /
	; showing underwear), so with AND present the marker is unnecessary. Distinct from
	; IsRevealing: underwear covers chest/genitals, so none of those "showing" flags trip.
	Return AND_ModEventListener.GetShowingBra(akActor) || AND_ModEventListener.GetShowingUnderwear(akActor)
EndFunction

Bool Function IsPubicZoneVisible(Actor akActor) Global
	; Crotch actually exposed - bottomless, or genitals visible through sheer/partial cover.
	; Panties keep this false; full nudity or a thong/bottomless outfit makes it true.
	Return AND_ModEventListener.GetBottomless(akActor) || AND_ModEventListener.GetShowingGenitals(akActor)
EndFunction

Int Function GetModestyRank(Actor akActor) Global
	Return AND_ModEventListener.GetModestyRank(akActor)
EndFunction
