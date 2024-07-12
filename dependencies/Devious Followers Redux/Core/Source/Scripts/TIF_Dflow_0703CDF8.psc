;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_0703CDF8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Float Hrs = _DflowDealBaseDays.GetValue() * 24
_DFlowDealHelp.Show(_DflowDealBaseDebt.GetValue(),Hrs,_DflowDealBasePrice.GetValue())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Message Property _DFlowDealHelp  Auto  
GlobalVariable Property _DflowDealBasePrice Auto
GlobalVariable Property _DflowDealBaseDebt Auto
GlobalVariable Property _DflowDealBaseDays Auto
GlobalVariable Property _DflowDealMulti Auto
GlobalVariable Property _DflowDealOP Auto
GlobalVariable Property _DflowDealHP Auto
GlobalVariable Property _DflowDealBP Auto
GlobalVariable Property _DflowDealOPTimer Auto
GlobalVariable Property _DflowDealHPTimer Auto
GlobalVariable Property _DflowDealBPTimer Auto 
