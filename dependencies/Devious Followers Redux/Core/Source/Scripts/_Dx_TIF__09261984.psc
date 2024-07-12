;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname _Dx_TIF__09261984 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.RemoveDevice(libs.PlayerRef, I , R, libs.zad_DeviousArmbinder)
(GetOwningQuest() As _DDeal).Triggered = False
(Humility As _DflowHumliation).BoundHands = 0
(tool As _DFtools).ReduceResist(2)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


zadlibs Property libs  Auto  

Armor Property R  Auto  

Armor Property I  Auto  

Quest Property Humility Auto

Quest Property Tool Auto
