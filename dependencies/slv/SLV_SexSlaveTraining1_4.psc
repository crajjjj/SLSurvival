;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining1_4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(2000)

myScripts.SLV_Play2Sex(SLV_Ivana.getActorRef(), SLV_Sven.getActorRef(), "Boobjob", true)
Utility.wait(2.0)

myScripts.SLV_Play2SexAnimation(Game.getPlayer(), akSpeaker, "Boobjob", "Boobjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
ReferenceAlias Property SLV_Ivana Auto 
ReferenceAlias Property SLV_Sven Auto 

