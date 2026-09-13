Scriptname _SLS_SleepDeprivation extends ReferenceAlias  

Float SleepPenalty
Float StartingFatigue
Float SleepStartTime

Event OnInit()
	If Game.GetModByName("iNeed.esp") == 255 && Game.GetModByName("RealisticNeedsandDiseases.esp") == 255 && Game.GetModByName("EatingSleepingDrinking.esp") == 255 ; Don't bother starting if there's no needs mod installed
		Self.GetOwningQuest().Stop()
	EndIf
	RegisterForSleep()
EndEvent

Event OnPlayerLoadGame()
	RegisterForSleep() ; Sleep registration can be lost in older saves (the quest OnInit-stopped itself pre-0.714 with no needs mod) - re-arm every load
EndEvent

;/
Event OnKeyDown(Int KeyCode)
	Debug.Messagebox("Fatigue: " + (Game.GetFormFromFile(0x000D62, "iNeed.esp") as _SNQuestScript).TempFatigueState + ". TimePassed: " + (Game.GetFormFromFile(0x000D62, "iNeed.esp") as _SNQuestScript).TimePassed)
EndEvent
/;

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	SleepStartTime = Utility.GetCurrentGameTime()
	StartingFatigue = Needs.GetFatigue()
	SleepPenalty = Needs.GetSleepPenalty(ShowConditions = false, IsSleeping = true)
EndEvent

Event OnSleepStop(bool abInterrupted)
	If !Self.GetOwningQuest().IsRunning() ; Sleep deprivation toggled off - RegisterForSleep survives the Stop()
		Return
	EndIf
	Float HoursSlept = (Utility.GetCurrentGameTime() - SleepStartTime) * 24.0
	;Debug.Messagebox("OnSleepStop - Sleep Penalty: " + SleepPenalty + ", StartingFatigue: " + StartingFatigue + ", HoursSlept: " + HoursSlept)
	Utility.Wait(5.0)
	;Debug.Messagebox("Wait Over")
	Needs.CorrectFatigue(SleepPenalty, StartingFatigue, HoursSlept)
	; Go To Bed DOES open the Sleep/Wait menu, so the hook fires and stamps the gate - but its box
	; is eaten while the player is bedded. Being in furniture at sleep start is the reliable tell.
	If Needs.GetSleptInFurniture() || !Needs.GetConditionsShownRecently()
		Needs.ShowLastConditions(SleepPenalty)
	EndIf
EndEvent

_SLS_Needs Property Needs Auto
