;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_08073547 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
_DDeal owning = GetOwningQuest() As _DDeal

Bool coin = Utility.randomInt(0,1) As Bool
Float willpower = _DFlowWill.GetValue()
Float low = _DWillLow.GetValue()
Float mid = _DWillMed.GetValue()

If willpower > mid

	_DFlowDealPMsgHW.Show()
	owning.DelayDay()

Elseif willpower > low

	If coin
		_DFlowDealPMsgMWYes.Show()
		owning.DelayDay()
		Tool.SexGrope(akSpeaker) 
	Else
		_DFlowDealPMsgMWNo.Show()
		owning.DelayHrs( Utility.RandomFloat(2.0, 10.0) )
	EndIf

Else

	If coin
		_DFlowDealPMsgLWYes.Show()
		owning.DelayDay()
		Tool.SexGrope(akSpeaker) 
	Else
		_DFlowDealPMsgLWNo.show()
		owning.DelayHrs(Utility.randomFloat(2.0,10.0))
	EndIf

EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_Dftools Property Tool Auto


Message Property _DFlowDealPMsgHW  Auto  
Message Property _DFlowDealPMsgMWYes  Auto
Message Property _DFlowDealPMsgMWNo  Auto
Message Property _DFlowDealPMsgLWYes  Auto
Message Property _DFlowDealPMsgLWNo  Auto  
GlobalVariable Property _DflowWill Auto
GlobalVariable Property _DWillMed Auto
GlobalVariable Property _DWillLow Auto
