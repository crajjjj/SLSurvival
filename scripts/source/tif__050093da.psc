;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__050093DA Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If PlayerRef.WornHasKeyword(Devious.zad_DeviousArmbinder)
	Devious.RemoveDevice(PlayerRef, Devious.zad_armBinderHisec_Inventory)
EndIf
PlayerRef.AddItem(Main.StrippedClothes, 1, false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_InterfaceDevious Property Devious Auto
SLS_Main Property Main Auto
Actor Property PlayerRef Auto
