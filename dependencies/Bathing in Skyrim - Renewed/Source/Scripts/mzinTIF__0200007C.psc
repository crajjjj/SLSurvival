;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname mzinTIF__0200007C Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
mzinUtil.LogNotification(akSpeaker.GetBaseObject().GetName() + " feels " + Math.Floor(StorageUtil.GetFloatValue(akSpeaker, "BiS_Dirtiness") * 100.0) + "% dirty.")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

mzinUtility Property mzinUtil Auto
