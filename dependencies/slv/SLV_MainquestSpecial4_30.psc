;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial4_30 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; swap the aliases
pJarl.ForceRefTo(pJarlBackup.GetActorRef())
Utility.wait(2.0)

GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property pJarl  Auto  
ReferenceAlias Property pJarlBackup  Auto  


