;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0412E853 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "furniturefallchance", Missing = 100.0) > Utility.RandomFloat(0.0, 100.0)
	SteepFall.Trip(true)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_SteepFall Property SteepFall Auto
