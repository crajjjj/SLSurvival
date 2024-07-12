Scriptname SuccubusEnergyBarUpdate Extends Quest

SuccubusEnergyBar Property EnergyBar Auto
PlayerSuccubusQuestScript Property PSQ Auto

Bool Property EnegyBarVisible = True Auto Hidden
Float Property ColorChangeThreshould01 = 0.85 Auto Hidden
Float Property ColorChangeThreshould02 = 0.50 Auto Hidden
Float Property ColorChangeThreshould03 = 0.30 Auto Hidden
Float Property EnergyBarX = 495.0 Auto Hidden
Float Property EnergyBarY = 700.0 Auto Hidden
String Property EnergyBarFillDirection = "Both" Auto Hidden
Int Property EnergyBarColor1A = 0xBF56A6 Auto Hidden
Int Property EnergyBarColor1B = 0x5F0026 Auto Hidden
Int Property EnergyBarColor2A = 0xFF96e6 Auto Hidden
Int Property EnergyBarColor2B = 0x9F1666 Auto Hidden
Int Property EnergyBarColor3A = 0xFFFFE0 Auto Hidden
Int Property EnergyBarColor3B = 0x9F9F80 Auto Hidden
Int Property EnergyBarColor4A = 0xAFEEEE Auto Hidden
Int Property EnergyBarColor4B = 0x2F8E8E Auto Hidden

Event OnInit()
	EnergyBar.HAnchor = "left"
	EnergyBar.VAnchor = "bottom"
	EnergyBar.X = EnergyBarX
	EnergyBar.Y = EnergyBarY
	EnergyBar.Alpha = 100.0
	EnergyBar.SetPercent(1.0)
	EnergyBar.FillDirection = EnergyBarFillDirection
	EnergyBar.SetColors(EnergyBarColor2B, EnergyBarColor2A)
EndEvent

Function UpdateEnergyBar(Float Manpukudo)
	EnergyBar.SetPercent(Manpukudo)
	If Manpukudo >= ColorChangeThreshould01
		EnergyBar.SetColors(EnergyBarColor1A, EnergyBarColor1B)
	ElseIf Manpukudo >= ColorChangeThreshould02
		EnergyBar.SetColors(EnergyBarColor2A, EnergyBarColor2B)
	ElseIf Manpukudo >= ColorChangeThreshould03
		EnergyBar.SetColors(EnergyBarColor3A, EnergyBarColor3B)
	Else
		EnergyBar.SetColors(EnergyBarColor4A, EnergyBarColor4B)
	EndIf
EndFunction

Function UpdateEnergyBarPosition()
	EnergyBar.HAnchor = "left"
	EnergyBar.VAnchor = "bottom"
	EnergyBar.X = EnergyBarX
	EnergyBar.Y = EnergyBarY
	EnergyBar.FillDirection = EnergyBarFillDirection
	If EnegyBarVisible
		EnergyBar.Alpha = 100.0
	Else
		EnergyBar.Alpha = 0.0
	EndIf
	EnergyBar.SetPercent(PSQ.SuccubusEnergy.GetValue() / PSQ.MaxEnergy)
EndFunction
