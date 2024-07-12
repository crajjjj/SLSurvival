;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 14
Scriptname SLV_EnslavementPart1Scene9 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
SLV_FindSpectators.stop()
SLV_FindSpectators.reset()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SendModEvent("dhlp-Resume")
debug.SendAnimationEvent(Game.GetPlayer(), "IdleForceDefaultState")
GetOwningQuest().SetObjectiveCompleted(4500)
GetOwningQuest().SetStage(5000)
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
SLV_FindSpectators.start()
SLV_Dog.getActorRef().moveto(SLV_Brutus.getActorRef())

SLV_You.getActorRef().moveto(Game.getplayer())
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

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Sven Auto
ReferenceAlias Property SLV_Brutus Auto
ReferenceAlias Property SLV_Dog Auto
GlobalVariable Property SLV_SexIsRunning Auto  
Quest Property SLV_FindSpectators Auto 
ReferenceAlias Property SLV_You Auto

