;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingIvana8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(4500)

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
