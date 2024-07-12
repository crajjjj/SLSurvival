;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__08026E0A Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Init.EvictionForceGreetDone = true
ObjectReference Chest = EvictionChest.GetReference()
If Chest  != None ; Shouldn't happen, but I don't want to be responsible for sending player items to oblivion
	PlayerRef.RemoveAllItems(Chest, abKeepOwnership = true, abRemoveQuestItems = false)
	Chest.SetLockLevel(255)
	Chest.Lock(true)
EndIf
Int i = 0
While i < 3
((Self.GetOwningQuest().GetNthAlias(i) as ReferenceAlias).GetReference() as Actor).EvaluatePackage()
i += 1
EndWhile
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto
ReferenceAlias Property EvictionChest Auto
SLS_Init Property Init Auto
