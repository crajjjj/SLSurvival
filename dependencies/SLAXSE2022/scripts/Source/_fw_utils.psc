Scriptname _fw_utils

; Return MAX of two Float values.
Float Function fMax(Float a, Float b) Global
{MAX of two FLOAT values.}
	If (a > b)
		return a
	Else
		return b
	EndIf
EndFunction

; Return MIN of two Int values.
Float Function fMin(Float a, Float b) Global
{MIN of two FLOAT values.}
	If (a < b)
		return a
	Else
		return b
	EndIf
EndFunction

; Return ABS value of a Float.
Float Function fAbs(Float value) Global
{ABS value of a FLOAT.}
	If value < 0.0
		return -value
	else
		return value
	EndIf
EndFunction

; Return a Float value bounded by upper and lower limits.
Float Function fClamp(Float lowerLimit, Float upperLimit, Float toBound) Global
{Clamps a FLOAT value within upper and lower limits.}
    If toBound > upperLimit
        Return upperLimit
    ElseIf toBound < lowerLimit
        Return lowerLimit
    Else
        Return toBound
    EndIf
endFunction



; Return MAX of two Int values.
Int Function iMax(Int a, Int b) Global
{MAX of two INT values.}
	If (a > b)
		return a
	Else
		return b
	EndIf
EndFunction

; Return MIN of two Int values.
Int Function iMin(Int a, Int b) Global
{MIN of two INT values.}
	If (a < b)
		return a
	Else
		return b
	EndIf
EndFunction

Int Function iAbs(Int value) Global
{ABS value of an INT.}
	If value < 0
		return -value
	else
		return value
	EndIf
EndFunction

; Return an Int value bounded by upper and lower limits.
Int Function iClamp(Int lowerLimit, Int upperLimit, Int toBound) Global
{Clamps an INT value within upper and lower limits.}
    If toBound > upperLimit
        Return upperLimit
    ElseIf toBound < lowerLimit
        Return lowerLimit
    Else
        Return toBound
    EndIf
endFunction


; Format bool as Yes/No string.
String Function YesNoString(Bool value) Global
{Convert bool to Yes/No string.}
	If value
		return "Yes"
	Else
		return "No"
	EndIf
EndFunction

String Function OkFailedString(Bool value) Global
    If value
        Return "OK"
    Else
        Return "FAILED"
    EndIf
EndFunction


String Function sChoose(Bool condition, String trueString, String falseString) Global
    If condition
        Return trueString
    EndIf
    Return falseString
EndFunction

Int Function iChoose(Bool condition, Int trueInt, Int falseInt) Global
    If condition
        Return trueInt
    EndIf
    Return falseInt
EndFunction


String Function FormatFloat_N2(Float value) Global
    Return FormatDecimal_x100((value * 100) as Int)
EndFunction

String Function FormatFloat_N1(Float value) Global
    Return FormatDecimal_x10((value * 10) as Int)
EndFunction

String Function FormatFloat_N0(Float value) Global
    Return "" + ((value+0.5) as Int)
EndFunction

String Function FormatFloatPercent_N0(Float value) Global
    Return "" + ((value+0.5) as Int) + "%"
EndFunction

String Function FormatFloatPercent_N1(Float value) Global
    Return FormatDecimal_x10((value * 10) as Int) + "%"
EndFunction



; Format single-digit fixed point integer as string.
String Function FormatDecimal_x10(Int value) Global
{Format an integer in fixed point format with a single digit of precision.}

    String sign = ""
    If value < 0
        sign = "-"
        value = -value
    EndIf
    
	Int x10 = value / 10
	Int remainder = value - (x10 * 10)
	
	return sign + (x10 as String) + "." + remainder
	
EndFunction


; Format two-digit fixed point integer as string.
String Function FormatDecimal_x100(Int value) Global
{Format an integer in fixed point format with two digits of precision.}

    String sign = ""
    If value < 0
        sign = "-"
        value = -value
    EndIf
    
	Int x10 = value / 10  ; e.g. 12456 => 12345
	Int x100 = x10 / 10   ; 123456 => 1234
	Int remainder1 = value - (x10 * 10) ; 123456 - 123450
	Int remainder2 = x10 - (x100 * 10) ; 12345 - 12340
	
	return sign + (x100 as String) + "." + remainder2 + remainder1
	
