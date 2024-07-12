;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname TIF__0408DD27 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Util.StopAllGuardWarnApproachQuests(akSpeaker, DoCooldown = true)
Util.SendDoSpecificNpcSpankEvent(Timeout = 4.0, AllowNpcInFurniture = false, akActor = akSpeaker, DialogWait = true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Utility Property Util Auto
