;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WinterholdCrazyAltmer2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(1000)

if(SLV_Antislavery.getStage() == 0)
	SLV_Antislavery.SetObjectiveCompleted(0)
	SLV_Antislavery.SetStage(1000)
endif
if(SLV_Antislavery.getStage() == 50)
	SLV_Antislavery.SetObjectiveCompleted(50)
	SLV_Antislavery.SetStage(1000)
endif
if(SLV_Antislavery.getStage() == 500)
	SLV_Antislavery.SetObjectiveCompleted(500)
	SLV_Antislavery.SetStage(1500)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_Antislavery Auto
