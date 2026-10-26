;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__05009EB1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Devious.EquipDevice(PlayerRef, Devious.zad_armBinderHisec_Inventory)
Main.BeginKnockStay()
_SLS_Knock.LetIn()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Main Property Main Auto
Actor Property PlayerRef Auto
_SLS_InterfaceDevious Property Devious Auto