EndFunction


; Format integer  with at least two digits, add leading zero if needed.
String Function FormatDecimal_00(Int value) Global

    String out = ""
    If value < 0
        out = "-"
        value = -value
    EndIf
    
    If value < 10
        out += "0"
    EndIf
    
    return out + value
    
EndFunction


; Format integer  with at least three digits, add leading zeros if needed.
String Function FormatDecimal_000(Int value) Global

    String out = ""
    If value < 0
        out = "-"
        value = -value
    EndIf
    
    If value < 100
        out += "0"
    EndIf
    If value < 10
        out += "0"
    EndIf
    
    return out + value
    
EndFunction        


String Function FormatHex(Int value) Global

    String out = ""
    Int shift = 32
    
    While shift
    
        shift -= 4
        Int digit = Math.LogicalAnd(Math.RightShift(value, shift), 15)
        If digit < 10
            out += digit
        ElseIf 10 == digit
            out += "A"
        ElseIf 11 == digit
            out += "B"
        ElseIf 12 == digit
            out += "C"
        ElseIf 13 == digit
            out += "D"
        ElseIf 14 == digit
            out += "E"
        Else
            out += "F"
        EndIf
    
    EndWhile

    Return out
    
EndFunction

; Return string after the matching value, considering the array as circular.
String Function NextStringInArray(String currentString, String[] stringArray) Global
{Finds a string match in an array and returns the string value following, or the first value if the match is at the end.}

    Int ii = stringArray.Find(currentString)
    If ii < 0 || ii == stringArray.Length - 1
        return stringArray[0]
    EndIf
    return stringArray[ii + 1]

EndFunction


; Find int in an array of ints and returns a string at the matching index in an array of strings.
String Function MapIntToString(Int value, Int[] intValues, String[] stringValues) Global
{Finds the index of a value in an array of Ints, and returns the string at the same index from an array of strings.}

    Int ii = intValues.Find(value)
    If ii < 0
        return stringValues[0]
    EndIf
    
    return stringValues[ii]

EndFunction


String Function MapFloatToString(Float value, Float[] floatValues, String[] stringValues) Global
{Finds the index of a value closest in an array of Floats, and returns the string at the same index from an array of strings.}

	Float minDiff = fAbs(floatValues[0] - value)
	string minString = stringValues[0]

	int ii = 1
	While ii < floatValues.Length
		Float difference = fAbs(floatValues[ii] - value)
		If  difference < minDiff
			minDiff = difference
			minString = stringValues[ii]
		EndIf
	
		ii += 1
	EndWhile

	return minString

EndFunction


Int Function MapStringToInt(String value, Int[] intValues, String[] stringValues) Global

    Int ii = stringValues.Find(value)
    If ii < 0
        return intValues[0]
    EndIf
    return intValues[ii]

EndFunction


Float Function MapStringToFloat(String value, Float[] floatValues, String[] stringValues) Global

    Int ii = stringValues.Find(value)
    If ii < 0
        return floatValues[0]
    EndIf
    return floatValues[ii]

EndFunction


Float[] Function CopyFloatArrayForUpdate(Float[] source, Float[] target) Global
    Int ii = source.Length
    While ii
        ii -= 1
        target[ii] = source[ii]
    EndWhile
    Return target
EndFunction

String[] Function CopyStringArrayForUpdate(String[] source, String[] target) Global
    Int ii = source.Length
    While ii
        ii -= 1
        target[ii] = source[ii]
    EndWhile
    Return target
EndFunction


; Can only shuffle down, not up, but works when sections overlap
Function OffsetFloatChunkForUpdate(Float[] updating, Int from, Int to, Int count) Global
    If from >= to
        _fw_utils.Error("OffsetFloatChunkForUpdate bad parameters: array.Length: " + updating.Length + ", from: " + from + ", to: " + to + ", count: " + count)
        Return
    EndIf
    
    While count
        count -= 1
        updating[to + count] = updating[from + count]
        updating[from + count] = 0.0
    EndWhile
EndFunction


Bool Function GetIsWalking(Actor who)

	If who.IsSprinting() || who.IsRunning() || who.IsSneaking() || who.IsSwimming()
		Return False
	EndIf

	Return who.GetAnimationVariableFloat("Speed") > 0
    
endFunction


