;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveGladiator16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

Fighter.GetActorRef().resurrect()
Fighter.GetActorRef().disable()
Fighter.Clear()
if SLV_GladiatorEnemyCount.getvalue() > 1
	Fighter2.GetActorRef().resurrect()
	Fighter2.GetActorRef().disable()
	Fighter2.Clear()
endif
if SLV_GladiatorEnemyCount.getvalue() > 2
	Fighter3.GetActorRef().resurrect()
	Fighter3.GetActorRef().disable()
	Fighter3.Clear()
endif

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_DeviousEquip(true,true,false,false,false,true,true,true,false,false,true,true,true,true,true)

Utility.wait(5.0)
myScripts.SLV_PlayerMoveTo(cageMarker)

GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(5000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ObjectReference Property cageMarker Auto
ReferenceAlias Property Fighter Auto 
ReferenceAlias Property Fighter2 Auto 
ReferenceAlias Property Fighter3 Auto 

GlobalVariable Property SLV_GladiatorEnemyCount  Auto 


