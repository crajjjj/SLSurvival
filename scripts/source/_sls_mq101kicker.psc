Scriptname _SLS_MQ101Kicker extends Quest  

Event OnInit()
	While (MQ101.GetCurrentStageID() < 240)
		Utility.Wait(30.0)
	EndWhile
	If _SLS_BikiniExpTrainingQuest.IsRunning()
		BikExp.BeginUpdates()
	EndIf
	Eviction.StartUp()
	_SLS_LicenceBuyBlockerQuest.Start()
	If Menu.BellyScaleEnable
		_SLS_BellyInflationQuest.Start()
	EndIf

	_SLS_BodyInflationTrackingQuest.Start()

	If StorageUtil.GetFloatValue(Menu, "WeightGainPerDay", Missing = 0.0) > 0.0
		_SLS_GrowthQuest.Start()
	EndIf
	
	_SLS_CurfewQuest.Start()
	
	(Game.GetFormFromFile(0x0DFE17, "SL Survival.esp") as _SLS_PlayerDirt).BeginUpdates() ; _SLS_PlayerDirtQuest
	(Game.GetFormFromFile(0x0F37A1, "SL Survival.esp") as _SLS_Trauma).BeginUpdates()
EndEvent

Quest Property MQ101 Auto
Quest Property _SLS_BikiniExpTrainingQuest Auto
Quest Property _SLS_LicenceBuyBlockerQuest Auto
Quest Property _SLS_BellyInflationQuest Auto
Quest Property _SLS_BodyInflationTrackingQuest Auto
Quest Property _SLS_GrowthQuest Auto
Quest Property _SLS_CurfewQuest Auto

SLS_Mcm Property Menu Auto
_SLS_BikiniExpTraining Property BikExp Auto
SLS_EvictionTrack Property Eviction Auto
;_SLS_Growth Property Growth Auto
