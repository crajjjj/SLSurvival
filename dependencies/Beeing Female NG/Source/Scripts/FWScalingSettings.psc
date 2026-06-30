Scriptname FWScalingSettings   

; Node Set
; 0 = Belly
; 1 = Breasts

float function Realistic(int NodeSet, int PhaseID) global
	if NodeSet == 0
		If PhaseID == 0
			Return 0.15
		elseIf PhaseID == 1
			Return 0.50
		elseIf PhaseID == 2
			Return 0.35
		EndIf
	ElseIf NodeSet == 1
		If PhaseID == 0
			Return 0.05
		elseIf PhaseID == 1
			Return 0.2
		elseif PhaseID == 2
			Return 0.75
		EndIf
	EndIf
endFunction

float function Linear(int NodeSet, int PhaseID) global
	If NodeSet == 0
		If PhaseID == 0
			Return 0.33
		elseIf PhaseID == 1
			Return 0.33
		elseIf PhaseID == 2
			Return 0.34
		EndIf
	ElseIf NodeSet == 1
		If PhaseID == 0
			Return 0.33
		elseIf PhaseID == 1
			Return 0.33
		elseif PhaseID == 2
			Return 0.34
		EndIf
	EndIf
endFunction

float function Immediately(int NodeSet, int PhaseID) global
	If NodeSet == 0
		If PhaseID == 0
			Return 0.50
		elseIf PhaseID == 1
			Return 0.20
		elseIf PhaseID == 2
			Return 0.30
		EndIf
	ElseIf NodeSet == 1
		If PhaseID == 0
			Return 0.70
		elseIf PhaseID == 1
			Return 0.15
		elseif PhaseID == 2
			Return 0.15
		EndIf
	EndIf
endFunction

float function Breasts(int NodeSet, int PhaseID) global
	if NodeSet == 0
		If PhaseID == 0
			Return 0.01
		elseIf PhaseID == 1
			Return 0.05
		elseIf PhaseID == 2
			Return 0.94
		EndIf
	ElseIf NodeSet == 1
		If PhaseID == 0
			Return 0.20
		elseIf PhaseID == 1
			Return 0.35
		elseif PhaseID == 2
			Return 0.45
		EndIf
	EndIf
endFunction

float function Belly(int NodeSet, int PhaseID) global
	if NodeSet == 0
		If PhaseID == 0
			Return 0.25
		elseIf PhaseID == 1
			Return 0.35
		elseIf PhaseID == 2
			Return 0.40
		EndIf
	ElseIf NodeSet == 1
		If PhaseID == 0
			Return 0.05
		elseIf PhaseID == 1
			Return 0.10
		elseif PhaseID == 2
			Return 0.85
		EndIf
	EndIf
endFunction

float function Late(int NodeSet, int PhaseID) global
	if NodeSet == 0
		If PhaseID == 0
			Return 0.05
		elseIf PhaseID == 1
			Return 0.05
		elseIf PhaseID == 2
			Return 0.90
		EndIf
	ElseIf NodeSet == 1
		If PhaseID == 0
			Return 0.05
		elseIf PhaseID == 1
			Return 0.08
		elseif PhaseID == 2
			Return 0.87
		EndIf
	EndIf
endFunction