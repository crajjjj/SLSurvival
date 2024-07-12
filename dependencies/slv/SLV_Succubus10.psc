;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Succubus10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().ModObjectiveGlobal(1, SLV_SuccubusSex ,4000, SLV_MaxTask.getValue() as int)
	GetOwningQuest().SetObjectiveCompleted(4000)
	GetOwningQuest().SetStage(4500)
endif

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Vaginal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SuccubusSex Auto 
GlobalVariable Property SLV_MaxTask  Auto  
