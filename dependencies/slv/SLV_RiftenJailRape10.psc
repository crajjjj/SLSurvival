;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_RiftenJailRape10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().getStage() == 1400
	;GetOwningQuest().SetObjectiveCompleted(1400)
	getowningquest().setstage(1500)
	RiftenJailTimer.StartProgressRiftenSlave()
elseif GetOwningQuest().getStage() == 2400
	;GetOwningQuest().SetObjectiveCompleted(2400)
	getowningquest().setstage(2500)
elseif GetOwningQuest().getStage() == 3400
	;GetOwningQuest().SetObjectiveCompleted(3400)
	getowningquest().setstage(3500)
elseif GetOwningQuest().getStage() == 4400
	;GetOwningQuest().SetObjectiveCompleted(4400)
	getowningquest().setstage(4500)
endif

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Blowjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
SLV_RiftenJailTimer Property RiftenJailTimer Auto
