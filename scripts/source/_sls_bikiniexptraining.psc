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

; The MCM switched the option on, or an import re-applied it while it was on: the rank follows the
; stored experience at once and silently (the next hourly tick used to announce it as a gain), and
; the hourly loop runs from now, so time spent with the option off is never credited
Function Resume()
	CalcLevel()
	BeginUpdates()
EndFunction

; The MCM switched the option off: a stopped quest still receives the update it registered
Function Suspend()
	UnregisterForUpdateGameTime()
EndFunction

Event OnUpdateGameTime()
	If !IsRunning() ; the option is off; the quest is stopped but its last registered update still arrives
		Return
	EndIf
	DoUpdate()
EndEvent

Function DoUpdate()
	; The hourly tick and the bikini curse's outfit check both land here, at times together. The span
	; is claimed before anything else: nothing between the clock read and the assignment lets a second
	; thread in, so the same hours are never credited twice
	Float Now = Utility.GetCurrentGameTime()
	Float Hours = (Now - LastUpdate) * 24.0
	LastUpdate = Now

	; The outfit is only sampled now, at the end of the span. A jail term jumps the clock by days and
	; hands the gear back, so the whole sentence used to count as worn (or as time in armor): a span
	; with a sentence in it counts for nothing, and no jump counts for more than a day
	Int Jailed = Game.QueryStat("Days Jailed")
	If Jailed != DaysJailed
		If DaysJailed >= 0
			Hours = 0.0
		EndIf
		DaysJailed = Jailed
	EndIf
	If Hours > 24.0
		Hours = 24.0
	ElseIf Hours < 0.0
		Hours = 0.0
	EndIf

	; A bikini piece counts only while nothing else covers it. Under ordinary armor it is armor time
	; like any other: it used to count as neither, so one piece under full plate kept a rank forever
	Float OldExp = BikExp
	Bool WornBikini = PlayerRef.WornHasKeyword(_SLS_BikiniArmor) || Sla.WornHasBikiniKeyword(PlayerRef)
	If WornBikini && _SLS_LicBikiniCurseIsWearingArmor.GetValueInt() == 0
		CalcExpGain(Hours)
	ElseIf WornBikini
		If WearsOrdinaryArmor() ; the piece itself is light armor, so the keyword test below cannot tell
			CalcExpLoss(Hours)
		EndIf
	ElseIf PlayerRef.WornHasKeyword(ArmorLight) || PlayerRef.WornHasKeyword(ArmorHeavy)
		CalcExpLoss(Hours)
	EndIf

	; A rank change is announced only when this update moved the experience the same way: a rank that
	; was merely out of step with the stored experience is put right silently
	Int OldLevel = _SLS_BikiniExpLevel.GetValueInt()
	CalcLevel()
	Int NewLevel = _SLS_BikiniExpLevel.GetValueInt()
	If NewLevel > OldLevel && BikExp > OldExp
		Debug.Messagebox("You've gained more experience wearing bikini armors\nBikini Experience Rank: " + GetBikRankString())
	ElseIf NewLevel < OldLevel && BikExp < OldExp
		Debug.Messagebox("You've lost bikini armor experience\nBikini Experience Rank: " + GetBikRankString())
	EndIf
	RegisterForSingleUpdateGameTime(1.0)
EndFunction

; Light or heavy armor that is not itself a bikini piece, in the slots the bikini curse looks at
; (helmet, gauntlets, boots and shield never count there either)
Bool Function WearsOrdinaryArmor()
	Int Slot = 0x00000004 ; body, then every slot above it
	While Slot <= 0x40000000 && Slot > 0
		If Slot != 0x00000008 && Slot != 0x00000080 && Slot != 0x00000200 ; hands, feet, shield
			Armor Piece = PlayerRef.GetWornForm(Slot) as Armor
			If Piece && Piece.GetWeightClass() < 2 && !IsBikiniPiece(Piece)
				If !Piece.HasKeywordString("ArmorHelmet") && !Piece.HasKeywordString("ArmorGauntlets") && !Piece.HasKeywordString("ArmorBoots") && !Piece.HasKeywordString("ArmorShield")
					Return true
				EndIf
			EndIf
		EndIf
		Slot *= 2
	EndWhile
	Return false
EndFunction

Bool Function IsBikiniPiece(Armor Piece)
	Return Piece.HasKeyword(_SLS_BikiniArmor) || (Sla.SlaVersion >= 29 && Piece.HasKeyword(Sla.SlaBikiniKeyword))
EndFunction

Function CalcExpGain(Float Hours)
	BikExp += Hours * Menu.BikTrainingSpeed
	If BikExp > ExpPerLevel * 7.5 ; Cap experience
		BikExp = ExpPerLevel * 7.5
	EndIf
EndFunction

Function CalcExpLoss(Float Hours)
	BikExp -= Hours * Menu.BikUntrainingSpeed
	If BikExp < 0.0
		BikExp = 0.0
	EndIf
EndFunction

Function CalcLevel() ; sets the rank from the stored experience; DoUpdate does the announcing
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
Int DaysJailed = -1 ; the "Days Jailed" stat at the last update, -1 until the first one reads it

Quest Property MQ101 Auto

GlobalVariable Property _SLS_LicBikiniCurseIsWearingArmor Auto
GlobalVariable Property _SLS_BikiniExpLevel Auto

Keyword Property _SLS_BikiniArmor Auto
Keyword Property ArmorLight Auto
Keyword Property ArmorHeavy Auto

Actor Property PlayerRef Auto

SLS_Mcm Property Menu Auto
_SLS_InterfaceSlax Property Sla Auto