String Function GetActorSexString(Actor who) Global
    Int sex = who.GetActorBase().GetSex()
    If 1 == sex
        Return "Female"
    ElseIf 0 == sex
        Return "Male"
    EndIf
    Return "None"
EndFunction

Int Function GetActorSex(Actor who) Global
	ActorBase akBase = who.GetActorBase()
    Return akBase.GetSex()
EndFunction    

Bool Function IsMale(Actor who) Global
    Int sex = who.GetActorBase().GetSex()
    Return 0 == sex
EndFunction

Bool Function IsFemale(Actor who) Global
    Int sex = who.GetActorBase().GetSex()
    Return 1 == sex
EndFunction

Bool Function IsThing(Actor who) Global
    Int sex = who.GetActorBase().GetSex()
    Return -1 == sex
EndFunction
    
String Function GetActorName(Actor who) Global
	Return who.GetLeveledActorBase().GetName()
EndFunction

String Function DumpActorValue(Actor who, String valueName) Global
    Float baseValue = who.GetBaseActorValue(valueName)
    Float value = who.GetActorValue(valueName)
    Float percentage = who.GetActorValuePercentage(valueName)
    Float currentMax = 0.0
    If percentage > 0.0
        currentMax = Math.Ceiling(value / percentage)
    EndIf
    Float realMax = currentMax
    ; realMax = MIN(baseValue, currentMax)
    If baseValue < currentMax
        realMax = baseValue
    EndIf
    Return valueName + " :: base: " + baseValue + ", current: " + value + ", percentage: " + percentage + ", currentMax " + currentMax + ", realMax: " + realMax
EndFunction




Bool Function DebugSpam_IsEnabled() Global
    Int enabled = StorageUtil.GetIntValue(None, "fw_EnableDebugSpam")
    Return 0 != enabled
EndFunction

Int Function DebugSpam_GetSeverity() Global
    Return StorageUtil.GetIntValue(None, "fw_TraceSpamSeverity", 127)
EndFunction


Function DebugSpam_SetInfo() Global
    StorageUtil.SetIntValue(None, "fw_EnableDebugSpam", 1)
    StorageUtil.SetIntValue(None, "fw_TraceSpamSeverity", 0)
EndFunction

Function DebugSpam_SetWarning() Global
    StorageUtil.SetIntValue(None, "fw_EnableDebugSpam", 1)
    StorageUtil.SetIntValue(None, "fw_TraceSpamSeverity", 1)
EndFunction

Function DebugSpam_SetError() Global
    StorageUtil.SetIntValue(None, "fw_EnableDebugSpam", 1)
    StorageUtil.SetIntValue(None, "fw_TraceSpamSeverity", 2)
EndFunction

Function DebugSpam_SetAlert() Global
    StorageUtil.SetIntValue(None, "fw_EnableDebugSpam", 1)
    StorageUtil.SetIntValue(None, "fw_TraceSpamSeverity", 3)
EndFunction

Function DebugSpam_Off_AlertsOn() Global
    StorageUtil.SetIntValue(None, "fw_EnableDebugSpam", 0)
    StorageUtil.SetIntValue(None, "fw_TraceSpamSeverity", 3)
EndFunction

Function DebugSpam_Off() Global
    StorageUtil.SetIntValue(None, "fw_EnableDebugSpam", 0)
    StorageUtil.SetIntValue(None, "fw_TraceSpamSeverity", 4)
EndFunction


Function EnableDebugSpam(Bool enable) Global
    StorageUtil.SetIntValue(None, "fw_EnableDebugSpam", enable as Int)
EndFunction

Function Notify(String txtMsg) Global
	If StorageUtil.GetIntValue(None, "fw_EnableDebugSpam")
		Debug.Notification(txtMsg)
	EndIf
EndFunction

Function MessageBox(String txtMsg) Global
	If StorageUtil.GetIntValue(None, "fw_EnableDebugSpam")
		Debug.MessageBox(txtMsg)
	EndIf
EndFunction


; Debug Trace severity levels:
; 0: info, 1: warning, 2: error, (3: alert - not a Bethesda value)
; Only messages of at least enabled level are logged.
;
Function EnableTraceSpam(int severity = 0) Global
    StorageUtil.SetIntValue(None, "fw_TraceSpamSeverity", severity)
EndFunction

