;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodAlvor8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)

Sigrid.getActorRef().moveto(akSpeaker)
ActorUtil.ClearPackageOverride(Sigrid.getActorRef())
Sigrid.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(Sigrid.getActorRef(), SLV_DoNothing,100)
Sigrid.getActorRef().evaluatePackage()

myScripts.SLV_Play2Sex(Sigrid.getActorRef(),akSpeaker, "Vaginal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
ReferenceAlias Property Sigrid Auto
Package Property SLV_DoNothing Auto




