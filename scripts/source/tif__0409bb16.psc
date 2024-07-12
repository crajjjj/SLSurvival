;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0409BB16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Util.SendDoSpecificNpcSpankEvent(Timeout = 3.0, AllowNpcInFurniture = true, akActor = akspeaker, DialogWait = false)
_SLS_HelloSpankCooloffQuest.Stop()
_SLS_HelloSpankCooloffQuest.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Utility Property Util Auto

Quest Property _SLS_HelloSpankCooloffQuest Auto
