;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_PreQuest1_End Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

carriage.disable()
banditcamp.disable()
bandithideout.disable()

Game.getplayer().additem(SLV_BookPrequest.getReference())

if !(SLV_Main.IsRunning() || SLV_Main.IsCompleted())
	SLV_Main.Reset() 
	SLV_Main.Start() 
	SLV_Main.SetStage(0)
	SLV_Main.SetActive(true)

	enslavetimer.StartProgressForFreeWoman()
endif

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SLV_Main Auto
SLV_EnslavingProgress Property enslavetimer auto

ObjectReference Property carriage Auto
ObjectReference Property banditcamp Auto
ObjectReference Property bandithideout Auto

ReferenceAlias Property SLV_BookPrequest Auto


