;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname sr_OPUForcedEndEnd Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If !(GetOwningQuest() as sr_OrcPickup).keepArmbinder
    (GetOwningQuest() as sr_OrcPickup).ManipulateArmbinder(false)
EndIf
SendModEvent("dhlp-Resume")
GetOwningQuest().SetStage(61)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
