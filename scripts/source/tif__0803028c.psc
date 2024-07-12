;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__0803028C Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Init.KennelForceGreetIntroDone = true
Utility.WaitMenuMode(2.0)
KeeperScript.KeeperSex()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto

GlobalVariable Property _SLS_KennelExtraDevices Auto

SLS_KennelKeeperPlayerAlias Property KeeperScript Auto
SLS_Init Property Init Auto

_SLS_InterfaceDevious Property Devious Auto
