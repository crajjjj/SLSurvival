Scriptname _SLS_LicenceSnowberry extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForSingleUpdate(3.0) ; 30 s made the start licences arrive up to half a minute late
	EndIf
EndEvent

Event OnUpdate()
	If Menu.CanEnableSnowberry()
		RegisterForSingleUpdate(3.0)
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
	; Always the regular armor licence: a bikini licence on its own puts the bikini curse on the player
		Api.On_SLS_IssueLicence(LicenceType = 2, TermDuration = 0, Issuer = TheDude, GiveLicTo = PlayerRef, DeductGold = false, Sender = Self) ; Armor licence
	If LicUtil.LicClothesEnable == 1
		Api.On_SLS_IssueLicence(LicenceType = 4, TermDuration = 0, Issuer = TheDude, GiveLicTo = PlayerRef, DeductGold = false, Sender = Self) ; Clothes licence
	EndIf
	; Starts that put the player in their own house (house key in the inventory) also get the property licence,
	; otherwise the house is taken away right after the start
	If LicUtil.LicPropertyEnable && LicUtil.OwnsProperty
		Api.On_SLS_IssueLicence(LicenceType = 8, TermDuration = 0, Issuer = TheDude, GiveLicTo = PlayerRef, DeductGold = false, Sender = Self) ; Property licence
	EndIf
	Menu.SnowberryEnable = false
EndFunction

SLS_Mcm Property Menu Auto
_SLS_Api Property Api Auto
_SLS_LicenceUtil Property LicUtil Auto

Actor Property PlayerRef Auto

Quest Property MQ101 Auto
