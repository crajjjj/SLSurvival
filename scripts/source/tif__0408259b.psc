;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0408259B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Util.IncreaseFame("Slut", 5)
Dflow.DecResistWithSeverity(Amount = 3.0, DoNotify = true, Severity = "1")
akSpeaker.RemoveFromFaction(_SLS_LicBlockNaked)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property _SLS_LicBlockNaked Auto

_SLS_InterfaceDeviousFollowers Property Dflow Auto
SLS_Utility Property Util Auto
