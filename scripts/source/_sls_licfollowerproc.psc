Scriptname _SLS_LicFollowerProc extends Quest  

Function ProcAllFollowersAllLics(Bool MustBeLoaded)
	GoToState("InProc")
	ObjectReference Follower
	If Game.GetModByName("EFFCore.esm") != 255
		
		
		
		Formlist FollowerList = Game.GetFormFromFile(0x000F53, "EFFCore.esm") as Formlist
		Int i = FollowerList.GetSize()
		While i > 0
			i -= 1
			Follower = FollowerList.GetAt(i) as ObjectReference
			LicUtil.ConfiscateFollowerAllLics(Follower)
			ObjectReference EffInv = Eff.GetEffInv(Follower)
			If EffInv
				LicUtil.ConfiscateFollowerAllLics(Follower)
			EndIf
		EndWhile
	Else
		Int i = DialogueFollower.GetNumAliases()
		While i > 0
			i -= 1
			Follower = (DialogueFollower.GetNthAlias(i) as ReferenceAlias).GetReference() as ObjectReference
			If Follower
				LicUtil.ConfiscateFollowerAllLics(Follower)
			EndIf
		EndWhile
	EndIf
	GoToState("")
EndFunction

State InProc
	Function ProcAllFollowersAllLics(Bool MustBeLoaded)
	EndFunction
EndState

Quest Property DialogueFollower Auto

_SLS_LicenceUtil Property LicUtil Auto
_SLS_InterfaceEff Property Eff Auto
