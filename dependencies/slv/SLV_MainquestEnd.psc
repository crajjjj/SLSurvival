;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestEnd Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_AbolitionismQuest.isrunning()
	SLV_AbolitionismQuest.setStage(11000)
endif

Game.GetPlayer().AddItem(Gold, 5000)

Debug.messagebox("This is the bad slaver end of Slaverun Reloaded. Thank you for playing.")

GetOwningQuest().SetObjectiveCompleted(12000)
GetOwningQuest().SetStage(29000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
MiscObject Property Gold Auto  
Quest Property SLV_AbolitionismQuest Auto

