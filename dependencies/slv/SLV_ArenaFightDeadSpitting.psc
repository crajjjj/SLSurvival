;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 28
Scriptname SLV_ArenaFightDeadSpitting Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
myScripts.SLV_DisplayInformation("End of Spitting Scene")

if MCMMenu.arenaBeheading
	SLV_ArenaChoppingScene.Start()
else	
	SLV_ArenaResurrectionScene.Start()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
Amputee.SLV_AmputeeActor(SLV_DeadPlayer.getActorRef(),2)
Utility.wait(1.0)

Amputee.SLV_AmputeeActor(SLV_DeadPlayer.getActorRef(),6)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SLV_deadplayer.getActorRef().moveto(SLV_Gladiator.getActorRef())

debug.SendAnimationEvent(SLV_deadplayer.getActorRef(), "ZazAPCAO052")

myScripts.SLV_SexlabStripNPC2(SLV_deadplayer.getActorRef(), false)

SLV_deadplayer.getActorRef().moveto(SLV_Gladiator.getActorRef())

debug.SendAnimationEvent(SLV_deadplayer.getActorRef(), "ZazAPCAO052")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
Amputee.SLV_AmputeeActor(SLV_DeadPlayer.getActorRef(),0)
Utility.wait(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
Amputee.SLV_AmputeeActor(SLV_DeadPlayer.getActorRef(),1)
Utility.wait(1.0)

Amputee.SLV_AmputeeActor(SLV_DeadPlayer.getActorRef(),4)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property SLV_ArenaChoppingScene Auto 
Scene Property SLV_ArenaResurrectionScene Auto 

GlobalVariable Property SLV_SexIsRunning Auto 
SLV_PrepareDeadPlayer Property deadPlayer Auto

ReferenceAlias Property SLV_ChoppingBlock Auto
ReferenceAlias Property SLV_DeadPlayer Auto

ReferenceAlias Property SLV_Gladiator Auto

SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto

SLV_Amputee Property Amputee Auto


