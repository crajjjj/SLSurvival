;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial5_20b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(7400)
GetOwningQuest().SetStage(7500)

myScripts.SLV_Play3Sex( Game.GetPlayer(),SexTourist3a.getActorRef(), SexTourist3b.getActorRef() ,"Blowjob", false)
myScripts.SLV_Play3Sex(SexSlave.getActorRef(),SexTourist1a.getActorRef(), SexTourist1b.getActorRef() ,"Vaginal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts Auto 
ReferenceAlias Property SexSlave Auto 
ReferenceAlias Property SexTourist1a Auto 
ReferenceAlias Property SexTourist1b Auto
ReferenceAlias Property SexTourist3a Auto 
ReferenceAlias Property SexTourist3b Auto 
