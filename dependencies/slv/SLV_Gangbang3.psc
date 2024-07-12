;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SLV_Gangbang3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[3]
sexActors[0] =Actor1.GetActorReference()
sexActors[1] =Actor2.GetActorReference()
sexActors[2] =Actor3.GetActorReference()

myScripts.SLV_PlaySex(sexActors,"FMM", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Actor1 Auto 
ReferenceAlias Property Actor2 Auto 
ReferenceAlias Property Actor3 Auto 



