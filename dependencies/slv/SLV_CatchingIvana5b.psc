;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingIvana5b Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3500)

SLV_EnforcerIgnorePC.setvalue(0)

if SLV_WeightMode.getvalue() == 1
	SLV_BabyGotBoobsQuest.Reset() 
	SLV_BabyGotBoobsQuest.Start() 
	SLV_BabyGotBoobsQuest.SetStage(0)
endif

myScripts.SLV_IvanaMoodChange(true,1)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property SLV_BabyGotBoobsQuest Auto
GlobalVariable Property SLV_WeightMode Auto
GlobalVariable Property SLV_EnforcerIgnorePC  Auto
