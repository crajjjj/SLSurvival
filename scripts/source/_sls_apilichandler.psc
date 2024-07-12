Scriptname _SLS_ApiLicHandler extends Quest  

Function IssueLicHandle(Int LicenceType, Int TermDuration, Form Issuer, Form GiveLicTo, Bool DeductGold, Form Sender)
	GoToState("Busy")
	AddLicToQueue(LicenceType, TermDuration, Issuer, GiveLicTo, DeductGold, Sender)
	BeginProcQueue()
	GoToState("")
EndFunction

State Busy
	Function IssueLicHandle(Int LicenceType, Int TermDuration, Form Issuer, Form GiveLicTo, Bool DeductGold, Form Sender)
		AddLicToQueue(LicenceType, TermDuration, Issuer, GiveLicTo, DeductGold, Sender)
	EndFunction
EndState

Function AddLicToQueue(Int LicenceType, Int TermDuration, Form Issuer, Form GiveLicTo, Bool DeductGold, Form Sender)
	StorageUtil.IntListInsert(Self, "LicenceType", 0, LicenceType)
	StorageUtil.IntListInsert(Self, "TermDuration", 0, TermDuration)
	StorageUtil.FormListInsert(Self, "Issuer", 0, Issuer)
	StorageUtil.FormListInsert(Self, "GiveLicTo", 0, GiveLicTo)
	StorageUtil.IntListInsert(Self, "DeductGold", 0, DeductGold as Int)
	StorageUtil.FormListInsert(Self, "Sender", 0, Sender)
EndFunction

Function BeginProcQueue()
	While StorageUtil.FormListCount(Self, "Sender") > 0
		Int LicenceType = StorageUtil.IntListPop(Self, "LicenceType")
		Int TermDuration = StorageUtil.IntListPop(Self, "TermDuration")
		Form Issuer = StorageUtil.FormListPop(Self, "Issuer")
		Form GiveLicTo = StorageUtil.FormListPop(Self, "GiveLicTo")
		Bool DeductGold = StorageUtil.IntListPop(Self, "DeductGold") as Bool
		Form Sender = StorageUtil.FormListPop(Self, "Sender")
		
		Debug.Trace("_SLS_: On_SLS_IssueLicence: Received event with parameters: LicenceType - " + LicenceType + ", TermDuration - " + TermDuration + ", Issuer - " + Issuer + ", GiveLicTo - " + GiveLicTo + ", DeductGold - " + DeductGold + ", Sender - " + Sender)
		If CheckIssueLicenceParameters(LicenceType, TermDuration, Issuer, DeductGold, Sender)
			ObjectReference Licence = LicUtil.IssueLicence(Issuer as Actor, LicenceType, TermDuration, DeductGold = DeductGold, IsModEvent = true)
			If GiveLicTo as ObjectReference
				(GiveLicTo as ObjectReference).AddItem(Licence)
			Else
				Debug.Trace("_SLS_: On_SLS_IssueLicence: Received an invalid ObjRef for GiveLicTo")
			EndIf
			Api.SendLicenceIssuedEvent(Licence, LicenceType, TermDuration, Sender)
		EndIf
	EndWhile
EndFunction

Bool Function CheckIssueLicenceParameters(Int LicenceType, Int TermDuration, Form Issuer, Bool DeductGold, Form Sender)
	If !(LicenceType >= 0 && LicenceType <= 8)
		Debug.Trace("_SLS_: CheckIssueLicenceParameters: Received invalid parameter for LicenceType: " + LicenceType)
		Return false
		
	ElseIf !(TermDuration >=0 && TermDuration <= 2)
		Debug.Trace("_SLS_: CheckIssueLicenceParameters: Received invalid parameter for TermDuration: " + TermDuration)
		Return false
		
	ElseIf !(Issuer as Actor)
		Debug.Trace("_SLS_: CheckIssueLicenceParameters: Received invalid parameter for Issuer: " + Issuer)
		Return false
		
	ElseIf Sender == None
		Debug.Trace("_SLS_: CheckIssueLicenceParameters: Received invalid parameter for Sender: " + Sender)
		Return false
	EndIf
	Return true
EndFunction

_SLS_Api Property Api Auto
_SLS_LicenceUtil Property LicUtil Auto
