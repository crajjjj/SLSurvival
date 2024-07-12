;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodAlvor5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)

ActorUtil.AddPackageOverride( SLV_Sigrid.getActorRef(), SLV_Followplayer ,100)
SLV_Sigrid.getActorRef().evaluatePackage()

SLV_Sigrid.getActorRef().additem(Whip)

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto
Package Property SLV_Followplayer Auto
ReferenceAlias Property SLV_Sigrid Auto
Weapon Property Whip Auto
