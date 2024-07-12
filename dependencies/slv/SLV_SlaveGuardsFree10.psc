;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveGuardsFree10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_GetMoreSubmissive(true,1)
Game.GetPlayer().AddItem(Gold001, 1000)

SLV_EnforcerSexQuest.Reset()
SLV_EnforcerSexQuest.Start()
SLV_EnforcerSexQuest.Setstage(0)

enforcerSex.SLV_EnforcerDemonstration4(akspeaker)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_EnforcerSexQuest Auto
SLV_EnforcerSexStart Property enforcerSex auto 
MiscObject Property Gold001  Auto 
