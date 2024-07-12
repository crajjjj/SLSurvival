;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_DawnstarSailerSlut4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int count = dawnstarCount.getValue() as Int
count+=1
dawnstarCount.setValue(count)
if count >= 2
	dawnstarmain.SetObjectiveCompleted(1500)
	dawnstarmain.setStage(2000)
endif

GetOwningQuest().SetObjectiveCompleted(2000)
GetOwningQuest().SetStage(2500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property dawnstarmain Auto
GlobalVariable Property dawnstarCount Auto
