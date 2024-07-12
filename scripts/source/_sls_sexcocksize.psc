Scriptname _SLS_SexCockSize extends Quest  

Function BeginBonusEnjoyment(Actor Creature, Int tid, Int CockCount)
	CurrentTid = tid
	Float CockEnj = Math.Ceiling((Util.GetLoadSize(Creature) as Int)) + 1.0
	BonusEnj = (CockEnj + (0.75 * CockEnj * (CockCount - 1))) as Int
	If Init.DebugMode
		Debug.Notification("Bonus enj: " + BonusEnj)
	EndIf
	RegisterForSingleUpdate(0.01)
EndFunction

Event OnUpdate()
	If PlayerRef.IsInFaction(SexlabAnimatingFaction)
		Slso.ModEnjoyment(CurrentTid, PlayerRef, BonusEnj)
		If Menu.CockSizeBonusEnjFreq > 0.0
			RegisterForSingleUpdate(Menu.CockSizeBonusEnjFreq)
		EndIf
	Else
		Stop()
	EndIf
	;RegisterForSingleUpdate(3.0)
EndEvent

Int BonusEnj
Int CurrentTid

Actor Property PlayerRef Auto

Faction Property SexlabAnimatingFaction Auto

SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto
SLS_Utility Property Util Auto
_SLS_InterfaceSlso Property Slso Auto
