;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SLV_Slavetraining7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(600)
GetOwningQuest().SetStage(700)

myScripts.SLV_IvanaMoodChange(false)
myScripts.SLV_Play2Sex(slv_Valentina.getactorref(), akSpeaker , "Vaginal", true)
myScripts.SLV_Play2Sex(Game.GetPlayer(), slv_Eric.getactorref(), "Vaginal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
ReferenceAlias Property SLV_Eric Auto
ReferenceAlias Property SLV_Valentina Auto
