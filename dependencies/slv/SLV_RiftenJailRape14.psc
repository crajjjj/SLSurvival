;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiftenJailRape14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getStage() == 1200
	;GetOwningQuest().SetObjectiveCompleted(1200)
	getowningquest().setstage(1300)
elseif GetOwningQuest().getStage() == 2200
	;GetOwningQuest().SetObjectiveCompleted(2200)
	getowningquest().setstage(2300)
elseif GetOwningQuest().getStage() == 3200
	;GetOwningQuest().SetObjectiveCompleted(3200)
	getowningquest().setstage(3300)
elseif GetOwningQuest().getStage() == 4200
	;GetOwningQuest().SetObjectiveCompleted(4200)
	getowningquest().setstage(4300)
endif

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Boobjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
