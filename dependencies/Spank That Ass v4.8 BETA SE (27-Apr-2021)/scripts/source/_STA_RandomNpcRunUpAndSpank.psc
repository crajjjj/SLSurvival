Scriptname _STA_RandomNpcRunUpAndSpank extends ReferenceAlias  

Float Timeout

Actor Property PlayerRef Auto

Topic Property _STA_SpankingMilkAddictTripSpank Auto

_STA_SpankUtil Property SpankUtil Auto
_STA_SexDialogUtil Property DialogUtil Auto
_STA_InterfaceDeviousFollowers Property Dflow Auto

Actor Spanky

Event OnInit()
	Debug.Trace("_STA_: Random start")
	;Debug.Messagebox("Random start")
	Spanky = Self.GetReference() as Actor
	If Spanky
		If Spanky.GetSitState() > 0
			Spanky.MoveTo(Spanky, 0.0, 0.0, Spanky.GetHeight() + 10.0)
		Else
			Spanky.MoveTo(Spanky)
		EndIf
		Spanky.EvaluatePackage()
		Spanky.SetLookAt(PlayerRef)
		Timeout = (SpankUtil.RunUpAndSpankTimeout / 0.1)
		RegisterForSingleUpdate(0.1)
	EndIf
EndEvent

Event OnUpdate()
	If Timeout < 1
		Shutdown(false)
	Else
		If Spanky.GetDistance(PlayerRef) < 101.0
			SpankUtil.DoBumpSpank(Spanky, DoStagger = false)
			DialogUtil.DoNpcDialogOut(_STA_SpankingMilkAddictTripSpank, Spanky)
			Shutdown(true)
		Else
			Timeout -= 1
			RegisterForSingleUpdate(0.1)
		EndIf
	EndIf
EndEvent

Function Shutdown(Bool DidComplete)
	Dflow.ModEventResistLoss = -1.0
	If Spanky
		Spanky.ClearLookAt()
	EndIf
	UnRegisterForUpdate()
	If DidComplete
		SpankUtil.SendRandomRunUpAndSpankCompleteEvent()
	EndIf
	Self.GetOwningQuest().Stop()
EndFunction
