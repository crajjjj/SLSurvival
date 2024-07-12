;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0408CCF3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Self.GetOwningQuest().Stop()
Util.StopAllGuardWarnApproachQuests(akSpeaker, DoCooldown = true)
Utility.WaitMenuMode(2.5)
Util.IncreaseBounty(akSpeaker, Bounty = 200, Verbose = true)
Utility.WaitMenuMode(1.0)
Util.DoGuardWarningOutcome(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Utility Property Util Auto
