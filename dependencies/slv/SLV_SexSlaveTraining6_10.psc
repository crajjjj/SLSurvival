;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining6_10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6500)
GetOwningQuest().SetStage(7000)

SendModEvent("dhlp-Suspend")
SLV_EnforcerIgnorePC.setValue(1)

Game.getplayer().addItem(trainingsword)
Game.getplayer().equipItem(trainingsword)

SLV_Gustus.getActorRef().addItem(trainingsword)
SLV_Gustus.getActorRef().equipItem(trainingsword)
SLV_Gustus.getActorRef().drawweapon()
SLV_Gustus.getActorRef().setalert(true)

SLV_Gustus.getActorRef().startcombat(Game.getplayer())
SLV_Gustus.getActorRef().equipItem(trainingsword)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Weapon Property trainingsword auto

ReferenceAlias Property SLV_Gustus Auto
GlobalVariable Property SLV_EnforcerIgnorePC Auto