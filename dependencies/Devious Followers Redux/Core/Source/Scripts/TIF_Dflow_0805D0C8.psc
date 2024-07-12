;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_0805D0C8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
getOwningQuest().setStage(2)
Shop.RemoveAllItems(PlayerRef, True);

tool.RandomDevice(70)
Playerref.Removeitem(gold001,200)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property Shop  Auto  

Actor Property PlayerRef  Auto  

_DFtools Property tool  Auto  

MiscObject Property Gold001  Auto  
