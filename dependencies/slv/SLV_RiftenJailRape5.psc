;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiftenJailRape5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getStage() == 1000
	;GetOwningQuest().SetObjectiveCompleted(1000)
	getowningquest().setstage(1100)
elseif GetOwningQuest().getStage() == 2000
	;GetOwningQuest().SetObjectiveCompleted(2000)
	getowningquest().setstage(2100)
elseif GetOwningQuest().getStage() == 3000
	;GetOwningQuest().SetObjectiveCompleted(3000)
	getowningquest().setstage(3100)
elseif GetOwningQuest().getStage() == 4000
	;GetOwningQuest().SetObjectiveCompleted(4000)
	getowningquest().setstage(4100)
endif

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Blowjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
