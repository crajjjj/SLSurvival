;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 14
Scriptname SLV_WalkOfShame2_Walking2 Extends Scene Hidden

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
GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(4500)
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
SLV_Horse1.getActorRef().enable()
SLV_Horse1.getActorRef().moveto(horsestart)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
SLV_FindSpectators.stop()
SLV_FindSpectators.reset()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
myScripts.SLV_DeviousUnEquip(false,false,false,false,false,false,false,true,false,false,false,false,false,false,false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto  
Quest Property SLV_FindSpectators Auto 
ReferenceAlias Property SLV_You Auto



function SLV_FillWatcherRefs()
SLV_Spectator1 = spectators.Alias_Spectator1
SLV_Spectator2 = spectators.Alias_Spectator2
SLV_Spectator3 = spectators.Alias_Spectator3
SLV_Spectator4 = spectators.Alias_Spectator4
SLV_Spectator5 = spectators.Alias_Spectator5
SLV_Spectator6 = spectators.Alias_Spectator6

SLV_Spectator1.ForceRefTo(spectators.Alias_Spectator1.getActorRef())
SLV_Spectator2.ForceRefTo(spectators.Alias_Spectator2.getActorRef())
SLV_Spectator3.ForceRefTo(spectators.Alias_Spectator3.getActorRef())
SLV_Spectator4.ForceRefTo(spectators.Alias_Spectator4.getActorRef())
SLV_Spectator5.ForceRefTo(spectators.Alias_Spectator5.getActorRef())
SLV_Spectator6.ForceRefTo(spectators.Alias_Spectator6.getActorRef())

SLV_Raper1 = walkOfShame.Alias_SLV_Bellamy
SLV_Raper2 = walkOfShame.Alias_SLV_Murphy
SLV_Watcher1 = walkOfShame.Alias_SLV_Watcher1
SLV_Watcher2 = walkOfShame.Alias_SLV_Watcher2

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

MiscUtil.PrintConsole("Spectator1: " + SLV_Spectator1)
MiscUtil.PrintConsole("Spectator1: " + SLV_Spectator1.getActorRef())
MiscUtil.PrintConsole("Spectator1: " + SLV_Spectator1.getActorRef().getActorBase())
MiscUtil.PrintConsole("Spectator1: " + SLV_Spectator1.getActorRef().getActorBase().getName())

MiscUtil.PrintConsole("Spectator1: " + SLV_Spectator1.getActorRef().getActorBase().getName())
MiscUtil.PrintConsole("Spectator2: " + SLV_Spectator2.getActorRef().getActorBase().getName())
MiscUtil.PrintConsole("Spectator3: " + SLV_Spectator3.getActorRef().getActorBase().getName())
MiscUtil.PrintConsole("Spectator4: " + SLV_Spectator4.getActorRef().getActorBase().getName())
MiscUtil.PrintConsole("Spectator5: " + SLV_Spectator5.getActorRef().getActorBase().getName())
MiscUtil.PrintConsole("Spectator6: " + SLV_Spectator6.getActorRef().getActorBase().getName())

MiscUtil.PrintConsole("Watcher1: " + SLV_Watcher1.getActorRef().getActorBase().getName())
MiscUtil.PrintConsole("Watcher2: " + SLV_Watcher2.getActorRef().getActorBase().getName())

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

ReferenceAlias Property SLV_Horse1 Auto
ObjectReference Property horsestart Auto

SLV_FindSpecators Property spectators auto
SLV_WalkOfShame2 Property walkOfShame auto






