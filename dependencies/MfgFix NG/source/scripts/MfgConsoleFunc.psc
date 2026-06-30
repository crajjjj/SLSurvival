Scriptname MfgConsoleFunc Hidden

; Native functions. mode: -1=reset, 0=phoneme, 1=modifier, 2=expression value, 3=expression id (get only).
; value: [ 0 , 200 ] — 0 to 100 is the normal range; 101-200 is allowed and may produce exaggerated morphs.
; GetPhonemeModifier returns the current value in 0-100 scale, or -1 on error.
bool function SetPhonemeModifier(Actor act, int mode, int id, int value) native global
int function GetPhonemeModifier(Actor act, int mode, int id) native global

; wrapper functions

; set phoneme/modifier, same as console.
bool function SetPhoneme(Actor act, int id, int value) global
	return SetPhonemeModifier(act, 0, id, value)
endfunction
bool function SetModifier(Actor act, int id, int value) global
	return SetPhonemeModifier(act, 1, id, value)
endfunction

; reset phoneme/modifier. this does not reset expression.
bool function ResetPhonemeModifier(Actor act) global
	return SetPhonemeModifier(act, -1, 0, 0)
endfunction

; get phoneme/modifier/expression
int function GetPhoneme(Actor act, int id) global
	return GetPhonemeModifier(act, 0, id)
endfunction
int function GetModifier(Actor act, int id) global
	return GetPhonemeModifier(act, 1, id)
endfunction

; return expression value which is enabled. (enabled only one at a time.)
int function GetExpressionValue(Actor act) global
	return GetPhonemeModifier(act, 2, GetExpressionID(act))
endfunction
; return expression ID which is enabled.
int function GetExpressionID(Actor act) global
	return GetPhonemeModifier(act, 3, 0)
endfunction

bool function GetModifiedScript() global
    return true
endFunction