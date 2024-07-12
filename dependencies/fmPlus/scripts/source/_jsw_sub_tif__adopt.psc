;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname _JSW_SUB_TIF__Adopt Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Attempt adoption
FMAdoptQuest.SetCurrentStageID(10)
	string result = FMAdoptScript.TryAdoptChildMcm(akSpeaker)
;FMAdoptQuest.SetCurrentStageID(20)


Debug.Notification(result)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
_JSW_SUB_AdoptionScript Property FMAdoptScript  Auto                     ; 
Quest	Property	FMAdoptQuest	Auto
