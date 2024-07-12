;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial8_12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5500)
GetOwningQuest().SetStage(6000)

myScripts.SLV_PlayerMoveTo(WindhelmWayMarker )
Slave.GetActorRef().moveto(WindhelmWayMarker )
Brutus.GetActorRef().moveto(WindhelmWayMarker )
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Slave Auto 
ReferenceAlias Property Brutus Auto 
ObjectReference Property WindhelmWayMarker Auto

SLV_Utilities Property myScripts auto