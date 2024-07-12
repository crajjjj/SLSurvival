;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_DFlow_0A018796 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Float a = Lives.GetValue()/LivesM.GetValue() 
Bool needRest = SQ.CanRecover() && Will.GetValue() <= 5.0

If needRest
    If a >= 0.66
        _DFlowDebtHLR.Show(Debt.GetValue())
    ElseIf a >= 0.33 
        _DFlowDebtMLR.Show(Debt.GetValue())
    ElseIf a > 0.0
        _DFlowDebtLLR.Show(Debt.GetValue())
    Else
        _DFlowDebt0L.Show()
    EndIf
Else
    If a >= 0.66
        _DFlowDebtHL.Show(Debt.GetValue())
    ElseIf a >= 0.33 
        _DFlowDebtML.Show(Debt.GetValue())
    ElseIf a > 0.0
        _DFlowDebtLL.Show(Debt.GetValue())
    Else
        _DFlowDebt0L.Show()
    EndIf
EndIf

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property Debt  Auto 
GlobalVariable Property Will  Auto  
GlobalVariable Property Lives Auto
GlobalVariable Property LivesM Auto
Message Property _DFlowDebtHL Auto
Message Property _DFlowDebtHLR Auto
Message Property _DFlowDebtML Auto
Message Property _DFlowDebtMLR Auto
Message Property _DFlowDebtLL Auto
Message Property _DFlowDebtLLR Auto
Message Property _DFlowDebt0L Auto
_DflowSleepQuestScript  Property SQ auto
