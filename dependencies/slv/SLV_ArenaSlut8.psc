;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaSlut8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_WaitingVisitor2.clear()
Game.getplayer().removeItem(FoodMead ,1)

if GetOwningQuest().ModObjectiveGlobal(1, SLV_ArenaSlutCount, 1000, SLV_MaxTask.getValue() as int)
  	GetOwningQuest().SetObjectiveCompleted(1000)
  	GetOwningQuest().SetStage(9500)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Potion Property FoodMead Auto
GlobalVariable Property SLV_ArenaSlutCount  Auto  
GlobalVariable Property SLV_MaxTask  Auto  
ReferenceAlias Property SLV_WaitingVisitor2 Auto