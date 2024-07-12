Scriptname _SLS_TollDodgeDisguise extends ReferenceAlias  

Bool IsInProc = false

GlobalVariable Property _SLS_TollDodgeHuntRadius Auto
GlobalVariable Property _SLS_TollDodgeHuntRadiusTown Auto
GlobalVariable Property _SLS_TollDodgeHuntRadiusGuards Auto

Actor Property PlayerRef Auto

_SLS_LocTrackCentral Property LocTrack Auto
SLS_Mcm Property Menu Auto

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Armor
		BeginArmorChange()
	EndIf
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Armor
		BeginArmorChange()
	EndIf
EndEvent

Function BeginArmorChange()
	GoToState("InProc")
		Utility.Wait(0.5)
		While IsInProc
			IsInProc = false
			Utility.Wait(0.5)
		EndWhile
		ProcArmorChange()
	GoToState("")
EndFunction

State InProc
	Function BeginArmorChange()
		IsInProc = true
	EndFunction
EndState

Function ProcArmorChange()
	Armor Cuirass = PlayerRef.GetWornForm(0x00000004) as Armor
	Armor Hood = PlayerRef.GetWornForm(0x00000002) as Armor ; Hair
	If Hood == None
		Hood = PlayerRef.GetWornForm(0x00000001) as Armor ; Head
	EndIf
	
	Float SpotDistance = Menu.GuardSpotDistNom ; Cities
	Float BodyPenalty
	Float HeadPenalty
	
	Float SpotDistanceTown = Menu.GuardSpotDistTown ; Small towns
	Float BodyPenaltyTown
	Float HeadPenaltyTown
	If Cuirass == None
		BodyPenalty = SpotDistance * Menu.TollDodgeDisguiseBodyPenalty
		BodyPenaltyTown = SpotDistanceTown * Menu.TollDodgeDisguiseBodyPenalty
	EndIf
	If Hood == None
		HeadPenalty = SpotDistance * Menu.TollDodgeDisguiseHeadPenalty
		HeadPenaltyTown = SpotDistanceTown * Menu.TollDodgeDisguiseHeadPenalty
		
	EndIf
	_SLS_TollDodgeHuntRadius.SetValue(SpotDistance + BodyPenalty + HeadPenalty)
	_SLS_TollDodgeHuntRadiusTown.SetValue(SpotDistanceTown + BodyPenaltyTown + HeadPenaltyTown)
	SetGuardDistance(LocTrack.PlayerCurrentLocIndex)
	;Debug.Messagebox("Spot distance: " + _SLS_TollDodgeHuntRadius.GetValue())
EndFunction

Function SetGuardDistance(Int LocInt)
	; Set the distance guards as enforcers can spot you at depending on your location
	If LocInt >= 5 ; Not in a walled city
		_SLS_TollDodgeHuntRadiusGuards.SetValue(_SLS_TollDodgeHuntRadiusTown.GetValue())
	Else
		_SLS_TollDodgeHuntRadiusGuards.SetValue(_SLS_TollDodgeHuntRadius.GetValue())
	EndIf
EndFunction
