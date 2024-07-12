;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiftenJailRape12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getStage() == 1100
	;GetOwningQuest().SetObjectiveCompleted(1100)
	getowningquest().setstage(1200)
elseif GetOwningQuest().getStage() == 2100
	;GetOwningQuest().SetObjectiveCompleted(2100)
	getowningquest().setstage(2200)
elseif GetOwningQuest().getStage() == 3100
	;GetOwningQuest().SetObjectiveCompleted(3100)
	getowningquest().setstage(3200)
elseif GetOwningQuest().getStage() == 4100
	;GetOwningQuest().SetObjectiveCompleted(4100)
	getowningquest().setstage(4200)
endif

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Sex", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
