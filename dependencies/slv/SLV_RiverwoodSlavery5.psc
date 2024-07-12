;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodSlavery5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(1000)

Game.GetPlayer().RemoveItem(Gold, 5000)

SLV_RiverwoodTask1.Start() 
SLV_RiverwoodTask1.SetStage(0)
SLV_RiverwoodTask1.SetActive(true)

SLV_RiverwoodTask2.Start() 
SLV_RiverwoodTask2.SetStage(0)
SLV_RiverwoodTask2.SetActive(true)

SLV_RiverwoodTask3.Start() 
SLV_RiverwoodTask3.SetStage(0)
SLV_RiverwoodTask3.SetActive(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_RiverwoodTask1 Auto
Quest Property SLV_RiverwoodTask2 Auto
Quest Property SLV_RiverwoodTask3 Auto
MiscObject Property Gold  Auto  