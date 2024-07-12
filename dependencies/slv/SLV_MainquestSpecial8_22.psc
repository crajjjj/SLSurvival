;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial8_22 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6500)
GetOwningQuest().SetStage(7000)

myScripts.SLV_PlayerMoveTo(StrongholdWayMarker)
Slave.GetActorRef().moveto(StrongholdWayMarker )
Brutus.GetActorRef().moveto(StrongholdWayMarker )

myScripts.SLV_BrutusMoodChange(false,2) 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Slave Auto 
ReferenceAlias Property Brutus Auto 
ObjectReference Property StrongholdWayMarker Auto
