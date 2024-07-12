;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__0500F000 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
PlayerRef.RemoveItem(Gold001, _MA_Cost.GetValueInt())
if Init.IsSgoMilkable
Main.MilkSgoNpc(akSpeaker)
Else
Main.MilkMmeNpc(akSpeaker)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


Actor Property PlayerRef  Auto  

GlobalVariable Property _MA_Cost  Auto  

MiscObject Property Gold001  Auto  
_MA_Main Property Main Auto
_MA_Init Property Init Auto
