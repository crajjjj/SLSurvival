;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Dawnstar12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
getowningquest().setstage(3000)

myScripts.SLV_IvanaMoodChange(false,1) 
myScripts.SLV_BrutusMoodChange(false,1)

SLV_Slaver.ForceRefTo(akSpeaker)
;Debug.notification("New Slaver= " + SLV_Slaver.getActorRef().getActorBase().getName())

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
ReferenceAlias Property SLV_Slaver Auto
SLV_Utilities Property myScripts auto
