;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunPissPot1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().ModObjectiveGlobal(1,SLV_WhiterunPissPotCounter, 0, SLV_MaxTask.getValue() as int)
  	GetOwningQuest().SetObjectiveCompleted(0)
  	GetOwningQuest().SetStage(500)
endif

if ThisMenu.SkipScenes
	return
endif

SendModEvent("dhlp-Suspend")
pPisser.ForceRefTo(akSpeaker)
;Debug.notification("New pPisser= " + (pPisser.GetRef() as Actor).getActorBase().getName())

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
GlobalVariable Property SLV_WhiterunPissPotCounter Auto 
ReferenceAlias Property pPisser Auto  
Scene Property PunishScene Auto  
GlobalVariable Property SLV_MaxTask  Auto  
