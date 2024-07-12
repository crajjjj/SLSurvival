;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining2_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_Main.getStage() == 1650
	SLV_Main.SetObjectiveCompleted(1650)
	SLV_Main.SetStage(1700)
endif

ActorUtil.ClearPackageOverride(SLV_Ivana.getactorref())
SLV_Ivana.GetActorRef().evaluatePackage()
Game.getplayer().additem(SLV_SexSlaveVol06.getReference())

myScripts.SLV_IvanaReset()

GetOwningQuest().SetObjectiveCompleted(9500)

if SLV_Main.getStage() < 2250
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
ReferenceAlias Property SLV_SexSlaveVol06 Auto
