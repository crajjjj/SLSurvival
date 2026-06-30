Scriptname _SLS_IntMa  Hidden

; _MA_Mcm (extends SKI_ConfigBase) holds the per-strength buff durations as Int properties.
; Withdrawal/addiction stage is derived from the pool GlobalVariable in the interface instead of
; from _MA_Main: _MA_Main.AddictionStage is a private (non-property) variable and its
; GetAddictionStage() returns void with side effects (notifications, spell swaps), so it can't be
; used as a getter.

Int Function GetDurDilute(Quest MaMcm) Global
	Return (MaMcm as _MA_Mcm).DurationDilute
EndFunction

Int Function GetDurWeak(Quest MaMcm) Global
	Return (MaMcm as _MA_Mcm).DurationWeak
EndFunction

Int Function GetDurRegular(Quest MaMcm) Global
	Return (MaMcm as _MA_Mcm).DurationRegular
EndFunction

Int Function GetDurStrong(Quest MaMcm) Global
	Return (MaMcm as _MA_Mcm).DurationStrong
EndFunction

Int Function GetDurTasty(Quest MaMcm) Global
	Return (MaMcm as _MA_Mcm).DurationTasty
EndFunction

Int Function GetDurCreamy(Quest MaMcm) Global
	Return (MaMcm as _MA_Mcm).DurationCreamy
EndFunction

Int Function GetDurEnriched(Quest MaMcm) Global
	Return (MaMcm as _MA_Mcm).DurationEnriched
EndFunction

Int Function GetDurSublime(Quest MaMcm) Global
	Return (MaMcm as _MA_Mcm).DurationSublime
EndFunction
