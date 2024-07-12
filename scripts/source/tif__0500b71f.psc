;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0500B71F Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Util.StripAll(PlayerRef, Menu.DropItems, true)
PlayerRef.RemoveItem(Gold001, (_SLS_TollCost.GetValueInt() * 2))
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Mcm Property Menu Auto
SLS_Utility Property Util Auto
Actor Property PlayerRef Auto
GlobalVariable Property _SLS_TollCost Auto
MiscObject Property Gold001 Auto
