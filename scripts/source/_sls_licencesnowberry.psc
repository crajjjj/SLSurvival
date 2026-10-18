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
	; Queued, then issued in one pass: one call per licence would wait 2 s after each
	Api.LicHandle.AddLicToQueue(1, 0, TheDude, PlayerRef, false, Self) ; Weapon licence
	If LicUtil.LicMagicEnable
		Api.LicHandle.AddLicToQueue(0, 0, TheDude, PlayerRef, false, Self) ; Magic licence
	EndIf
	; Always the regular armor licence: a bikini licence on its own puts the bikini curse on the player
	Api.LicHandle.AddLicToQueue(2, 0, TheDude, PlayerRef, false, Self) ; Armor licence
	If LicUtil.LicClothesEnable == 1
		Api.LicHandle.AddLicToQueue(4, 0, TheDude, PlayerRef, false, Self) ; Clothes licence
	EndIf
	; Starts that put the player in their own house (house key in the inventory) also get the property licence,
	; otherwise the house is taken away right after the start
	If LicUtil.LicPropertyEnable && LicUtil.OwnsProperty
		Api.LicHandle.AddLicToQueue(8, 0, TheDude, PlayerRef, false, Self) ; Property licence
	EndIf
	Api.LicHandle.ProcessQueue()
	Menu.SnowberryEnable = false
EndFunction

SLS_Mcm Property Menu Auto
_SLS_Api Property Api Auto
_SLS_LicenceUtil Property LicUtil Auto

Actor Property PlayerRef Auto

Quest Property MQ101 Auto
