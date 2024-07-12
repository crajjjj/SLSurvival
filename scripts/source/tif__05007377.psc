;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__05007377 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.SendAnimationEvent(akSpeaker, "IdleTake")
If Main.KnockHost != None
	ObjectReference StrippedClothes = PlayerRef.DropObject(PlayerRef.GetWornForm(0x00000004), 1)
	Main.StrippedClothes = StrippedClothes
	Main.KnockHost.AddItem(StrippedClothes, 1)
	Util.StripAll(PlayerRef, Menu.DropItems, false)
Else
	PlayerRef.UnequipItem(PlayerRef.GetWornForm(0x00000004))
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto
SLS_Main Property Main Auto
SLS_Utility Property Util Auto
SLS_Mcm Property Menu Auto
