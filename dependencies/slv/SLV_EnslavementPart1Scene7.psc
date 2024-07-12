;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 17
Scriptname SLV_EnslavementPart1Scene7 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SLV_FindSpectators.start()
SLV_Dog.getActorRef().moveto(SLV_Brutus.getActorRef())
SLV_You.getActorRef().moveto(Game.getplayer())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

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
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
SLV_FindSpectators.stop()
SLV_FindSpectators.reset()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto  
Quest Property SLV_FindSpectators Auto 
ReferenceAlias Property SLV_Dog Auto
ReferenceAlias Property SLV_Brutus Auto
ReferenceAlias Property SLV_You Auto


