;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 16
Scriptname SLV_EnslavementPart1Scene6 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SendModEvent("dhlp-Resume")
debug.SendAnimationEvent(Game.GetPlayer(), "IdleForceDefaultState")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)

GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
debug.SendAnimationEvent(SLV_Sven.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Brutus.getActorRef(), "IdleForceDefaultState")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
debug.SendAnimationEvent(SLV_Sven.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Brutus.getActorRef(), "IdleForceDefaultState")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto  
ReferenceAlias Property SLV_Sven Auto
ReferenceAlias Property SLV_Brutus Auto

