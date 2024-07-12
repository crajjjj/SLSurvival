;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__040896ED Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Util.StopAllGuardWarnApproachQuests(akSpeaker, DoCooldown = true)
PlayerRef.RemoveItem(Gold001, 200)
Main.StartSexAnal(akSpeaker, SexCat = -1, DecWillIncFame = false, Victim = PlayerRef, TeleportType = 0)
LicUtil.SetMandatoryGag(akSpeaker)
LicUtil.EquipMandatoryGag()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto

MiscObject Property Gold001 Auto

_SLS_LicenceUtil Property LicUtil Auto
SLS_Main Property Main Auto
SLS_Utility Property Util Auto
