;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Mainquest7SpecialCamillaSex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if SLV_UseFollowerSex.getvalue() as int == 1	
	myScripts.SLV_Play3Sex(Camilla.getActorRef(), MCMMenu.malefollower,Rissad.getActorRef(), "Anal", true)
else
	myScripts.SLV_Play3Sex(Camilla.getActorRef(), Game.GetPlayer(),Rissad.getActorRef(), "Anal", true)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Camilla Auto 
ReferenceAlias Property Rissad Auto 
GlobalVariable Property SLV_UseFollowerSex Auto 
SLV_MCMMenu Property MCMMenu Auto