Function DisableTraceSpam() Global
    StorageUtil.SetIntValue(None, "fw_TraceSpamSeverity", 127)
EndFunction

Function Trace(Int severity, String txtMsg) Global
	If severity >= StorageUtil.GetIntValue(None, "fw_TraceSpamSeverity", 127)
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

; Yes, I know these messages are severity filtered twice as implemented. (tdt?)
; This allows Debug.Trace to be swapped for direct file logging, or a text buffer, or anything you like without changing the callers.
Function Info(String txtMsg) Global
	If StorageUtil.GetIntValue(None, "fw_TraceSpamSeverity", 127) <= 0
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

Function InfoConditional(String txtMsg, Bool condition) Global
	If condition && StorageUtil.GetIntValue(None, "fw_TraceSpamSeverity", 127) <= 0
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

Function Warning(String txtMsg) Global
	If StorageUtil.GetIntValue(None, "fw_TraceSpamSeverity", 127) <= 1
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

Function WarningConditional(String txtMsg, Bool condition) Global
	If condition && StorageUtil.GetIntValue(None, "fw_TraceSpamSeverity", 127) <= 1
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

Function Error(String txtMsg) Global
	If StorageUtil.GetIntValue(None, "fw_TraceSpamSeverity", 127) <= 2
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

Function ErrorConditional(String txtMsg, Bool condition) Global
	If condition && StorageUtil.GetIntValue(None, "fw_TraceSpamSeverity", 127) <= 2
        Debug.Trace(txtMsg, 2)
    EndIf
EndFunction

Function Spam(String txtMsg) Global
    Debug.Trace(txtMsg, 2)
EndFunction

Function Alert(String txtMsg) Global
    If StorageUtil.GetIntValue(None, "fw_TraceSpamSeverity", 127) <= 3
        Debug.TraceAndBox(txtMsg, 2)
    EndIf
EndFunction

Function AlertConditional(String txtMsg, Bool condition) Global
    If condition && StorageUtil.GetIntValue(None, "fw_TraceSpamSeverity", 127) <= 3
        Debug.TraceAndBox(txtMsg, 2)
    EndIf
EndFunction

Function DumpStackConditional(String txtMsg, Bool condition) Global ; Must set info level to see these
    If condition && StorageUtil.GetIntValue(None, "fw_TraceSpamSeverity", 127) <= 0
        Debug.TraceStack(txtMsg, 2)
    EndIf
EndFunction


Function DumpStorageUtilInts(Form what, string prefix) Global

        Int count = StorageUtil.CountObjIntValuePrefix(what, prefix)
        String formInfo = "None"
        If what
            formInfo = "0x" + FormatHex(what.GetFormId())
        EndIf
        _fw_utils.Info("FWB - DumpStorageUtilInts - counted " + count + " stored ints with prefix '" + prefix + "' on " + formInfo)
        
        String[] keys = StorageUtil.debug_AllObjIntKeys(what)
        Int len = keys.Length
        
        _fw_utils.Info("FWB - DumpStorageUtilInts - found " + keys.Length + " keys on form " + formInfo)
        
        Int ii = 0
        While ii < len
            _fw_utils.Info("FWB - DumpStorageUtilInts - storage key: " + ii + " - '" + keys[ii] + "' = " + StorageUtil.GetFloatValue(what, keys[ii]) ) 
            ii += 1
        EndWhile

EndFunction


Function DumpStorageUtilFloats(Form what, string prefix) Global

        Int count = StorageUtil.CountObjFloatValuePrefix(what, prefix)
        String formInfo = "None"
        If what
            formInfo = "0x" + FormatHex(what.GetFormId())
        EndIf
        _fw_utils.Info("FWB - DumpStorageUtilFloats - counted " + count + " stored floats with prefix '" + prefix + "' on " + formInfo)
        
        String[] keys = StorageUtil.debug_AllObjFloatKeys(what)
        Int len = keys.Length
        
        _fw_utils.Info("FWB - DumpStorageUtilFloats - found " + keys.Length + " keys on form " + formInfo)
        
        Int ii = 0
        While ii < len
            _fw_utils.Info("FWB - DumpStorageUtilFloats - storage key: " + ii + " - '" + keys[ii] + "' = " + StorageUtil.GetFloatValue(what, keys[ii]) ) 
            ii += 1
        EndWhile

EndFunction

;
;EOF
;