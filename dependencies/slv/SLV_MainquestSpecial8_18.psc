;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial8_18 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8500)
GetOwningQuest().SetStage(9000)

myScripts.SLV_PlayerMoveTo(BrutusWayMarker )
Brutus.GetActorRef().moveto(BrutusWayMarker )
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Brutus Auto 
ObjectReference Property BrutusWayMarker Auto

SLV_Utilities Property myScripts auto