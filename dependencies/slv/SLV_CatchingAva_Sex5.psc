;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingAva_Sex5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Sex", true)
Utility.wait(2.0)

myScripts.SLV_PlaySex2Synchron(SLV_Ava.getActorRef(),SLV_Innkeeper.getActorRef(), "Anal", true)
SLV_SexIsRunning.setvalue(0)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_Ava Auto
ReferenceAlias Property SLV_Innkeeper Auto
