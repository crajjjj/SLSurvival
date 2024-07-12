Scriptname _SLS_LicMagicCurseFollowers extends Quest  

Event OnInit()
	If Self.IsRunning()
		If CurseAllFollowers() == 0
			Self.Stop()
		EndIf
	EndIf
EndEvent

Function ClearAllAliases()
	Int i = Self.GetNumAliases()
	Actor Follower
	ReferenceAlias AliasSelect
	While i > 0
		i -= 1
		AliasSelect = Self.GetNthAlias(i) as ReferenceAlias
		If AliasSelect.GetReference()
			LicUtil.UnNullifyMagic(AliasSelect.GetReference() as Actor)
		EndIf
		AliasSelect.Clear()
	EndWhile
EndFunction

Int Function CurseAllFollowers()
	Int FollowerCount
	ClearAllAliases()
	Form[] Followers = Util.GetFollowers()
	Actor akFollower
	Int i = Followers.Length
	While i > 0
		i -= 1
		akFollower = Followers[i] as Actor
		If akFollower
			AddFollowerCurse(akFollower)
			FollowerCount += 1
		EndIf
	EndWhile
	Return FollowerCount
EndFunction

Function AddFollowerCurse(Actor akFollower)
	ReferenceAlias AliasSelect = GetFreeAlias()
	If AliasSelect
		;Debug.Messagebox("Add curse to: " + akFollower.GetLeveledActorBase().GetName())
		AliasSelect.ForceRefTo(akFollower)
		LicUtil.NullifyMagic(akFollower)
	
	Else
		Debug.Trace("_SLS_: _SLS_LicMagicCurseFollowers: No free alias found")
	EndIf
EndFunction

Function RemoveFollowerCurse(Actor akFollower)
	
EndFunction

ReferenceAlias Function GetFreeAlias()
	Int i = 0
	While i < Self.GetNumAliases()
		If !(Self.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
			Return (Self.GetNthAlias(i) as ReferenceAlias)
		EndIf
		i += 1
	EndWhile
	Return None
EndFunction

Spell Property _SLS_MagicLicenceCurse Auto

SLS_Mcm Property Menu Auto
SLS_Utility Property Util Auto
_SLS_LicenceUtil Property LicUtil Auto

