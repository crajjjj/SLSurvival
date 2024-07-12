Scriptname SLSF_DebugSpell_NoComment extends activemagiceffect  

Faction Property AlreadyInitialized Auto
Faction Property NoCommentFaction Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akTarget.GetFactionRank(AlreadyInitialized) > 0
		Int NoComment = StorageUtil.GetIntValue(akTarget, "SLSF.NoComment", Missing = -1)
		If NoComment > 0
			StorageUtil.SetIntValue(akTarget, "SLSF.NoComment", 0)
			akTarget.SetFactionRank(NoCommentFaction, 0)
			Debug.Notification("Actor: "+akTarget.GetDisplayName()+" -> Will comment.")
		Else
			StorageUtil.SetIntValue(akTarget, "SLSF.NoComment", 1)
			akTarget.SetFactionRank(NoCommentFaction, 1)
			Debug.Notification("Actor: "+akTarget.GetDisplayName()+" -> Will NOT comment anymore.")
		EndIf
	Else
		Debug.Notification("Subject not yet Initalized, re-try after 30 seconds")
	EndIf
EndEvent