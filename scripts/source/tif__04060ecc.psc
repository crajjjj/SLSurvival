;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__04060ECC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If _SLS_KennelExtraDevices.GetValueInt()
	Devious.EquipRandomDds(PlayerRef, 1)
EndIf
KeeperScript.KeeperSex()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_KennelKeeperPlayerAlias Property KeeperScript Auto
_SLS_InterfaceDevious Property Devious Auto

Actor Property PlayerRef Auto

GlobalVariable Property _SLS_KennelExtraDevices Auto
