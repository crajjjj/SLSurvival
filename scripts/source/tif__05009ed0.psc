;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__05009ED0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
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

SLS_Main Property Main Auto
Quest Property KnockForceGreet Auto
ReferenceAlias Property KnockForceGreetAlias Auto
ReferenceAlias Property KnockHostAlias Auto
Actor Property PlayerRef Auto
MiscObject Property _SLS_Bedroll Auto
