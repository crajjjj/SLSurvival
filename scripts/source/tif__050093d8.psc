;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__050093D8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If PlayerRef.GetItemCount(_SLS_Bedroll) > 0
PlayerRef.RemoveItem(_SLS_Bedroll, 1)
EndIf
Debug.Notification(akSpeaker.GetBaseObject().GetName() + " hands you your things and quickly shoves you out the door")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor Host = KnockHost.GetReference() as Actor
SLS_KnockLockDoor LockInScript = Main.LockTheDoor as SLS_KnockLockDoor
LockInScript.RemoveLockdown()
KnockHost.Clear()
Host.EvaluatePackage()
Main.KnockResetSk()
Main.GoToState("")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto
SLS_Main Property Main Auto
ReferenceAlias Property KnockHost  Auto  
MiscObject Property _SLS_Bedroll  Auto  
