Scriptname _SLS_BikiniExpTraining extends Quest  

Event OnInit()
	BeginUpdates()
EndEvent

Function BeginUpdates()
	If (MQ101.GetCurrentStageID() >= 240)
		LastUpdate = Utility.GetCurrentGameTime()
		RegisterForSingleUpdateGameTime(1.0)
	EndIf
EndFunction

Event OnUpdateGameTime()
	DoUpdate()
EndEvent

Function DoUpdate()
	If PlayerRef.WornHasKeyword(_SLS_BikiniArmor) || Sla.WornHasBikiniKeyword(PlayerRef)
		If _SLS_LicBikiniCurseIsWearingArmor.GetValueInt() == 0
			CalcExpGain()
		EndIf
	
	ElseIf PlayerRef.WornHasKeyword(ArmorLight) || PlayerRef.WornHasKeyword(ArmorHeavy)
		CalcExpLoss()
		
	;Else
	;	Debug.Messagebox("No Change")
	EndIf
	CalcLevel()
	LastUpdate = Utility.GetCurrentGameTime()
	RegisterForSingleUpdateGameTime(1.0)
EndFunction

Function CalcExpGain()
	;Float OldExp = BikExp
	;Float ExpGain = ((Utility.GetCurrentGameTime() - LastUpdate) * 24.0) * Menu.BikTrainingSpeed
	BikExp += ((Utility.GetCurrentGameTime() - LastUpdate) * 24.0) * Menu.BikTrainingSpeed
	If BikExp > ExpPerLevel * 7.5 ; Cap experience
		BikExp = ExpPerLevel * 7.5
	EndIf
	;Debug.Messagebox("OldExp: " + OldExp + "\nExpGain: " + ExpGain + "\nNewExp: " + BikExp)
EndFunction

Function CalcExpLoss()
	BikExp -= ((Utility.GetCurrentGameTime() - LastUpdate) * 24.0) * Menu.BikUntrainingSpeed
	If BikExp < 0.0
		BikExp = 0.0
	EndIf
	;Debug.Messagebox("ExpLoss")
EndFunction

Function CalcLevel()
	Int OldLevel = _SLS_BikiniExpLevel.GetValueInt()
	If BikExp > ExpPerLevel * 5.5
		_SLS_BikiniExpLevel.SetValueInt(4)
	ElseIf BikExp > ExpPerLevel * 3.5
		_SLS_BikiniExpLevel.SetValueInt(3)
	ElseIf BikExp > ExpPerLevel * 2.0
		_SLS_BikiniExpLevel.SetValueInt(2)
	ElseIf BikExp > ExpPerLevel
		_SLS_BikiniExpLevel.SetValueInt(1)
	Else
		_SLS_BikiniExpLevel.SetValueInt(0)
	EndIf
	
	Int NewLevel = _SLS_BikiniExpLevel.GetValueInt()
	If NewLevel > OldLevel
		Debug.Messagebox("You've gained more experience wearing bikini armors\nBikini Experience Rank: " + GetBikRankString())
		
	ElseIf NewLevel < OldLevel
		Debug.Messagebox("You've lost bikini armor experience\nBikini Experience Rank: " + GetBikRankString())
	EndIf
EndFunction

String Function GetBikRankString()
	Int i = _SLS_BikiniExpLevel.GetValueInt()
	If i == 0
		Return "Untrained "
	ElseIf i == 1
		Return "Apprentice "
	ElseIf i == 2
		Return "Adept "
	ElseIf i == 3
		Return "Expert "
	ElseIf i == 4
		Return "Master "
	EndIf	
EndFunction

Float Property BikExp = 0.0 Auto Hidden
Float Property ExpPerLevel = 100.0 Auto Hidden
Float LastUpdate = 0.0

Quest Property MQ101 Auto

GlobalVariable Property _SLS_LicBikiniCurseIsWearingArmor Auto
GlobalVariable Property _SLS_BikiniExpLevel Auto

Keyword Property _SLS_BikiniArmor Auto
Keyword Property ArmorLight Auto
Keyword Property ArmorHeavy Auto

Actor Property PlayerRef Auto

SLS_Mcm Property Menu Auto
_SLS_InterfaceSlax Property Sla Auto
