;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial6Horse1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if MCMMenu.skipCreatureSex	
	;Game.FadeOutGame(false, true, 5.0, 10.0)
	;debug.messagebox("When you regain consciousness, you body hurts as hell and you a drenched in cum.")
	return
endif

ActorUtil.AddPackageOverride(Horse1.getActorRef(), SLV_FollowPlayer ,100)
Horse1.getActorRef().evaluatePackage()

myScripts.SLV_PlaySex2Synchron(Nimriel.getActorRef(),Horse1.getActorRef(), "Anal", true)

Utility.wait(10.0)
ActorUtil.ClearPackageOverride(akSpeaker )
akSpeaker.evaluatePackage()

ActorUtil.ClearPackageOverride(Horse1.getActorRef())
Horse1.getActorRef( ).evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_FollowPlayer Auto
SLV_Utilities Property myScripts auto 
ReferenceAlias Property Horse1 Auto 
ReferenceAlias Property Nimriel Auto 
SLV_MCMMenu Property MCMMenu Auto