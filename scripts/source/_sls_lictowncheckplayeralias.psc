Scriptname _SLS_LicTownCheckPlayerAlias extends ReferenceAlias  

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If LicUtil.IsObjectContraband(akBaseItem, LocTrack.PlayerCurrentLocIndex)
		_SLS_LicTownViolation.SetValueInt(1)
	EndIf
EndEvent

Function GetShouldApproach()
	GoToState("InProc")
	LicUtil.LicInfractionType = -1
	Int TownLoc = LocTrack.PlayerCurrentLocIndex
	If TownLoc <= 4 ; If is in walled city don't stop for no escorts
		Init.HasEnoughFollowers = 1
	Else
		TollUtil.TollHasEnoughFollowers(false)
	EndIf
	If !LicUtil.IsMagicCollarCompliant(PlayerRef)
		_SLS_LicTownViolation.SetValueInt(1)
		LicUtil.LicInfractionType = 0
		GoToState("")
		;Debug.Messagebox("Should approach for collar")
		Return
	ElseIf LicUtil.HasAnyContraband(PlayerRef, TownLoc)
		_SLS_LicTownViolation.SetValueInt(1)
		GoToState("")
		;Debug.Messagebox("Should approach contraband")
		Return
	ElseIf Init.HasEnoughFollowers < 1
		_SLS_LicTownViolation.SetValueInt(1)
		GoToState("")
		;Debug.Messagebox("Should approach No follower")
		Return
	ElseIf ContraCheck.GateLicenceCheckFollowers(true, TownLoc)
		_SLS_LicTownViolation.SetValueInt(1)
		LicUtil.LicInfractionType = 6
		GoToState("")
		;Debug.Messagebox("Should approach for follower contraband")
		Return
		
	ElseIf LicUtil.LicPropertyEnable && LicUtil.OwnsProperty && !LicUtil.HasValidPropertyLicence && !Eviction.IsLicenceEvicted
		_SLS_LicTownViolation.SetValueInt(1)
		LicUtil.LicInfractionType = 7
		GoToState("")
		Return
	EndIf
	_SLS_LicTownViolation.SetValueInt(0)
	GoToState("")
	;Debug.Messagebox("Should NOT approach")
	Return
EndFunction

State InProc
	Function GetShouldApproach()
	EndFunction
	
	Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	EndEvent
EndState

Function TrapDialogueClose()
	RegisterForMenu("Dialogue Menu")
EndFunction

Event OnMenuClose(String MenuName)
	TeleportToEscortMarker()
	UnRegisterForMenu("Dialogue Menu")
EndEvent

Function TeleportToEscortMarker()
	UnRegisterForMenu("Dialogue Menu")
	Utility.Wait(1.0)
	FadeToBlack.Apply()
	Utility.Wait(3.0)
	PlayerRef.MoveTo(LocTrack.GetForcedEscortTpMarker())
	Utility.Wait(1.0)
	ObjectReference Escort
	While Escort == None && _SLS_EscortsList.GetSize() > 0
		Escort = _SLS_EscortsList.GetAt(Utility.RandomInt(0, _SLS_EscortsList.GetSize() - 1)) as ObjectReference
		If (Escort as Actor).IsDead()
			_SLS_EscortsList.RemoveAddedForm(Escort)
			Escort = None
		EndIf
	EndWhile
	If Escort
		Escort.MoveTo(PlayerRef)
		Utility.Wait(0.5)
		If !Dflow.AddDfFollower(followerToAddForm = Escort, debtToAdd = 0, forceGoldControlMode = false, minimumContractDays = 0.0)
			If Game.GetModByName("EFFCore.esm") != 255
				Eff.AddFollower(Escort)
			Else
				(DialogueFollower as DialogueFollowerScript).SetFollower(Escort)
			EndIf
			;StorageUtil.SetFloatValue(Escort, "_DFMC_HireTime", Utility.GetCurrentGameTime())
		EndIf
		
	Else
		Debug.Messagebox("Assign escort failed: No followers found. Most likely you have no set up escorts.")
	EndIf
EndFunction

;/
ObjectReference Function GetTeleportMarker()
	Int TownLoc = LocTrack.PlayerCurrentLocIndex
	Debug.Messagebox("TownLoc: " + TownLoc)
	If TownLoc == 5 ; Riverwood
		Return _SLS_EscortTpWhiterun
	ElseIf TownLoc == 6 ; Falkreath
		Return _SLS_EscortTpWhiterun
	ElseIf TownLoc == 7 ; Dawnstar
		Return _SLS_EscortTpWindhelm
	ElseIf TownLoc == 8 ; Winterhold
		Return _SLS_EscortTpWindhelm
	ElseIf TownLoc == 9 ; Rorikstead
		Return _SLS_EscortTpWhiterun
	ElseIf TownLoc == 10 ; Shors Stone
		Return _SLS_EscortTpRiften
	ElseIf TownLoc == 11 ; Ivarstead
		Return _SLS_EscortTpRiften
	ElseIf TownLoc == 12 ; Dragon Bridge
		Return _SLS_EscortTpSolitude
	ElseIf TownLoc == 13 ; Morthal
		Return _SLS_EscortTpSolitude
	ElseIf TownLoc == 14 ; Kynesgrove
		Return _SLS_EscortTpWindhelm
	EndIf
EndFunction
/;
;Int Property TownLoc Auto Hidden

Actor Property PlayerRef Auto

GlobalVariable Property _SLS_LicTownViolation Auto

Formlist Property _SLS_EscortsList Auto

ObjectReference Property _SLS_EscortTpWhiterun Auto
ObjectReference Property _SLS_EscortTpSolitude Auto
ObjectReference Property _SLS_EscortTpMarkarth Auto
ObjectReference Property _SLS_EscortTpWindhelm Auto
ObjectReference Property _SLS_EscortTpRiften Auto

ImageSpaceModifier Property FadeToBlack Auto

Keyword Property VendorItemSpellTome Auto
Keyword Property _SLS_BikiniArmor Auto

SLS_EvictionTrack Property Eviction Auto
_SLS_LicenceUtil Property LicUtil Auto
_SLS_LicFolContrabandCheck Property ContraCheck Auto
_SLS_InterfaceEff Property Eff Auto
_SLS_InterfaceDeviousFollowers Property Dflow Auto
SLS_Init Property Init Auto
_SLS_TollUtil Property TollUtil Auto
_SLS_LocTrackCentral Property LocTrack Auto

Quest Property DialogueFollower Auto ; Get DialogueFollowerScript at run time because EFF removes the script.... :S
