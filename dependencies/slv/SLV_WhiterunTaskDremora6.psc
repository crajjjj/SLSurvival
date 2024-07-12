;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunTaskDremora6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if(SLV_Antislavery.getStage() == 0)
	SLV_Antislavery.SetObjectiveCompleted(0)
	SLV_Antislavery.SetStage(500)
endif
if(SLV_Antislavery.getStage() == 50)
	SLV_Antislavery.SetObjectiveCompleted(50)
	SLV_Antislavery.SetStage(500)
endif
if(SLV_Antislavery.getStage() == 1000)
	SLV_Antislavery.SetObjectiveCompleted(1000)
	SLV_Antislavery.SetStage(1500)
endif
GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_Antislavery Auto
