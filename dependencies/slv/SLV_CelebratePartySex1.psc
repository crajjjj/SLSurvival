;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CelebratePartySex1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play3Sex(Elisif.getActorRef(), JarlWhiterun.getActorRef(), JarlWindhelm.getActorRef(), "MMF, Sex", true)

Utility.wait(3.0)
myScripts.SLV_Play3Sex(Maven.getActorRef(), Zaid.getActorRef(), JarlMarkarth.getActorRef(), "MMF,Sex", true)

Utility.wait(3.0)
myScripts.SLV_Play2Sex(JarlMorthal.getActorRef(), JarlFalkreath.getActorRef(), "Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property JarlWhiterun Auto 
ReferenceAlias Property JarlWindhelm Auto 
ReferenceAlias Property JarlMarkarth Auto 
ReferenceAlias Property JarlFalkreath Auto 
ReferenceAlias Property JarlMorthal Auto 

ReferenceAlias Property Maven Auto 
ReferenceAlias Property Elisif Auto 
ReferenceAlias Property Zaid Auto 


