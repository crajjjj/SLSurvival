;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Coldharbour3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(100)
GetOwningQuest().SetStage(1500)

Game.getplayer().moveto(templeref)
Utility.wait(2)

myScripts.SLV_SchlongSize(SLV_MolagBal.getActorRef(),20)
myScripts.SLV_SchlongSize(SLV_Sanguine.getActorRef(),20)
myScripts.SLV_SchlongSize(SLV_MehrunesDagon.getActorRef(),20)
myScripts.SLV_SchlongSize(SLV_Malacath.getActorRef(),20)
myScripts.SLV_SchlongSize(Slave1,20)
myScripts.SLV_SchlongSize(Slave2,20)
myScripts.SLV_SchlongSize(Slave3,20)
myScripts.SLV_SchlongSize(Slave4,20)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property templeref auto
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_MolagBal Auto
ReferenceAlias Property SLV_Sanguine Auto
ReferenceAlias Property SLV_MehrunesDagon Auto
ReferenceAlias Property SLV_Malacath Auto

Actor Property Slave1 Auto
Actor Property Slave2 Auto
Actor Property Slave3 Auto
Actor Property Slave4 Auto
