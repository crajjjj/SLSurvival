Scriptname SLSF_DebugSpell_AssignRT extends activemagiceffect  

SLSF_Utility Property SLSFUtility Auto
Faction Property AlreadyInitialized Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akTarget.GetFactionRank(AlreadyInitialized) >= 2
		Debug.Notification(SLSFUtility.GetRoleType(akTarget))
		Debug.Notification("SLSF Debug, Assign RT Target: "+akTarget.GetDisplayName()+".")
		
		UIListMenu ListOfRoleType = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
		ListOfRoleType.AddEntryItem("$SLSF_ROLETYPENAME_00")
		ListOfRoleType.AddEntryItem("$SLSF_ROLETYPENAME_01")
		ListOfRoleType.AddEntryItem("$SLSF_ROLETYPENAME_02")
		ListOfRoleType.AddEntryItem("$SLSF_ROLETYPENAME_20")
		ListOfRoleType.AddEntryItem("$SLSF_ROLETYPENAME_21")
		ListOfRoleType.AddEntryItem("$SLSF_ROLETYPENAME_22")
		ListOfRoleType.AddEntryItem("$SLSF_ROLETYPENAME_40")
		ListOfRoleType.AddEntryItem("$SLSF_ROLETYPENAME_41")
		ListOfRoleType.AddEntryItem("$SLSF_ROLETYPENAME_42")
		ListOfRoleType.AddEntryItem("$SLSF_KEEPTHEACTUAL")
		ListOfRoleType.OpenMenu()
		Int Selected = ListOfRoleType.GetResultInt()
		
		If Selected == 0
			SLSFUtility.SetTheRoleType(akTarget, 0)
		ElseIf Selected == 1
			SLSFUtility.SetTheRoleType(akTarget, 1)
		ElseIf Selected == 2
			SLSFUtility.SetTheRoleType(akTarget, 2)
		ElseIf Selected == 3
			SLSFUtility.SetTheRoleType(akTarget, 20)
		ElseIf Selected == 4
			SLSFUtility.SetTheRoleType(akTarget, 21)
		ElseIf Selected == 5
			SLSFUtility.SetTheRoleType(akTarget, 22)
		ElseIf Selected == 6
			SLSFUtility.SetTheRoleType(akTarget, 40)
		ElseIf Selected == 7
			SLSFUtility.SetTheRoleType(akTarget, 41)
		ElseIf Selected == 8
			SLSFUtility.SetTheRoleType(akTarget, 42)
		EndIf
	Else
		Debug.Notification("$SLSF_DEBUGASSIGNRT_NOTINITIALIZED")
	EndIf
EndEvent
