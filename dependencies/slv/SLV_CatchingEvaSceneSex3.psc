;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingEvaSceneSex3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_PlaySex3Synchron(Game.GetPlayer(),SLV_Sigrid.getactorref(), SLV_Alvor.getActorRef(), "Sex", true)
SLV_SexIsRunning.setvalue(0)

ActorUtil.ClearPackageOverride(SLV_Sigrid.getactorref())
SLV_Sigrid.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_Sigrid Auto 
ReferenceAlias Property SLV_Alvor Auto

