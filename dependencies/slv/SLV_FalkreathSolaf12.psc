;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathSolaf12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
akSpeaker.addItem(Whip)
SLV_Bolund.getActorRef().addItem(Whip)

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto
Weapon Property Whip Auto
ReferenceAlias Property SLV_Bolund Auto
