;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial6_16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)

if MCMMenu.skipCreatureSex	
	Game.FadeOutGame(false, true, 5.0, 10.0)
	debug.messagebox("When you regain consciousness, your slave is drenched in cum.")
else
	myScripts.SLV_Play2Sex(MCMMenu.slavefollower,Dog2.getActorRef() , "Anal", true)
endif

ActorUtil.ClearPackageOverride(Dog2.getActorRef())
Dog2.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Dog2 Auto 
SLV_MCMMenu Property MCMMenu Auto
