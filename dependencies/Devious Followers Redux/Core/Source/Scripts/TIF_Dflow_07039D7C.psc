;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_07039D7C Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Float b = _DFlowGambleJPot.GetValue()
_DFlowGambleRolls.Show((b*0.6),(b*0.134),(b*0.534),(b*0.267),(b*0.4667))
_DFlowGambleRolls2.Show((b*0.334),(b*0.4),(b*0.467),(b*0.34),(b),(b*0.267))
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Message Property _DFlowGambleRolls  Auto  
Message Property _DFlowGambleRolls2  Auto  

GlobalVariable Property NewProperty  Auto  

GlobalVariable Property _DFlowGambleJPot  Auto  
_DFlowMCM Property MCM Auto