;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Dawnstar5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor Jarl = FemaleJarl.GetActorRef()
GetOwningQuest().SetObjectiveCompleted(2000)
; female Jarl
if Jarl.getActorBase().getSex() == 1
	GetOwningQuest().SetStage(2300)
else
	GetOwningQuest().SetStage(2500)
endif

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Blowjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
ReferenceAlias Property FemaleJarl  Auto  


