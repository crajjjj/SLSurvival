;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial4_7b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
GetOwningQuest().SetStage(2000)

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "Sex", true)
myScripts.SLV_PikeMoodChange(true,1) 
SLV_UseSlaverAsSlave.setValue(1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_UseSlaverAsSlave auto
SLV_Utilities Property myScripts auto

