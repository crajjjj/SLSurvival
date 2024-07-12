Scriptname _SLS_LicenceSnowberry extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForSingleUpdate(30.0)
	EndIf
EndEvent

Event OnUpdate()
	If Menu.CanEnableSnowberry()
		RegisterForSingleUpdate(30.0)
	Else
		GiveLicences()
	EndIf
EndEvent

Function GiveLicences()
	Actor TheDude = Game.GetFormFromFile(0x046213, "SL Survival.esp") as Actor
	Api.On_SLS_IssueLicence(LicenceType = 1, TermDuration = 0, Issuer = TheDude, GiveLicTo = PlayerRef, DeductGold = false, Sender = Self) ; Weapon licence
	If LicUtil.LicMagicEnable
		Api.On_SLS_IssueLicence(LicenceType = 0, TermDuration = 0, Issuer = TheDude, GiveLicTo = PlayerRef, DeductGold = false, Sender = Self) ; Magic licence
	EndIf
	If LicUtil.LicBikiniEnable
		Api.On_SLS_IssueLicence(LicenceType = 3, TermDuration = 0, Issuer = TheDude, GiveLicTo = PlayerRef, DeductGold = false, Sender = Self) ; Bikini licence
	Else
		Api.On_SLS_IssueLicence(LicenceType = 2, TermDuration = 0, Issuer = TheDude, GiveLicTo = PlayerRef, DeductGold = false, Sender = Self) ; Armor licence
	EndIf
	If LicUtil.LicClothesEnable == 1
		Api.On_SLS_IssueLicence(LicenceType = 4, TermDuration = 0, Issuer = TheDude, GiveLicTo = PlayerRef, DeductGold = false, Sender = Self) ; Clothes licence
	EndIf
	Menu.SnowberryEnable = false
EndFunction

SLS_Mcm Property Menu Auto
_SLS_Api Property Api Auto
_SLS_LicenceUtil Property LicUtil Auto

Actor Property PlayerRef Auto

Quest Property MQ101 Auto
