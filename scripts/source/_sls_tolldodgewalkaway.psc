Scriptname _SLS_TollDodgeWalkAway extends Quest  

Int Property WalkAwayState Auto Hidden

Actor Property akSpeaker Auto Hidden

_SLS_LicenceUtil Property LicUtil Auto
_SLS_TollDodge Property TollDodge Auto
SLS_Init Property Init Auto

Event OnInit()
	If Self.IsRunning()
		RegisterForMenu("Dialogue Menu")
		WalkAwayState = 0
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	WalkAwayProc()
	Self.Stop()
EndEvent

Function WalkAwayProc()
	; Function to process actions when the player walks away when caught for toll evasion
	; Proclevel:
	; 0 - Walked away before taking gold
	; 1 - Walked away before taking stuff
	; 2 - Walked away before revoking licence
	; 3 - Walked away before setting mandatory restraints
	; 4 - Walked away before equipping mandatory restraints
	; 5 = completed
	
	;Debug.Messagebox("WalkAwayState: " + WalkAwayState)
	
	
	If WalkAwayState < 5
		; Take Gold
		If WalkAwayState <= 0
			TollDodge.HuntSuccessTakeGold(akSpeaker)
		EndIf
		
		; Take stuff
		If WalkAwayState <= 1
			;TollDodge.BeginTakeStuff(akSpeaker)
			TollDodge.AddBounty()
		EndIf
		
		; Revoke random licence
		If WalkAwayState <= 2 && Init.LicencesEnable
			LicUtil.RevokeRandomLicence(akSpeaker)
			Utility.Wait(2.0) ; Wait for licence script to react to removing a licence
			LicUtil.DoGateObjectInspection()
		EndIf
		
		; Do mandatory restraints
		If WalkAwayState <= 3 && Init.DdsInstalled
			TollDodge.SetRetraintsMandatory()
		EndIf
		
		If WalkAwayState <= 4 && Init.DdsInstalled
			LicUtil.EquipMandatoryRestaints()
		EndIf
	EndIf
EndFunction
	