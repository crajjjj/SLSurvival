;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Slavetraining_IvanaName Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_AmputeeIvana.setValue(0)
Amputee.SLV_AmputeeActor(SLV_Ivana.getActorRef(),0)
Utility.wait(2.0)

SLV_Ivana.getActorRef().getActorBase().setName("Ivana Tittyfuck")
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Amputee Property Amputee Auto
ReferenceAlias Property SLV_Ivana Auto
GlobalVariable Property SLV_AmputeeIvana Auto 
