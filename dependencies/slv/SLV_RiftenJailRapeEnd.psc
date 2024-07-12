;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiftenJailRapeEnd Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
riftenmain.SetObjectiveCompleted(2500)
riftenmain.setStage(3000)

ActorUtil.ClearPackageOverride(akSpeaker)

Debug.MessageBox("Vaul knocks you down with one hit, and you loose consciousness.")

akSpeaker.moveto(newMarker)
Game.GetPlayer().moveto(newMarker)

GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(6000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property newMarker Auto
Quest Property riftenmain Auto
