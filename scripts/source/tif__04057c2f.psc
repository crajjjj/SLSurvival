;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__04057C2F Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
TollDodge.CrimeGold = 0
TollDodge.DoTakeStuff(akSpeaker, CrimeGoldToAdd = _SLS_PickPocketFailStealValue.GetValueInt(), NotifyType = 1)
PpFail.EndPickpocketFailFg(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_TollDodge Property TollDodge Auto
_SLS_PickPocketFailDetect Property PpFail Auto

GlobalVariable Property _SLS_PickPocketFailStealValue Auto
