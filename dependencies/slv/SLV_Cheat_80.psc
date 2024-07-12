;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat_80 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_MapMarker.enable()

SLV_Leonardo.GetActorRef().enable()
SLV_Michelangela.GetActorRef().enable()

myScripts.SLV_enslavementNPC(SLV_Michelangela.getActorRef())
myScripts.SLV_enslavementChains(SLV_Michelangela.getActorRef())

GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(5000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property SLV_MapMarker Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Leonardo Auto 
ReferenceAlias Property SLV_Michelangela Auto 

