;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveGladiator11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(750)
getowningquest().setstage(1000)

Actor backup = pJarlBackup.GetActorRef()
pJarl.ForceRefTo(backup)
SLV_GladiatorEnemyCount.setValue(1)

arenaDoor.disable()
arenadummyDoor.enable()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property pJarl  Auto  
ReferenceAlias Property pJarlBackup  Auto  
ObjectReference Property arenaDoor  Auto 
ObjectReference Property arenadummyDoor  Auto  
GlobalVariable Property SLV_GladiatorEnemyCount  Auto  

