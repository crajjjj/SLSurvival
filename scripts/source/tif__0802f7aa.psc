;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0802F7AA Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Init.KennelState = 2
((akSpeaker as ObjectReference) as SLS_KennelKeeper).EquipDevices()
((akSpeaker as ObjectReference) as SLS_KennelKeeper).AcceptDeal(false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLS_Init Property Init Auto
