Scriptname SLIF_Math Hidden

int function MinInteger(int val1, int val2, bool absolute = false) global
	if (absolute)
		val1 = Math.abs(val1) as int
		val2 = Math.abs(val2) as int
	endIf
	if (val1 < val2)
		return val1
	endIf
	return val2
endFunction

int function MinIntArray(int[] values, int default = 0, bool absolute = false) global
	int i = 0
	while(i < values.length)
		default = MinInteger(values[i], default, absolute)
		i += 1
	endWhile
	return default
endFunction

int function MaxInteger(int val1, int val2, bool absolute = false) global
	if (absolute)
		val1 = Math.abs(val1) as int
		val2 = Math.abs(val2) as int
	endIf
	if (val1 > val2)
		return val1
	endIf
	return val2
endFunction

int function MaxIntArray(int[] values, int default = 0, bool absolute = false) global
	int i = 0
	while(i < values.length)
		default = MaxInteger(values[i], default, absolute)
		i += 1
	endWhile
	return default
endFunction

float function MinFloat(float val1, float val2, bool absolute = false) global
	if (absolute)
		val1 = Math.abs(val1)
		val2 = Math.abs(val2)
	endIf
	if (val1 < val2)
		return val1
	endIf
	return val2
endFunction

float function MinFloatArray(float[] values, float default = 0.0, bool absolute = false) global
	int i = 0
	while(i < values.length)
		default = MinFloat(values[i], default, absolute)
		i += 1
	endWhile
	return default
endFunction

float function MaxFloat(float val1, float val2, bool absolute = false) global
	if (absolute)
		val1 = Math.abs(val1)
		val2 = Math.abs(val2)
	endIf
	if (val1 > val2)
		return val1
	endIf
	return val2
endFunction

float function MaxFloatArray(float[] values, float default = 0.0, bool absolute = false) global
	int i = 0
	while(i < values.length)
		default = MaxFloat(values[i], default, absolute)
		i += 1
	endWhile
	return default
endFunction

float function SetBounds(float value, float minimum, float maximum) global
	float tempMin = MinFloat(minimum, maximum)
	float tempMax = MaxFloat(minimum, maximum)
	if (value < tempMin)
		return tempMin
	endIf
	if (value > tempMax)
		return tempMax
	endIf
	return value
endFunction

Float Function DivideFloatNumbers(float Value, float Divisor) Global
	If (Divisor != 0.0)
		return Value / Divisor
	EndIf
	return Value
EndFunction

Float Function Average(float first, float second) Global
	return ((first + second) / 2)
EndFunction
