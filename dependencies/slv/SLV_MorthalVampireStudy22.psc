;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MorthalVampireStudy22 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(1000)

myScripts.SLV_Play2Sex(Game.getPlayer(),Undead , "", true)
Undead1.enable()

myScripts.SLV_PikeMoodChange(true,1) 
SLV_UseSlaverAsSlave.setValue(1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_UseSlaverAsSlave auto
SLV_Utilities Property myScripts auto
Actor Property Undead Auto
Actor Property Undead1 Auto
SLV_MCMMenu Property MCMMenu auto