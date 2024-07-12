;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_DFlow_09004E3B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
    Q.DebtInc()
    (GetOwningQuest() As _Dflowconditionals).DebtPunTimer = Utility.GetCurrentGameTime() + 0.02
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q  Auto  
; This comes from "Remember, I need my fair share too." on _DFlow misc dialog.