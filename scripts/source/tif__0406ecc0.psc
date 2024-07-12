;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF__0406ECC0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor Keeper = KeeperRapeAlias.GetReference() as Actor
KeeperRapeAlias.Clear()
Keeper.EvaluatePackage()
Utility.WaitMenuMode(2.0)
KeeperScript.KeeperSex()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property KeeperRapeAlias Auto
SLS_KennelKeeperPlayerAlias Property KeeperScript Auto
_SLS_InterfaceDevious Property Devious Auto

Actor Property PlayerRef Auto
