;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_RiftenJailRape9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getStage() == 1300
	;GetOwningQuest().SetObjectiveCompleted(1300)
	getowningquest().setstage(1400)
elseif GetOwningQuest().getStage() == 2300
	;GetOwningQuest().SetObjectiveCompleted(2300)
	getowningquest().setstage(2400)
elseif GetOwningQuest().getStage() == 3300
	;GetOwningQuest().SetObjectiveCompleted(3300)
	getowningquest().setstage(3400)
elseif GetOwningQuest().getStage() == 4400
	;GetOwningQuest().SetObjectiveCompleted(4300)
	getowningquest().setstage(4400)
endif

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
