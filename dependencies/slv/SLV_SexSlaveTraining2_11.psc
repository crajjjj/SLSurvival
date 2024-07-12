;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining2_11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5500)
GetOwningQuest().SetStage(6000)

if ThisMenu.SkipScenes
	return
endif

SLV_Animal.ForceRefTo(Animal)
;Debug.notification("New Animal= " + SLV_Animal.getActorRef().getActorBase().getName())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()
Utility.wait(2.0)
SLV_SexIsRunning.setValue(0)

int IsRunning = SLV_SexIsRunning.getValue() as int

while IsRunning == 0
	Utility.wait(2.0)
	IsRunning = SLV_SexIsRunning.getValue() as int
endwhile

myScripts.SLV_Play2Sex(SLV_Ivana.getActorRef(), Animal2, "", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
ReferenceAlias Property SLV_Ivana Auto 
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto

ReferenceAlias Property SLV_Animal Auto  
Actor Property Animal Auto
Actor Property Animal2 Auto
GlobalVariable Property SLV_SexIsRunning Auto 
