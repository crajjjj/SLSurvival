;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial4_25 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor jarl =  pJarl.GetRef() as Actor

; swap the aliases
if civilwar.iscompleted()
	Actor backup2 = pJarlWon.GetActorRef()
	pJarl.ForceRefTo(backup2)
else
	Actor backup = pJarlBackup.GetActorRef()
	pJarl.ForceRefTo(backup)
endif

GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property pJarl  Auto  
ReferenceAlias Property pJarlBackup  Auto  

ReferenceAlias Property pJarlWon  Auto  
Quest Property civilwar Auto

