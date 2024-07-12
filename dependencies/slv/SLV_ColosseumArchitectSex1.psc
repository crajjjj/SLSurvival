;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColosseumArchitectSex1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_Leonardo.getActorRef().additem(SLV_Whip)

myScripts.SLV_enslavementNPC(SLV_Michelangela.getActorRef())
myScripts.SLV_enslavementChains(SLV_Michelangela.getActorRef())

myScripts.SLV_PlaySex2Synchron(SLV_Michelangela.getActorRef(), akSpeaker, "Blowjob, Anal", true)
SLV_SexIsRunning.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_Michelangela Auto 
ReferenceAlias Property SLV_Leonardo Auto 
Weapon Property SLV_Whip Auto


