Scriptname SLSF_DebugSpell_ExcludeNPC extends activemagiceffect  

Faction Property AlreadyInitialized Auto
Faction Property ExcludeNPC Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akTarget.GetFactionRank(AlreadyInitialized) > 0
		Int Exclusion = StorageUtil.GetIntValue(akTarget, "SLSF.Exclusion", Missing = -1)
		If Exclusion > 0
			StorageUtil.SetIntValue(akTarget, "SLSF.Exclusion", 0)
			akTarget.SetFactionRank(ExcludeNPC, 0)
			Debug.Notification("Actor: "+akTarget.GetDisplayName()+" -> NOT Excluded.")
		Else
			StorageUtil.SetIntValue(akTarget, "SLSF.Exclusion", 1)
			akTarget.SetFactionRank(ExcludeNPC, 1)
			Debug.Notification("Actor: "+akTarget.GetDisplayName()+" -> Excluded.")
		EndIf
	Else
		Debug.Notification("Subject not yet Initalized, re-try after 30 seconds")
	EndIf
EndEvent