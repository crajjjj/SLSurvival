;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveGuardsFree11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_Dog.getActorRef().enable()
SLV_Dog.getActorRef().moveto(game.getPlayer())

myScripts.SLV_GetMoreSubmissive(true,1)
Game.GetPlayer().AddItem(Gold001, 1000)

myScripts.SLV_PlaySex2Synchron(Game.GetPlayer(),SLV_Dog.getActorRef(), "Doggystyle", true)

SLV_Dog.getActorRef().disable()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
MiscObject Property Gold001  Auto 
ReferenceAlias Property SLV_Dog Auto

