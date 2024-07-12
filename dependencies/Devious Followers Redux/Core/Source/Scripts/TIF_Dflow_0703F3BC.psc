;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_0703F3BC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

;MCM.Message("Removal")
Float T = _DFlowRemovalDebtTimes.GetValue() - 100
_DFRemoval.Show(_DflowRemovalBasePrice.GetValue(), _DFlowRemovalInc.GetValue(), T)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property _DflowRemovalBasePrice Auto  
GlobalVariable Property _DFlowRemovalInc Auto  
GlobalVariable Property _DFlowRemovalDebtTimes Auto 
Message Property _DFRemoval Auto
