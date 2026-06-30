Scriptname zadprebuildedexpressions Hidden

; BUILD-ONLY STUB for SLSurvival compilation.
; The full prebuilt-expression table ships in the installed Devious Devices NG .pex and
; is not present in the available source set. SLSurvival does not use these expressions;
; only the two functions referenced by zadLibs are stubbed so the type resolves at compile
; time. Real values come from the installed DD NG .pex at runtime.

float[] Function GetPrebuildExpression_Orgasm1() Global
	return new float[1]
EndFunction

float[] Function GetPrebuildExpression_Orgasm2() Global
	return new float[1]
EndFunction
