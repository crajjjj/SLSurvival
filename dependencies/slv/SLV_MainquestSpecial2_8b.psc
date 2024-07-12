;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial2_8b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)
Camilla.moveto(Game.GetPlayer())

myScripts.SLV_BrutusMoodChange(true,1)
myScripts.SLV_IvanaMoodChange(true,1)

myScripts.SLV_Play3Sex(Game.GetPlayer(),akSpeaker, Camilla,"", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Actor Property Camilla  Auto  

