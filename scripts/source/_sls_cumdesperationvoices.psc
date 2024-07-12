Scriptname _SLS_CumDesperationVoices extends Quest  

Event OnInit()
	;/
	If Self.IsRunning() && StorageUtil.GetIntValue(Menu, "CumAddictDayDream", Missing = 1) == 1 && VoicesChance > 0.0
		Debug.messagebox("Start")
		TauntCount = 0
		RegisterForSingleUpdate(1.0)
	Else
		Debug.messagebox("Stop")
		Self.Stop()
	EndIf
	/;
	If Self.IsRunning()
		VoicesVolume = 1.0
		VanillaVoiceVolume = 1.0
		VoicesChance = 100.0
	EndIf
EndEvent

Function Begin()
	If VoicesChance > 0.0
		TauntCount = 0
		GoToState("HeadVoices")
		DoUpdateIn(1.0)
	EndIf
EndFunction

Function End()
	GoToState("")
EndFunction

Function LoadGameMaintenance()
	AudioCategoryVOCGeneral.SetVolume(VanillaVoiceVolume)
EndFunction

Function DoVoices(Sound WhatTheVoicesSaid, Float MinWait, Float MaxWait)
	AudioCategoryVOCGeneral.SetVolume(0.15)
	Utility.Wait(0.5)
	Int VoicesInstance = WhatTheVoicesSaid.Play(PlayerRef)
	Sound.SetInstanceVolume(VoicesInstance, VoicesVolume)
	Utility.Wait(Utility.RandomFloat(MinWait, MaxWait)) ; Wait for line to be said with real voices dulled out
	AudioCategoryVOCGeneral.SetVolume(VanillaVoiceVolume) ; Then bring real voices back in
EndFunction

Event OnUpdate()
EndEvent

Function DoUpdateIn(Float Interval)
EndFunction

State HeadVoices
	Function DoUpdateIn(Float Interval)
		If VoicesChance > 0.0
			RegisterForSingleUpdate(Interval)
		EndIf
	EndFunction

	Event OnUpdate()
		If VoicesChance > Utility.RandomFloat(0.0, 100.0)
			If TauntCount <= 0
				DoVoices(_SLS_DaydreamVoicesActionSM, MinWait = 3.0, MaxWait = 4.0)
				TauntCount = Utility.RandomInt(0, 5)
				DoUpdateIn(Utility.RandomFloat(1.0, 2.5))
			Else
				DoVoices(_SLS_DaydreamVoicesTauntSM, MinWait = 0.5, MaxWait = 2.0)
				TauntCount -= 1
				If TauntCount <= 0 ; End of taunt followups. Wait longer
					;Debug.Messagebox("End of taunt session")
					DoUpdateIn(Utility.RandomFloat(6.0, 9.0))
				Else
					DoUpdateIn(Utility.RandomFloat(0.1, 1.0))
				EndIf
			EndIf
			
		Else
			DoUpdateIn(Utility.RandomFloat(6.0, 9.0))
		EndIf
	EndEvent
EndState

Int TauntCount

Float Property VoicesVolume = 1.0 Auto
Float Property VanillaVoiceVolume = 1.0 Auto
Float Property VoicesChance = 100.0 Auto

SoundCategory Property AudioCategoryVOCGeneral Auto

Sound Property _SLS_DaydreamVoicesActionSM Auto
Sound Property _SLS_DaydreamVoicesTauntSM Auto

Actor Property PlayerRef Auto

SLS_Mcm Property Menu Auto
