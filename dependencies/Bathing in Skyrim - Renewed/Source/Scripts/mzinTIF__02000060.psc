;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname mzinTIF__02000060 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
mzinUtil.LogNotification(akSpeaker.GetBaseObject().GetName() + " feels " + Math.Floor(StorageUtil.GetFloatValue(akSpeaker, "BiS_Dirtiness") * 100.0) + "% dirty.")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

mzinUtility Property mzinUtil Auto