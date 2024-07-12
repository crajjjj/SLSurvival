;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_Mainquest_Brutus03 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(250)
GetOwningQuest().SetStage(1100)

SLV_Freequest.Start() 
SLV_Freequest.SetActive(true)
SLV_Freequest.SetStage(0) 

myScripts.SLV_SerialStrip()
myScripts.SLV_removeitems(Game.GetPlayer()) 
myScripts.SLV_StripBothHands(Game.GetPlayer())

slaveprogress.StartProgressForFreeWoman()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_Freequest Auto
SLV_Utilities Property myScripts auto
SLV_EnslavingProgress Property slaveprogress auto

