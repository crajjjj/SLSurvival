Scriptname _MDDeal extends Quest  Conditional

_LDC property LDC auto
QF__DflowDealController_0A01C86D Property DC Auto
_DFlowModDealController Property DMC auto
_DFtools Property Tool Auto

GlobalVariable Property GameDaysPassed Auto
GlobalVariable Property _DflowDealBaseDays Auto
Actor Property PlayerRef  Auto  

MiscObject Property Gold001 Auto

; Unique properties of the deal
Float Property Delay Auto Conditional
Int Property Stat Auto Conditional
Int Property Enabled Auto Conditional
Int Property Rule1Code auto
Int Property Rule2Code auto
Int Property Rule3Code auto 
Bool Property Triggered = False Auto
Int Property ExpensiveCount Auto
; globals that are unique per deal:
GlobalVariable Property DealPriceTimer Auto
GlobalVariable Property DealPrice Auto
; Used to save days remaining when mod is paused, not normally valid during normal operation.
Float Property PausedDaysRemaining Auto

Float Property TimerCache Auto Hidden

Function HumNoti()
	If Triggered
		Debug.Notification(DMC.DealNoti[Rule3Code])
	endif
EndFunction

; _DFUberDealController will force set Rule1Code, Rule2Code or Rule3Code then advance the stage
; The deal stage code will set the quest's DealPriceTimer value, then call Stage1, Stage2 or Stage3.
; This last step will do nothing because the Code will already be set.

Function Stage0()
    Debug.TraceConditional("DF - _MDDeal:Stage0", True)
    DC.PickRandomDeal()
EndFunction

Function Stage1()

	Float temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
	DealPriceTimer.SetValue(temp)

    ; RuleCode can be set before we set the quest stage if forcing a deal.
    If 0 == Rule1Code
        ;Rule1Code = DMC.setT1or2rule()
        Triggered = False
        If 17 == Rule1Code
            ExpensiveCount += 1
        EndIf
    EndIf
EndFunction

Function Stage2()

	Float temp = 0.0
	If DealPriceTimer.getValue() <= GameDaysPassed.GetValue()
		temp = GameDaysPassed.GetValue() +  _DflowDealBaseDays.GetValue()
	Else
		temp = DealPriceTimer.GetValue() +  _DflowDealBaseDays.GetValue()
	EndIf
	DealPriceTimer.SetValue(temp)

    ; RuleCode can be set before we set the quest stage if forcing a deal.
    If 0 == Rule2Code
        ;Rule2Code = DMC.setT1or2rule()
        If 17 == Rule2Code
            ExpensiveCount += 2
        EndIf
    EndIf
EndFunction

Function Stage3()

	float temp = 0.0
	If DealPriceTimer.getValue() <= GameDaysPassed.GetValue()
		temp = GameDaysPassed.GetValue() +  _DflowDealBaseDays.GetValue()
	Else
		temp = DealPriceTimer.GetValue() +  _DflowDealBaseDays.GetValue()
	EndIf
	DealPriceTimer.SetValue(temp)

    ; RuleCode can be set before we set the quest stage if forcing a deal.
    If 0 == Rule3Code
        ;Rule3Code = DMC.setT3rule()
        If 17 == Rule3Code
            ExpensiveCount += 4
        EndIf
        ; There was some code to set crawl Triggered, but it was wrong, because it didn't check if you were actually
        ; crawling in town, which is the whole point of it.
        ; Humiliation system not used or working anyway.
    EndIf
EndFunction


Function BuyOut(GlobalVariable price)

    Debug.TraceConditional("DF - _MDDeal - Buyout", True)
    Int removeGold = price.GetValue() As Int
    PlayerRef.RemoveItem(Gold001, removeGold)
    Debug.TraceConditional("DF - _MDDeal - remove " + removeGold + " debt", True)

    If Rule1Code != 0
        DMC.RemoveRule(Rule1Code)
        If 17 == Rule1Code
            ExpensiveCount = 0
        EndIf
        Rule1Code = 0
    endif
    If Rule2Code != 0
        DMC.RemoveRule(Rule2Code)
        If 17 == Rule2Code
            ExpensiveCount = 0
        EndIf
        Rule2Code = 0
    endif
    If Rule3Code != 0
        DMC.RemoveRule(Rule3Code)
        If 17 == Rule3Code
            ExpensiveCount = 0
        EndIf
        Rule3Code = 0
    endif
    
    Int s = GetStage()
    If s > 3
        s = 3
    EndIf
    
    if s >= 3
      DC.DealMaxAdd(-1)
    Endif

    DC.DealAdd(-s)


    Reset()
    DealManager.RemoveDeal(self)

    DC.PickRandomDeal()

EndFunction

Function End()
	If Rule1Code != 0
		DMC.RemoveRule(Rule1Code)
        ExpensiveCount = 0
		Rule1Code = 0
	endif
	If Rule2Code != 0
		DMC.RemoveRule(Rule2Code)
        ExpensiveCount = 0
		Rule2Code = 0
	endif
	If Rule3Code != 0
		DMC.RemoveRule(Rule3Code)
        ExpensiveCount = 0
		Rule3Code = 0
	endif
	Reset()
EndFunction

Int Function GetRule1()
	Return Rule1Code
EndFunction

Int Function GetRule2()
	Return Rule2Code
EndFunction

Int Function GetRule3()
	Return Rule3Code
EndFunction

Function Save()
	PausedDaysRemaining = DealPriceTimer.GetValue() - GameDaysPassed.GetValue()
EndFunction

Function Restore()
	Float newTime = GameDaysPassed.GetValue() + PausedDaysRemaining
	DealPriceTimer.SetValue(newTime)
EndFunction


Function DelayReset()
	Delay = GameDaysPassed.GetValue() + 0.03
EndFunction

Function DelayForever()
	Delay = GameDaysPassed.GetValue() + 100.0
EndFunction

Function DelayDay()
	Delay = GameDaysPassed.GetValue() + 1.0
EndFunction

Function DelayHr()
	If (Delay <= (GameDaysPassed.getvalue()+0.03))
		Delay = GameDaysPassed.GetValue() + 0.07
	Endif
EndFunction

Function DelayHrs(Float hrs)
hrs = hrs/24
	If (Delay <= (GameDaysPassed.getvalue()+hrs))
		Delay = GameDaysPassed.GetValue() + hrs
	Endif
EndFunction




