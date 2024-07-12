;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname TIF_Dflow_080A9CC3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningquest() as  QF__Gift_09000D62).Tool.PiercingActivate(True, 5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int debtGold = _Dflowdebt.GetValue() as Int
If debtGold > 1
    debtGold -= 1
    PlayerRef.RemoveItem(Gold001, debtGold)
    Q.DebtPay(debtGold)
Else
    Q.SetDebt(1)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

MiscObject Property Gold001  Auto  

Actor Property PlayerRef  Auto  
QF__Gift_09000D62 Property q  Auto  

Faction Property Fac  Auto  

GlobalVariable Property _DflowDebt  Auto  
