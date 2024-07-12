;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 17
Scriptname SLV_WalkOfShame2_Walking1 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
myScripts.SLV_DeviousUnEquip(false,false,false,false,false,false,false,true,false,false,false,false,false,false,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SLV_FindSpectators.start()
SLV_You.getActorRef().moveto(Game.getplayer())

SLV_FillWatcherRefs()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.EnablePlayerControls()
debug.SendAnimationEvent(Game.GetPlayer(), "IdleForceDefaultState")
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SLV_FindSpectators.stop()
SLV_FindSpectators.reset()
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

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
debug.SendAnimationEvent(Game.GetPlayer(), "ZazAPC058")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto  
Quest Property SLV_FindSpectators Auto 
ReferenceAlias Property SLV_You Auto


function SLV_FillWatcherRefs()
SLV_Watcher1.Clear()
SLV_Watcher2.Clear()


if SLV_Raper1.getActorRef() != SLV_Spectator1.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator1.getActorRef()	
	SLV_Watcher1.ForceRefTo(SLV_Spectator1.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator2.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator2.getActorRef()	
	SLV_Watcher1.ForceRefTo(SLV_Spectator2.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator3.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator3.getActorRef()	
	SLV_Watcher1.ForceRefTo(SLV_Spectator3.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator4.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator4.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator4.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator5.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator5.getActorRef()	
	SLV_Watcher1.ForceRefTo(SLV_Spectator5.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator6.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator6.getActorRef()
	SLV_Watcher1.ForceRefTo(SLV_Spectator6.getActorRef())
endif

if SLV_Raper1.getActorRef() != SLV_Spectator1.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator1.getActorRef()	&& SLV_Watcher1.getActorRef() != SLV_Spectator1.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator1.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator2.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator2.getActorRef()	&& SLV_Watcher1.getActorRef() != SLV_Spectator2.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator2.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator3.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator3.getActorRef()	&& SLV_Watcher1.getActorRef() != SLV_Spectator3.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator3.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator4.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator4.getActorRef()	&& SLV_Watcher1.getActorRef() != SLV_Spectator4.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator4.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator5.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator5.getActorRef()	&& SLV_Watcher1.getActorRef() != SLV_Spectator5.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator5.getActorRef())
elseif SLV_Raper1.getActorRef() != SLV_Spectator6.getActorRef() && SLV_Raper2.getActorRef() != SLV_Spectator6.getActorRef()	&& SLV_Watcher1.getActorRef() != SLV_Spectator6.getActorRef() 
	SLV_Watcher2.ForceRefTo(SLV_Spectator6.getActorRef())
endif

myScripts.SLV_DisplayInformation("Spectator1: " + SLV_Spectator1.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator2: " + SLV_Spectator2.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator3: " + SLV_Spectator3.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator4: " + SLV_Spectator4.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator5: " + SLV_Spectator5.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Spectator6: " + SLV_Spectator6.getActorRef().getActorBase().getName())

myScripts.SLV_DisplayInformation("Watcher1: " + SLV_Watcher1.getActorRef().getActorBase().getName())
myScripts.SLV_DisplayInformation("Watcher2: " + SLV_Watcher2.getActorRef().getActorBase().getName())

SLV_Watcher1.ForceRefTo(SLV_Spectator1.getActorRef())
SLV_Watcher2.ForceRefTo(SLV_Spectator2.getActorRef())
EndFunction

SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Raper1 Auto
ReferenceAlias Property SLV_Raper2 Auto

ReferenceAlias Property SLV_Watcher1 Auto
ReferenceAlias Property SLV_Watcher2 Auto

ReferenceAlias Property SLV_Spectator1 Auto
ReferenceAlias Property SLV_Spectator2 Auto
ReferenceAlias Property SLV_Spectator3 Auto
ReferenceAlias Property SLV_Spectator4 Auto
ReferenceAlias Property SLV_Spectator5 Auto
ReferenceAlias Property SLV_Spectator6 Auto



