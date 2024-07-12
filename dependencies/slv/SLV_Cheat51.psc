;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat51 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(9500)

SLV_Marcus.GetActorRef().enable()
SLV_Abigail.GetActorRef().enable()

myScripts.SLV_enslavementNPC(SLV_Abigail.getActorRef())
myScripts.SLV_enslavementChains(SLV_Abigail.getActorRef())

myScripts.SLV_enslavementNPC(SLV_Marcus.getActorRef())
schlongs.SLV_SchlongSize(SLV_Marcus.GetActorRef(),20)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Marcus Auto 
ReferenceAlias Property SLV_Abigail Auto 

SLV_SOSSchlong Property schlongs Auto
