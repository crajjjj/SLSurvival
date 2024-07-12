Scriptname _SLS_Licence extends ObjectReference  

_SLS_LicenceUtil Property LicUtil Auto

Actor Property PlayerRef Auto

Formlist Property _SLS_LicenceShortList Auto
Formlist Property _SLS_LicenceLongList Auto

String Property LicenceTypeStr Auto Hidden

Int Property LicTypeInt Auto Hidden

Float Property ExpiryDate Auto Hidden
Float Property ValidFor Auto Hidden

Event OnRead()
	If ValidFor < 1000.0
		Debug.Messagebox("This " + LicenceTypeStr + "licence expires on the " + LicUtil.GetExiryDateAsReadableString(ExpiryDate) + ;/"\n" +/; GetExpiryStatement())
	EndIf
EndEvent

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If akNewContainer == PlayerRef || akOldContainer == PlayerRef
		LicUtil.BeginUpdateLicenceExpiry(LicTypeInt)
		If akNewContainer == None ; Dropped to ground probably. Need to set the owner as the player in this case or you have to 'steal' it from the ground. Cell ownership thing?
			Self.SetActorOwner(PlayerRef.GetActorBase())
		Else
			; Clear ownership. If ownership is set to the player then guards confiscate it during bounty clear dialogue. (Wait, I know you.)
			Self.SetActorOwner(None)
		EndIf
	EndIf
EndEvent

Function InitLicence(Int LicType, Int LicTerm)
	If SetLicType(LicType) && SetLicTerm(LicTerm)
		LicTypeInt = LicType
		ExpiryDate = Math.Ceiling(Utility.GetCurrentGameTime()) + ValidFor
		StorageUtil.SetFloatValue(Self, "_SLS_LicenceExpiry", ExpiryDate)
	Else
		Debug.Trace("_SLS_: InitLicence() Licence setup failed: LicType: " + LicType + ". LicTerm: " + LicTerm)
	EndIf
EndFunction

Bool Function SetLicTerm(Int LicTerm)
	If LicTerm == 0 ; Short
		ValidFor = LicUtil.LicShortDur
	ElseIf LicTerm == 1 ; Long
		ValidFor = LicUtil.LicLongDur
	ElseIf LicTerm == 2 ; Perpetual
		ValidFor = 1000000000.0
	Else
		Debug.Trace("_SLS_: SetLicTerm(): Received invalid LicTerm: " + LicTerm)
		Return false
	EndIf
	Return true
EndFunction

Bool Function SetLicType(Int LicType)
	If LicType == 0
		LicenceTypeStr = "magic "
	ElseIf LicType == 1
		LicenceTypeStr = "weapon "
	ElseIf LicType == 2
		LicenceTypeStr = "armor "
	ElseIf LicType == 3
		LicenceTypeStr = "bikini "
	ElseIf LicType == 4
		LicenceTypeStr = "clothes "
	ElseIf LicType == 5
		LicenceTypeStr = "curfew "
	ElseIf LicType == 6
		LicenceTypeStr = "whore "
	ElseIf LicType == 7
		LicenceTypeStr = "freedom "
	ElseIf LicType == 8
		LicenceTypeStr = "property "
	Else
		Debug.Trace("_SLS_: SetLicType(): Received invalid LicType: " + LicType)
		Return false
	EndIf
	Return true
EndFunction

String Function GetExpiryStatement()
	Int Expiry = (ExpiryDate as Int) - Math.Ceiling(Utility.GetCurrentGameTime())
	If Expiry < 1
		Return "It's already expired."
	Elseif Expiry == 1
		Return "That's tomorrow."
	Else
		Return "That's in " + Expiry + " days."
	EndIf
EndFunction
