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
	Float HoursSlept = (Utility.GetCurrentGameTime() - SleepStartTime) * 24.0
	;Debug.Messagebox("OnSleepStop - Sleep Penalty: " + SleepPenalty + ", StartingFatigue: " + StartingFatigue + ", HoursSlept: " + HoursSlept)
	Utility.Wait(5.0)
	;Debug.Messagebox("Wait Over")
	Needs.CorrectFatigue(SleepPenalty, StartingFatigue, HoursSlept)
EndEvent

_SLS_Needs Property Needs Auto
