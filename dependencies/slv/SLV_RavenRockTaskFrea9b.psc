;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RavenRockTaskFrea9b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)

if MCMMenu.slavefollower
	myScripts.SLV_Play2Sex(MCMMenu.slavefollower,akSpeaker, "Sex", true)
endif

myScripts.SLV_PikeMoodChange(false,1) 
SLV_UseSlaverAsSlave.setValue(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_UseSlaverAsSlave auto
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu auto

