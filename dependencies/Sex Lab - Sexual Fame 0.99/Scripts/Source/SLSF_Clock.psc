Scriptname SLSF_Clock extends Quest  

SLSF_Configuration Property Config Auto
SLSF_Utility Property SLSFUtility Auto
SLSF_Monitor Property SLSFMonitor Auto
SLSF_FameMaintenance Property FameMain Auto

Spell Property NpcInitialization Auto
Actor Property PlayerRef Auto

Int Counter

Event OnInit()
	RegisterForSingleUpdate(10.0)
EndEvent

Function CallTheClock(Float Time)
	RegisterForSingleUpdate(Time)
EndFunction

Event OnUpdate()
	If PlayerRef.GetCombatState() != 0 || PlayerRef.IsChild() || Config.SystemInPause
		RegisterForSingleUpdate(6.0)
	Else
		Float CProb = Config.AllowCommentProbability
		If Config.SceneInUse.GetValue() == 1.0
			CProb = 0.0
		EndIf
		
		If CProb == 0.0
			Config.AllowComment.SetValue(0.0)
		Else
			If CProb == 1.0
				Config.AllowComment.SetValue(1.0)
			Else
				Float Rnd = Utility.RandomFloat()
				If Rnd < CProb
					Config.AllowComment.SetValue(1.0)
				Else
					Config.AllowComment.SetValue(0.0)
				EndIf
			EndIf
		EndIf

		If Counter == 0 || Counter == 5 || Counter == 10 || Counter == 15
			SLSFUtility.CallTheCaster(NpcInitialization, PlayerRef)
		EndIf
		
		Counter += 1
		
		If Counter == 1 || Counter == 8
			FameMain.FamePeriodicIncrease()
			SLSFMonitor.Surface1_2And3()
			FameMain.DecayOfTemporaryLocation()
		EndIf
		
		If Counter == 5 || Counter == 10 || Counter == 15
			FameMain.FameDecadencePcAndVariationNpc()
		EndIf
		
		If Counter >= 15
			FameMain.ContageFamePCSelect()
			Counter = 0
		EndIf
		
		RegisterForSingleUpdate(Config.BaseUpdateInterval)
	EndIf
EndEvent
