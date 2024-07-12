Scriptname _STA_SpecificNpcRunUpAndSpank extends ReferenceAlias  

Float Timeout

Actor Property PlayerRef Auto

;Topic Property _STA_SpankingMilkAddictTripSpank Auto

_STA_SpankUtil Property SpankUtil Auto
_STA_SexDialogUtil Property DialogUtil Auto
_STA_InterfaceDeviousFollowers Property Dflow Auto

Actor Spanky

ReferenceAlias Property ThatGuy Auto

Event OnInit()	
	Spanky = Self.GetReference() as Actor
	If Spanky
		Spanky.EvaluatePackage()
		Spanky.SetLookAt(PlayerRef)
		Timeout = (SpankUtil.RunUpAndSpankTimeout / 0.1)
		RegisterForSingleUpdate(0.1)
	EndIf
EndEvent

Event OnUpdate()
	If Timeout < 1
		Shutdown()
	Else
		If Spanky.GetDistance(PlayerRef) < 101.0
			SpankUtil.DoBumpSpank(Spanky, DoStagger = false)
			;Debug.Trace("_STA_: _STA_SpecificNpcRunUpAndSpank. TalkingActor: " + Spanky + ". Speaking: " + SpankUtil.EventSpecificSpankEndTopic + ". IsInFaction: " + Spanky.IsInFaction(Game.GetFormFromFile(0x09B04B, "SL Survival.esp") as Faction))
			;Debug.Messagebox("_STA_: _STA_SpecificNpcRunUpAndSpank. TalkingActor: " + Spanky + ". Speaking: " + SpankUtil.EventSpecificSpankEndTopic + ". IsInFaction: " + Spanky.IsInFaction(Game.GetFormFromFile(0x09B04B, "SL Survival.esp") as Faction))
			DialogUtil.DoNpcDialogOut(DialogUtil.DummyNpcWhatToSay, Spanky)
			Shutdown()
		Else
			Timeout -= 1
			RegisterForSingleUpdate(0.1)
		EndIf
	EndIf
EndEvent

Function Shutdown()
	ThatGuy.Clear()
	Dflow.ModEventResistLoss = -1.0
	If Spanky
		Spanky.ClearLookAt()
	EndIf
	UnRegisterForUpdate()
	Self.GetOwningQuest().Stop()
EndFunction
