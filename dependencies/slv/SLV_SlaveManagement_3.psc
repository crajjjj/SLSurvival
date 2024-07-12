;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveManagement_3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

ActorUtil.AddPackageOverride(akSpeaker , SLV_SlaveFollowPlayer ,100)
akSpeaker.evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_SlaveFollowPlayer Auto
