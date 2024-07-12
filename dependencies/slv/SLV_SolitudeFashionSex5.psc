;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFashionSex5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_UseFollowerSex.getvalue() as int == 1	
	myScripts.SLV_Play2Sex(akSpeaker, MCMMenu.malefollower, "Sex", false)
else
	myScripts.SLV_Play2Sex(akSpeaker, Game.GetPlayer(), "Sex", false)
endif

Utility.wait(3.0)
myScripts.SLV_Play2Sex(Taarie.getActorRef(),Falk.getActorRef(), "Sex", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Taarie Auto 
ReferenceAlias Property Falk Auto 
GlobalVariable Property SLV_UseFollowerSex Auto 
SLV_MCMMenu Property MCMMenu Auto


