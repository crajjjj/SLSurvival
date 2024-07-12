Scriptname _SLS_IntRnd Hidden 

Bool Function IsNeedsModActive(ReferenceAlias RndPlayerAlias) Global
	Return (RndPlayerAlias as RND_PlayerScript).RND_State.GetValueInt() as Bool
EndFunction

Bool Function IsVampire(ReferenceAlias RndPlayerAlias) Global
	Return (RndPlayerAlias as RND_PlayerScript).IsVampire()
EndFunction

Bool Function IsWerewolf(ReferenceAlias RndPlayerAlias) Global
	Return (RndPlayerAlias as RND_PlayerScript).IsWerewolf()
EndFunction
