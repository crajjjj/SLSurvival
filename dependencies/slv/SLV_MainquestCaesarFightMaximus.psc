;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestCaesarFightMaximus Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_ArenaFightTask.Reset() 
SLV_ArenaFightTask.Start() 
SLV_ArenaFightTask.SetActive(true) 
SLV_ArenaFightTask.SetStage(0)

SLV_Fighter1.ForceRefTo(SLV_Azog)

SLV_Fighter2.Clear()
SLV_Fighter3.Clear()
SLV_Fighter4.Clear()

;SLV_Fighter2.ForceRefTo(emptyActor)
;SLV_Fighter3.ForceRefTo(emptyActor)
;SLV_Fighter4.ForceRefTo(emptyActor)

SLV_ColosseumGladiator.setValue(501)
SLV_ColosseumGladiatorsNumber.setValue(1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_ColosseumGladiatorsNumber Auto
Quest Property SLV_ArenaFightTask Auto

Actor Property SLV_Azog Auto
Actor Property emptyActor Auto
ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto
Faction Property SLV_ColosseumNPCLost Auto

GlobalVariable Property SLV_ColosseumGladiator Auto
