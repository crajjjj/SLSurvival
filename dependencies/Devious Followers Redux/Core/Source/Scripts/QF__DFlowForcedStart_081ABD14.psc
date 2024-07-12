;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname QF__DFlowForcedStart_081ABD14 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Guard
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Follower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Follower Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
Utility.wait(60)
setstage(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
Float startDebt = _DflowEnslaveDebt.GetValue() + _DflowDebtPerDay.GetValue()*3
(Q as QF__Gift_09000D62).StartNewAgreement(None, 10)
Utility.Wait(5)

(Q as QF__Gift_09000D62).Debt(startDebt)
(Q as _DflowConditionals).DebtPunTimer = Utility.GetCurrentGameTime()  + 0.05

Float contractTime = _DFlowMinimumContractRemaining.GetValue()
If contractTime < 0.0
  contractTime = 0.0
EndIf
contractTime += 1.0
_DFlowMinimumContractRemaining.SetValue(contractTime)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
libs.RemoveQuestDevice(libs.PlayerRef, I , R, libs.zad_DeviousHeavyBondage, KeyKW)
Alias_Guard.Clear()
Utility.Wait(2)
SetStage(30)
Utility.Wait(4.0)
libs.PlayerRef.RemoveItem(I, 1, True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
libs.RemoveQuestDevice(libs.PlayerRef, I , R, libs.zad_DeviousHeavyBondage, KeyKW)
Alias_Guard.Clear()
Reset()
SetStage(0)
Utility.Wait(4.0)
libs.PlayerRef.RemoveItem(I, 1, True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
libs.EquipDevice(libs.PlayerRef, I , R, libs.zad_DeviousHeavyBondage)
Utility.Wait(3.0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Function JustStopIt()
    If GetStage() > 0
        libs.RemoveQuestDevice(libs.PlayerRef, I , R, libs.zad_DeviousHeavyBondage, KeyKW)
        Alias_Guard.Clear()
        Reset()
        SetStage(0)
        Utility.Wait(4.0)
        libs.PlayerRef.RemoveItem(I, 1, True)
    EndIf
EndFunction

zadlibs Property libs  Auto  
Armor Property I  Auto  
Armor Property R  Auto  
Keyword Property KeyKW  Auto  
Quest Property Q Auto
GlobalVariable Property _DFlowEnslaveDebt Auto
GlobalVariable Property _DFlowDebtPerDay Auto
GlobalVariable Property _DFlowMinimumContractRemaining Auto
