;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial5_19c Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7200)
GetOwningQuest().SetStage(7400)

myScripts.SLV_Play3Sex(SLV_SlaveFollower .getActorRef() ,SexTourist3a.getActorRef(), SexTourist3b.getActorRef() ,"Anal", true)
myScripts.SLV_Play3Sex(SexSlave.getActorRef(),SexTourist1a.getActorRef(), Game.GetPlayer() ,"Vaginal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
ReferenceAlias Property SexSlave Auto 
ReferenceAlias Property SLV_SlaveFollower Auto 
ReferenceAlias Property SexTourist1a Auto 
ReferenceAlias Property SexTourist1b Auto 
ReferenceAlias Property SexTourist3a Auto 
ReferenceAlias Property SexTourist3b Auto 
