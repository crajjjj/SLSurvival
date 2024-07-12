;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveGuards_Slave_1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_EnforcerSexQuest.Reset()
SLV_EnforcerSexQuest.Start()
SLV_EnforcerSexQuest.Setstage(0)

enforcerSex.SLV_EnforcerDemonstration(akspeaker)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_EnforcerSexQuest Auto
SLV_EnforcerSexStart Property enforcerSex auto 