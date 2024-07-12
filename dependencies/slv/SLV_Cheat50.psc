;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat50 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_ArenaFightsWon.setValue(SLV_ArenaFightsWon.getValue() + 1)

if deadslavewalking.getstage() == 3000
	deadslavewalking.SetObjectiveCompleted(3000)
	deadslavewalking.SetStage(3500)
endif

if myScripts.SLV_IsArenaMaxLevelReached()
	if deadslavewalking.getstage() == 4500
		deadslavewalking.SetObjectiveCompleted(4500)

		if myScripts.SLV_IsSlaveMaxLevelReached()
			deadslavewalking.SetStage(6000)
		else
			deadslavewalking.SetStage(5000)
		endif
	endif
	if deadslavewalking.getstage() == 5500
		deadslavewalking.SetObjectiveCompleted(5500)
		deadslavewalking.SetStage(6000)
	endif
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Quest Property deadslavewalking Auto
GlobalVariable Property SLV_ArenaFightsWon Auto
