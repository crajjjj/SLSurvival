;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_BrutusBeatingSex Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex(SLV_Valentina.getActorRef(), SLV_Sven.getActorRef(), "Sex", true)
Utility.wait(3.0)

myScripts.SLV_Play2Sex(Game.getplayer(),SLV_Brutus.getActorRef(), "Sex", true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Sven Auto 
ReferenceAlias Property SLV_Brutus Auto 
ReferenceAlias Property SLV_Valentina Auto 
