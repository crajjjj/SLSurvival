;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__0204B694 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If _df_global.CanDismissFollower(akSpeaker)
    TweakDFScript pDFScript = (pDialogueFollower As TweakDFScript)
    If (pDFScript)
        pDFScript.DialogueRef = akSpeakerRef
        pDFScript.DismissFollower(0, 0)
    EndIf
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


Quest Property pDialogueFollower  Auto  
