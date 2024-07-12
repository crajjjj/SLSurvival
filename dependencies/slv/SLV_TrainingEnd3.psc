;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_TrainingEnd3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.RemoveAllPackageOverride(SLV_DragonsreachCenter)

ActorUtil.ClearPackageOverride(SLV_Valentina.getactorref())
SLV_Valentina.GetActorRef().evaluatePackage()

myScripts.SLV_IvanaReset()

if(SLV_quest.getStage() == 1000)
	SLV_quest.SetObjectiveCompleted(1000)
	SLV_quest.SetStage(1200)

elseif(SLV_quest.getStage() == 1100)
	SLV_quest.SetObjectiveCompleted(1100)
	SLV_quest.SetStage(1200)
endif

myScripts.SLV_miniLevelUp()
;Game.getplayer().additem(SLV_SexSlaveVol03.getReference())

GetOwningQuest().SetObjectiveCompleted(10000)
if(SLV_quest.getStage() > 1450)
	GetOwningQuest().SetStage(10500)
else
	GetOwningQuest().SetStage(11000)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Valentina Auto 
SLV_Utilities Property myScripts auto
Quest Property SLV_quest Auto
Package Property SLV_DragonsreachCenter auto
ReferenceAlias Property SLV_SexSlaveVol03 Auto

