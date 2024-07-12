;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial6_21 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(9000)

myScripts.SLV_IvanaMoodChange(true,1) 
myScripts.SLV_BrutusMoodChange(true,1)

myScripts.SLV_PlaySex2Synchron(Game.GetPlayer(),SLV_DogBellamy.getActorRef(), "", true)
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

myScripts.SLV_Play2Sex(Game.GetPlayer(),SLV_HorseBellamy.getActorRef(), "", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_DogBellamy Auto
ReferenceAlias Property SLV_HorseBellamy Auto
