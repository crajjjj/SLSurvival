;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial10Sex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[5]
sexActors[0] = Game.GetPlayer()
sexActors[1] = SLV_Hemming.getActorRef()
sexActors[2] = SLV_Brynjolf.getActorRef()
sexActors[3] = SLV_Saul.getActorRef()
sexActors[4] = SLV_Maul.getActorRef()

myScripts.SLV_Gangbang(sexActors)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Maul Auto 
ReferenceAlias Property SLV_Saul Auto 
ReferenceAlias Property SLV_Brynjolf Auto 
ReferenceAlias Property SLV_Hemming Auto 


