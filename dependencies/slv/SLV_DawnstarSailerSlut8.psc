;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_DawnstarSailerSlut8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if GetOwningQuest().ModObjectiveGlobal(1, SLV_DawnstarSeagullCount, 1000, SLV_MaxTask.getValue() as int)
  	GetOwningQuest().SetObjectiveCompleted(1000)
  	GetOwningQuest().SetStage(1500)
endif

if ThisMenu.SkipScenes
	return
endif
akSpeaker.addItem(Whip)
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
SlV_MCMMenu Property ThisMenu auto
ReferenceAlias Property pPisser  Auto  
Scene Property PunishScene  Auto  
GlobalVariable Property SLV_DawnstarSeagullCount  Auto  
Weapon Property Whip Auto
GlobalVariable Property SLV_MaxTask  Auto  

