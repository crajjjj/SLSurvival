;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeBardsCollegeAct1Sex Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex(Ildi.getActorRef(), akSpeaker, "Anal", true)
Utility.wait(3.0)

myScripts.SLV_Play2Sex(Game.GetPlayer(),Giraurd.getActorRef(), "Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Ildi Auto 
ReferenceAlias Property Giraurd Auto 
