;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 20
Scriptname sr_SolitudeHorseDelivery Extends Quest Hidden

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Pump1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Pump1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Odall
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Odall Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Pump3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Pump3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Geimund
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Geimund Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OdallWaitLocation
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OdallWaitLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerPeeLocation
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerPeeLocation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY OdallOpenValveLoc
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_OdallOpenValveLoc Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StablesBarrelSurface
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_StablesBarrelSurface Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Pump2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Pump2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StablesBarrel
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_StablesBarrel Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GeimundWaitLoc
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GeimundWaitLoc Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
; Player filled, sent to Solitude
SetObjectiveDisplayed(10, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
; Refill player
SetObjectiveDisplayed(40)
retryScene.start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; Follow Odall to the barrel
SetObjectiveDisplayed(0, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
; Player deflated
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
; Wait for Odall to get more product and stuff
RegisterForSingleUpdateGameTime(Utility.RandomFloat(24.0, 48.0))
SetObjectiveCompleted(20)
SetObjectiveDisplayed(25)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
Alias_StablesBarrel.GetReference().Disable()
Alias_StablesBarrelSurface.GetReference().Disable()
ftu.SetStage(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
; Player filled again, go to Solitude with belt
SetObjectiveDisplayed(50)
Alias_StablesBarrel.GetReference().Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
; Inflation done, Odall checks up on player
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
; Player refused to continue
retryScene.Start()
ForcePlayerToInflate()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
SetObjectiveDisplayed(60)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
; Wait done, go back for more
SetObjectiveCompleted(25)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
; Player cramped and lost the delivery, return to sender
SetObjectiveFailed(10)
SetObjectiveDisplayed(20, true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property retryScene auto

sr_inflateQuest Property inflater auto
sr_FTUDeliveryFrame Property ftu auto
Faction Property QSTFaction auto



Event OnUpdateGameTime()
	SetStage(30)
EndEvent

Function DeliverToGeimund()
	RegisterForModEvent("ftu.shb.deliveryanimate", "StartFilling")
	SendModEvent("ftu.shb.deliveryanimate")
	inflater.QueueActor(inflater.player, false, inflater.VAGINAL, inflater.GetVaginalCum(inflater.player), time = 30.0, animate = 12)
	inflater.InflateQueued()
;	inflater.Deflate(inflater.player, false, inflater.GetVaginalCum(inflater.player), 12)
	SetStage(55)
EndFunction

Function ForcePlayerToInflate()
	Game.DisablePlayerControls()
	inflater.player.MoveTo(alias_OdallWaitLocation.GetReference())
	Alias_Odall.GetReference().MoveTo(Alias_OdallOpenValveLoc.GetReference())
	Alias_Pump3.GetReference().Activate(inflater.player)
EndFunction

Event StartFilling(String eventName, String argString, float argNum, Form Sender)
	UnregisterForModevent("ftu.shb.deliveryanimate")
	Utility.Wait(0.5)
	ObjectReference s = Alias_StablesBarrelSurface.GetReference()
	s.Enable()
	Utility.Wait(0.3)
	s.TranslateTo(s.x, s.y, s.z + 50, s.GetAngleX(), s.GetAngleY(), s.GetAngleZ(), 1.66667) ; 1.66667 units per second, should take 30s to move 50 units up.
	;-11444 -11394
EndEvent

