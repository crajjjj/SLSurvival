;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial6_26 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)

if MCMMenu.skipCreatureSex	
	Game.FadeOutGame(false, true, 5.0, 10.0)
	debug.messagebox("When you regain consciousness, you slave is drenched in cum.")
else
	myScripts.SLV_Play2Sex(MCMMenu.slavefollower,Dog1.getActorRef(), "Anal", true)
endif

ActorUtil.ClearPackageOverride(Dog1.getActorRef())
Dog1.getActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Dog1 Auto 
SLV_MCMMenu Property MCMMenu Auto
