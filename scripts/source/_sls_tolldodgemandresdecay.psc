Scriptname _SLS_TollDodgeMandResDecay extends Quest  

Event OnInit()
	SetNextUpdate()
EndEvent

Event OnUpdateGameTime()
	Float GameTime = Utility.GetCurrentGameTime()
	If GameTime > TollDodge.RestraintReqWhiterun && TollDodge.RestraintLevelWhiterun > 0
		TollDodge.RestraintLevelWhiterun -= 1
		If TollDodge.RestraintLevelWhiterun > 0
			TollDodge.RestraintReqWhiterun = GameTime + 7.0
		EndIf
		;Debug.Messagebox("Reduced mand restraint in whiterun")
		Debug.Notification("The guards in Whiterun should go a little easier on me now")
	EndIf
	
	If GameTime > TollDodge.RestraintReqSolitude && TollDodge.RestraintLevelSolitude > 0
		TollDodge.RestraintLevelSolitude -= 1
		If TollDodge.RestraintLevelSolitude > 0
			TollDodge.RestraintReqSolitude = GameTime + 7.0
		EndIf
		;Debug.Messagebox("Reduced mand restraint in solitude")
		Debug.Notification("The guards in Solitude should go a little easier on me now")
	EndIf
	
	If GameTime > TollDodge.RestraintReqMarkarth && TollDodge.RestraintLevelMarkarth > 0
		TollDodge.RestraintLevelMarkarth -= 1
		If TollDodge.RestraintLevelMarkarth > 0
			TollDodge.RestraintReqMarkarth = GameTime + 7.0
		EndIf
		;Debug.Messagebox("Reduced mand restraint in markarth")
		Debug.Notification("The guards in Markarth should go a little easier on me now")
	EndIf
	
	If GameTime > TollDodge.RestraintReqWindhelm && TollDodge.RestraintLevelWindhelm > 0
		TollDodge.RestraintLevelWindhelm -= 1
		If TollDodge.RestraintLevelWindhelm > 0
			TollDodge.RestraintReqWindhelm = GameTime + 7.0
		EndIf
		;Debug.Messagebox("Reduced mand restraint in windhelm")
		Debug.Notification("The guards in Windhelm should go a little easier on me now")
	EndIf
	
	If GameTime > TollDodge.RestraintReqRiften && TollDodge.RestraintLevelRiften > 0
		TollDodge.RestraintLevelRiften -= 1
		If TollDodge.RestraintLevelRiften > 0
			TollDodge.RestraintReqRiften = GameTime + 7.0
		EndIf
		;Debug.Messagebox("Reduced mand restraint in riften")
		Debug.Notification("The guards in Riften should go a little easier on me now")
	EndIf

	SetNextUpdate()
EndEvent

Function SetNextUpdate()
	Float GameTime = Utility.GetCurrentGameTime()
	Float ClosestTime = 100000000.0
	Float CurTown
	
	CurTown = TollDodge.RestraintReqWhiterun
	If CurTown > GameTime ; Has not already passed
		If CurTown < ClosestTime
			ClosestTime = CurTown
		EndIf
	EndIf
	
	CurTown = TollDodge.RestraintReqSolitude
	If CurTown > GameTime ; Has not already passed
		If CurTown < ClosestTime
			ClosestTime = CurTown
		EndIf
	EndIf
	
	CurTown = TollDodge.RestraintReqMarkarth
	If CurTown > GameTime ; Has not already passed
		If CurTown < ClosestTime
			ClosestTime = CurTown
		EndIf
	EndIf
	
	CurTown = TollDodge.RestraintReqWindhelm
	If CurTown > GameTime ; Has not already passed
		If CurTown < ClosestTime
			ClosestTime = CurTown
		EndIf
	EndIf
	
	CurTown = TollDodge.RestraintReqRiften
	If CurTown > GameTime ; Has not already passed
		If CurTown < ClosestTime
			ClosestTime = CurTown
		EndIf
	EndIf
	
	If ClosestTime > GameTime
		RegisterForSingleUpdateGameTime((ClosestTime - GameTime) * 24.0)
	Else
		Self.Stop()
	EndIf
EndFunction

_SLS_TollDodge Property TollDodge Auto
