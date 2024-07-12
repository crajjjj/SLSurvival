;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname TIF__050078DB Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
PlayerRef.AddItem(_SLS_Bedroll, 1)
KnockForceGreetAlias.Clear()
KnockForceGreet.Stop()
(Main.KnockHost as Actor).EvaluatePackage()
KnockHostAlias.ForceRefTo(Main.KnockHost)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto
Quest Property KnockForceGreet Auto
ReferenceAlias Property KnockForceGreetAlias Auto
MiscObject Property _SLS_Bedroll  Auto  
SLS_Main Property Main Auto
SLS_Init Property Init Auto

ReferenceAlias Property KnockHostAlias  Auto  
