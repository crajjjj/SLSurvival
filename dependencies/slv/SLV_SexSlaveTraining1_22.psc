;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining1_22 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_Main.GetStage() == 1450
	SLV_Main.SetObjectiveCompleted(1450)
	SLV_Main.SetStage(1500)
endif

ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()

myScripts.SLV_IvanaReset()
Game.getplayer().additem(SLV_SexSlaveVol04.getReference())

GetOwningQuest().SetObjectiveCompleted(9500)

if SLV_Main.GetStage() == 1500
	getowningquest().setstage(10000)
else
	getowningquest().setstage(9800)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_Main Auto
ReferenceAlias Property SLV_Ivana Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_SexSlaveVol04 Auto


