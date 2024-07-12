;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFashionSex8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex(akSpeaker, Falk.getActorRef(), "Sex", false)

Utility.wait(3.0)
if SLV_UseFollowerSex.getvalue() as int == 1	
	myScripts.SLV_Play2Sex(Taarie.getActorRef(), MCMMenu.malefollower,"Sex", true)
else
	myScripts.SLV_Play2Sex(Taarie.getActorRef(), Game.GetPlayer(),"Sex", true)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
ReferenceAlias Property Taarie Auto 
ReferenceAlias Property Falk Auto 
GlobalVariable Property SLV_UseFollowerSex Auto 
SLV_MCMMenu Property MCMMenu Auto

