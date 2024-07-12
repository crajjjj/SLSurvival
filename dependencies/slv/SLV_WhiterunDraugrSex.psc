;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunDraugrSex Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[5]
sexActors[0] = Game.GetPlayer()
sexActors[1] = akSpeaker 
sexActors[2] = draugr2.getActorRef()
sexActors[3] = draugr3.getActorRef()
sexActors[4] = draugr4.getActorRef()

myScripts.SLV_PlaySex(sexActors,"", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto

ReferenceAlias Property Draugr2 Auto 
ReferenceAlias Property Draugr3 Auto 
ReferenceAlias Property Draugr4 Auto 

