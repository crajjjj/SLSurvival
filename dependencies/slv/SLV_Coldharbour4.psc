;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Coldharbour4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(2000)

Actor player = Game.GetPlayer()
myScripts.SLV_SexlabStripNPC(player)
myScripts.SLV_StripBothHands(player)
myScripts.SLV_DeviousUnEquipActor(player,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)

myScripts.SLV_SchlongSize(SLV_MolagBal.getActorRef(),20)
myScripts.SLV_SchlongSize(SLV_Sanguine.getActorRef(),20)
myScripts.SLV_SchlongSize(SLV_MehrunesDagon.getActorRef(),20)
myScripts.SLV_SchlongSize(SLV_Malacath.getActorRef(),20)
myScripts.SLV_SchlongSize(Slave1,20)
myScripts.SLV_SchlongSize(Slave2,20)
myScripts.SLV_SchlongSize(Slave3,20)
myScripts.SLV_SchlongSize(Slave4,20)

actor[] sexActors = new actor[2]
sexActors[0] = player
sexActors[1] = akSpeaker

myScripts.SLV_decreaseWeight()
myScripts.SLV_PlaySexAnimationSynchron(sexActors,"FunnyBizness Molag Snuff Vamp","Sex", true)
myScripts.SLV_decreaseWeight()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_MolagBal Auto
ReferenceAlias Property SLV_Sanguine Auto
ReferenceAlias Property SLV_MehrunesDagon Auto
ReferenceAlias Property SLV_Malacath Auto

Actor Property Slave1 Auto
Actor Property Slave2 Auto
Actor Property Slave3 Auto
Actor Property Slave4 Auto
SLV_Utilities Property myScripts auto
