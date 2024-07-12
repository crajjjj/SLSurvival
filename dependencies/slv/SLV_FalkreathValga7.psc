;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathValga7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(2000)

int count = falkreathCount.getValue() as Int
count+=1
falkreathCount.setValue(count)
if count >= 3
	falkreathmain.SetObjectiveCompleted(3500)
	falkreathmain.setStage(4000)
endif

Game.GetPlayer().AddItem(Gold, 50)

myScripts.SLV_Play2Sex(akSpeaker , Game.GetPlayer(), "", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
Quest Property falkreathmain Auto
GlobalVariable Property falkreathCount Auto
MiscObject Property Gold  Auto 

