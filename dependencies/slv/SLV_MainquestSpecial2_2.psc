;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial2_2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor slave = Actor03.GetActorRef()
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(1000)
Game.GetPlayer().RemoveItem(DeviousItem, 5)

;slave.moveto(Game.GetPlayer())
ActorUtil.ClearPackageOverride(slave)
slave.evaluatePackage()

if ThisMenu.skipCreatureSex	
	Game.FadeOutGame(false, true, 5.0, 10.0)
	debug.messagebox("When you regain consciousness, you body hurts as hell and you a drenched in cum.")
else
	myScripts.SLV_Play2Sex(Game.GetPlayer(),Dog, "Anal", true)
endif

Utility.wait(2)
myScripts.SLV_Play2Sex(slave ,akSpeaker, "Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property ThisMenu auto
ReferenceAlias Property Actor03 Auto 
Actor Property Dog  Auto  
Armor Property DeviousItem  Auto 