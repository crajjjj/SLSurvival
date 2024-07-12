scriptname sslUtility hidden

;/-----------------------------------------------\;
;|	Utility Functions
;\-----------------------------------------------/;

string function GetItemName(Form akItemRef, string AltName = "$UNKNOWN") global
	if !akItemRef
		return ""
	endIf
	string Name = akItemRef.GetName()
	If (akItemRef as Cell)
		Name = (akItemRef as Cell).GetName()
	else
		Name = akItemRef.GetName()
	endIf
	if Trim(Name) != ""
		return Name
	endIf
	return AltName
endFunction

string function GetFormFile(form akForm) global
	int[] IDs = SplitFormID(akForm)
	return "../SexLab/C/Mod_"+GetModName(IDs[0])+"/"+IntToHex(IDs[1])+".json"
endFunction

string Function GetFormAsString(Form akForm) Global
	int[] IDs = SplitFormID(akForm)
	return IntToHex(IDs[1],"0x")+"|"+GetModName(IDs[0])
endFunction

Form Function GetStringAsForm(String asForm) Global
	If StringUtil.Find(asForm, "|") > 0
		string[] Argments = StringUtil.Split(asForm, "|")
	;	Log(Argments,"GetStringAsForm("+asForm+")")
		If Argments && Argments.Length == 2 && Trim(Argments[1]) != ""
			int formId = HexToInt(Argments[0], "0x")
			if formId > 0
	;		Log(IntToHex(formId),"GetStringAsForm("+asForm+")")
				Return Game.GetFormFromFile(formId, Argments[1])
			endIf
		Else
			int formId = Trim(Argments[0]) as int
			If formId as String != Trim(Argments[0])
				formId = HexToInt(Argments[0], "0x")
			endIf
			if formId > 0
				Return Game.GetFormFromFile(formId, Argments[1])
			endIf
		EndIf
	EndIf
	return none
endFunction

bool Function IsPluginInstalled(string name) global
	return ((SKSE.GetScriptVersionRelease() >= 64 && Game.IsPluginInstalled(name)) || Game.GetModByName(name) != 255)
endFunction

string Function GetModName(int aiModID) Global
	If aiModID != -1
		string ModName
		if aiModID >= 0 && aiModID < 255
			ModName = Game.GetModName(aiModID)   ; Name of mod Actor originates from
		endif
		if ModName == "" && SKSE.GetScriptVersionRelease() >= 64
			ModName = Game.GetLightModName(Math.LogicalAnd(aiModID, 0x00fff))
		endif
	;	Log("ID:"+ID+"; MODID:"+MODID+"; ModName:"+ModName, "GetModName("+akForm+")")
		return ModName
	EndIf
	return "" 
EndFunction

int[] Function SplitFormID(Form akForm) Global
	Int[] output = new int[2]
	If akForm
		int ID = akForm.GetFormID()					; Full ID
		int MODID = Math.RightShift(ID, 24)         ; Extract MOD ID
		int FormID = Math.LogicalAnd(ID, 0x00ffffff)        ; Extract ID without load order
		string ModName = Game.GetModName(MODID)   ; Name of mod Actor originates from
	;	Log("ID:"+ID+"; FormID:"+FormID+"; MODID:"+MODID+"; ModName:"+ModName, "SplitFormID("+akForm+")")
		if ModName == "" && SKSE.GetScriptVersionRelease() >= 64
			MODID = Math.RightShift(ID, 12)
			FormID = Math.LogicalAnd(ID, 0x00000fff)        ; Extract ID without load order
			; Game.GetLightModName(ModIndex - 1040384) ; FE000 = 1040384 The Light Mod Index start counting from there.
			ModName = Game.GetLightModName(Math.LogicalAnd(MODID, 0x00fff)) 
		endif
	;	Log("ID:"+ID+"; FormID:"+FormID+"; MODID:"+MODID+"; ModName:"+ModName, "SplitFormID("+akForm+")")
		if ModName != ""
			output[0] = MODID
			output[1] = FormID
		endif
	EndIf
	return output
EndFunction

String FUNCTION IntToHex(Int Interger, String Append="", Bool Suffix=False) Global
	; sample: 842 -> "0000034A"
	; 842  = 8*10² + 4*10 + 2*1          ; base 10
	; 34Ah = 3*16² + 4*16 + A*1          ; base 16
	; convert a signed integer (longint32) into unsigned doubleword as hexstring
	; positive: 0x0        .. 0x7fffffff
	; negative: 0x80000000 .. 0xffffffff

	int T                                ; Zero by default
	int n = Interger
	IF (n < 0)
		n = 0x7FFFFFFF + n + 1       ; transform negative to positive  (2147483647 == 0x7FFFFFFF)
		T = 8
	ENDIF
	T = (n / 0x10000000) + T         ; store leading halfbyte
	string output                             ; "" by default
	int j
	int i = 8                            ; minimum length of string (that will be the return value)
	WHILE (i)            ; (i > 0)
		i = i - 1
		IF (i)
			j = n % 16               ; n iMODULO 16 == (n AND 15)
			n = n / 16               ; n iDIV 16    == (n SHR 4)
		ELSE
			j = T                    ; get stored halfbyte
		ENDIF

		IF     (j < 10)
					output = (j as String) + output    ; "0" .. "9"
		ELSEIF (j == 15)
					output = "F" + output
		ELSEIF (j == 14)
					output = "E" + output
		ELSEIF (j == 13)
					output = "D" + output
		ELSEIF (j == 12)
					output = "C" + output
		ELSEIF (j == 11)
					output = "B" + output
		ELSEIF (j == 10)
					output = "A" + output
		ELSE
					output = "#" + output ; Means ERROR
		ENDIF
	ENDWHILE                
	;    -------------------------------- append parameter string
	IF ( Suffix )
		output = output + Append        ; as suffix
	ELSE
		output = Append + output        ; as prefix (by default)
	ENDIF
;	Log(output,"IntToHex("+Interger+", "+Append+", "+Suffix+")")
	RETURN output
endFunction

int Function HexToInt(string Hex, String Append="", Bool Suffix=False) Global
	int StartIndex = StringUtil.Find(Hex, Append, StartIndex)
	If StartIndex != -1
		If !Suffix
			Hex = StringUtil.Substring(Hex, StartIndex + StringUtil.GetLength(Append))
		Else
			Hex = StringUtil.Substring(Hex, 0, StartIndex)
		EndIf	
	EndIf	
	String HexString = RemoveSubString(Hex, " ")
	If HexString == ""
		return 0
	EndIf
	StartIndex = StringUtil.GetLength(HexString)
	If StartIndex > 8 ; Limited to INT32
		HexString = StringUtil.Substring(HexString, StartIndex - 8)
	EndIf
	StartIndex = StringUtil.GetLength(HexString)
	
	int output
	int n = 0
	string Chart
	While StartIndex > 0
		StartIndex -= 1
		Chart = StringUtil.GetNthChar(HexString, startIndex)
		If StringUtil.IsDigit(Chart)
			output += (Chart as int) * (Math.pow(16.0, n as float)) as int
		ElseIf Chart == "F"
			output += 15 * (Math.pow(16.0, n as float)) as int
		ElseIf Chart == "E"
			output += 14 * (Math.pow(16.0, n as float)) as int
		ElseIf Chart == "D"
			output += 13 * (Math.pow(16.0, n as float)) as int
		ElseIf Chart == "C"
			output += 12 * (Math.pow(16.0, n as float)) as int
		ElseIf Chart == "B"
			output += 11 * (Math.pow(16.0, n as float)) as int
		ElseIf Chart == "A"
			output += 10 * (Math.pow(16.0, n as float)) as int
		Else
			startIndex = -1
		EndIf
		n += 1
	EndWhile
;	Log(output,"HexToInt("+HexString+", "+Append+", "+Suffix+")")
	return output
endFunction

int function IndexTravel(int CurrentIndex, int ArrayLength, bool Reverse = false) global
	if Reverse
		CurrentIndex -= 1
	else
		CurrentIndex += 1
	endIf
	if CurrentIndex >= ArrayLength
		return 0
	elseif CurrentIndex < 0
		return ArrayLength - 1
	endIf
	return CurrentIndex
endFunction

; Remove the spaces from the edges of the string. For a full cleanse of the spaces better use the RemoveSubString function.
string function TrimString(string str, bool DeepClean = true) global
	if StringUtil.GetNthChar(str, 0) == " "
		str = StringUtil.SubString(str, 1)
		if DeepClean
		;	Log("TrimString("+str+", "+DeepClean+")")
			return TrimString(str, DeepClean)
		endIf
	endIf
	if StringUtil.GetNthChar(str, StringUtil.GetLength(str) - 1) == " "
		str = StringUtil.SubString(str, 0, StringUtil.GetLength(str) - 1)
		if DeepClean
		;	Log("Trim("+str+", "+DeepClean+")")
			return TrimString(str, DeepClean)
		endIf
	endIf
	return str
endFunction


; Clean the str string from string toRemove.
string function RemoveSubString(string str, string toRemove, int startindex = 0, bool DeepClean = true) global
	int i = StringUtil.Find(str, toRemove, startindex)
	if i == -1 || toRemove == ""
		return str
	elseIf i == 0
		str = StringUtil.SubString(str, StringUtil.GetLength(toRemove))
		if DeepClean
	;		Log("RemoveSubString("+str+", "+toRemove+", "+startindex+", "+DeepClean+")")
			return RemoveSubString(str, toRemove, startindex, DeepClean)
		endIf
		return str
	endIf
	string part1 = StringUtil.SubString(str, 0, i)
	string part2 = StringUtil.SubString(str, i + StringUtil.GetLength(toRemove))
	str = part1 + part2
	if DeepClean
	;	Log("RemoveSubString("+str+", "+toRemove+", "+startindex+", "+DeepClean+")")
		return RemoveSubString(str, toRemove, startindex, DeepClean)
	endIf
	return str
endFunction

string function MakeArgs(string delimiter, string arg1, string arg2 = "", string arg3 = "", string arg4 = "", string arg5 = "") global
	if arg2 != ""
		arg1 += delimiter+arg2
	endIf
	if arg3 != ""
		arg1 += delimiter+arg3
	endIf
	if arg4 != ""
		arg1 += delimiter+arg4
	endIf
	if arg5 != ""
		arg1 += delimiter+arg5
	endIf
	return arg1
endFunction

Actor[] function MakeActorArray(Actor Actor1 = none, Actor Actor2 = none, Actor Actor3 = none, Actor Actor4 = none, Actor Actor5 = none) global
	return SexLabUtil.MakeActorArray(Actor1, Actor2, Actor3, Actor4, Actor5)
endFunction

string[] function GetActorKeys(string AdjustKey) global
	string[] PositionIDs
	if AdjustKey
		PositionIDs = PapyrusUtil.StringSplit(AdjustKey, ".")
		int Position = PositionIDs.length
		; Check if the last PositionIDs is the position number to discart it.
		If Position > 0 && (PositionIDs[Position - 1] as int) as String == PositionIDs[Position - 1]
			return PapyrusUtil.ResizeStringArray(PositionIDs, Position - 1)
		EndIf
	EndIf
	return PositionIDs
endFunction

string[] function SplitAdjustKey(string AdjustKey) global
	string[] output
	if AdjustKey
		string[] PositionIDs = PapyrusUtil.StringSplit(AdjustKey, ".")
		int Position = PositionIDs.length
		; Check if the last PositionIDs is the position number to discart it.
		If Position > 0 && (PositionIDs[Position - 1] as int) as String == PositionIDs[Position - 1]
			Position = Position - 1
		EndIf
		output = Utility.CreateStringArray(Position * 3) 
		int ID
		While Position
			Position -= 1
			ID = Position * 3
			output[ID+0] = PositionIDs[Position]
			Race RaceRef = Race.GetRace(output[ID+0])
			if !(RaceRef || output[ID+0] == "Humanoid" || output[ID+0] == "Global" || sslCreatureAnimationSlots.HasRaceKey(output[ID+0]))
				int i = 0
				int LengthID = StringUtil.GetLength(PositionIDs[Position])
				while i < LengthID && i < 6 ; More tha 5 is pointles sice the last characters are only one Letter and two Digits
					i += 1
					output[ID+0] = StringUtil.Substring(PositionIDs[Position], 0, LengthID - i)
					RaceRef = Race.GetRace(output[ID+0])
					if RaceRef || output[ID+0] == "Humanoid" || sslCreatureAnimationSlots.HasRaceKey(output[ID+0])
						output[ID+1] = StringUtil.GetNthChar(PositionIDs[Position], LengthID - i)
						If (output[ID+1] == "M") || (output[ID+1] == "F") || (output[ID+1] == "C")
							output[ID+2] = StringUtil.Substring(PositionIDs[Position], LengthID)
						Else
							output[ID+1] = ""
						EndIf
						i = 6 ; Exit While
					ElseIf i >= 6
						output[ID+0] = "Global"
					endIf
				endWhile
			endIf
		endWhile
	endIf
	return output
endFunction

string[] function FilterAdjustKeysByActorKey(string[] AdjustKeys, string ActorKey, int Position = -1, int PositionCount = 5, bool ExactMatch = True) Global
	string[] output
	if ActorKey
		output = PapyrusUtil.ResizeStringArray(AdjustKeys, AdjustKeys.Length+1, "") ; Copy the AdjustKeys to avoid edit it.
		
		int i = output.Length
		While i
			i -= 1
			If StringUtil.Find(output[i], ActorKey) != -1
				string[] ActorKeys = GetActorKeys(output[i])
				If Position >= 0 && Position < PositionCount
					If (ActorKeys[Position] == ActorKey) || (!ExactMatch && StringUtil.Find(ActorKeys[Position], ActorKey) != -1)
						; Keep it
					Else
						output[i] = ""
					EndIf
				ElseIf ExactMatch && (ActorKeys.Length < PositionCount || ActorKeys.Find(ActorKey) == -1)
					output[i] = ""
				EndIf
			Else
				output[i] = ""
			EndIf
		EndWhile
		return PapyrusUtil.RemoveString(output, "")
	EndIf
	return output
endFunction

;/-----------------------------------------------\;
;|	DEPRECATED Utility Functions -
;|     - See PapyrusUtil.psc
;\-----------------------------------------------/;

;/* Trim DEPRECATED!
* * (DEPRECATED) Use TrimString
*/;
string function Trim(string var) global
	return TrimString(var, FALSE)
endFunction

;/* RemoveString DEPRECATED!
* * (DEPRECATED) Use RemoveSubString
*/;
string function RemoveString(string str, string toRemove, int startindex = 0) global
	return RemoveSubString(str, toRemove, startindex, FALSE)
endFunction

;/* PushAnimation DEPRECATED!
* * (DEPRECATED) Use PushAnimationToArray
*/;
sslBaseAnimation[] function PushAnimation(sslBaseAnimation var, sslBaseAnimation[] Array) global
	return PushAnimationToArray(Array, var)
endFunction

;/* IncreaseAnimation DEPRECATED!
* * (DEPRECATED) Use ResizeAnimationArray
*/;
sslBaseAnimation[] function IncreaseAnimation(int by, sslBaseAnimation[] Array) global
	return ResizeAnimationArray(Array, (Array.Length + by))
endFunction

;/* RemoveTaggedAnimations DEPRECATED!
* * (DEPRECATED) Use FilterTaggedAnimations
*/;
sslBaseAnimation[] function RemoveTaggedAnimations(sslBaseAnimation[] Anims, string[] Tags) global
	return FilterTaggedAnimations(Anims, Tags, false)
endFunction

;/* MergeAnimationLists DEPRECATED!
* * (DEPRECATED) Use MergeAnimationArray
*/;
sslBaseAnimation[] function MergeAnimationLists(sslBaseAnimation[] List1, sslBaseAnimation[] List2) global
	return MergeAnimationArray(List1, List2)
endFunction

;/* RemoveDupesFromList DEPRECATED!
* * (DEPRECATED) Use GetDiffAnimation
*/;
sslBaseAnimation[] function RemoveDupesFromList(sslBaseAnimation[] List, sslBaseAnimation[] Removing, bool PreventAll = true) global
	sslBaseAnimation[] Output = GetDiffAnimation(List, Removing, false, True)
	If PreventAll && Output.Length < 1
		return List
	EndIf
	return Output
endFunction

;/* EmptyAnimationArray DEPRECATED!
* * (DEPRECATED) Use AnimationArray
*/;
sslBaseAnimation[] function EmptyAnimationArray() global
	return AnimationArray(0)
endFunction

bool[] function BoolArray(int size) global
	; Debug.Trace("SEXLAB -- sslUtility.BoolArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return Utility.CreateBoolArray(size)
endFunction
float[] function FloatArray(int size) global
	; Debug.Trace("SEXLAB -- sslUtility.FloatArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return Utility.CreateFloatArray(size)
endFunction
int[] function IntArray(int size) global
	; Debug.Trace("-- sslUtility.IntArray SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return Utility.CreateIntArray(size)
endFunction
string[] function StringArray(int size) global
	; Debug.Trace("SEXLAB -- sslUtility.StringArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return Utility.CreateStringArray(size)
endFunction
Form[] function FormArray(int size) global
	; Debug.Trace("SEXLAB -- sslUtility.FormArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return Utility.CreateFormArray(size)
endFunction
Actor[] function ActorArray(int size) global
	; Debug.Trace("SEXLAB -- sslUtility.ActorArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.ActorArray(size)
endFunction


; string function MakeArgs(string delimiter, string arg1, string arg2 = "", string arg3 = "", string arg4 = "", string arg5 = "") global
	; Debug.Trace("SEXLAB -- sslUtility.MakeArgs -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
; 	return PapyrusUtil.MakeArgs(delimiter, arg1, arg2, arg3, arg4, arg5)
; endFunction

string[] function ArgString(string args, string delimiter = ",") global
	; Debug.Trace("SEXLAB -- sslUtility.ArgString -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.StringSplit(args, delimiter)
endFunction

Actor[] function PushActor(Actor var, Actor[] Array) global
	return PapyrusUtil.PushActor(Array, var)
endFunction

int function CountNone(form[] Array) global
	; Debug.Trace("-- sslUtility.CountNone SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.CountForm(Array, none)
endFunction
int function CountTrue(bool[] Array) global
	; Debug.Trace("-- sslUtility.CountTrue SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.CountBool(Array, true)
endFunction
int function CountEmpty(string[] Array) global
	; Debug.Trace("-- sslUtility.CountEmpty SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.CountString(Array, "")
endFunction

; function FormCopyTo(form[] Array, form[] Output, bool AllowNone) global
; 	; Debug.Trace("-- sslUtility.FormCopyTo SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
; 	PapyrusUtil.FormCopyTo(Array, Output, 0, -1, !AllowNone)
; endFunction
; function BoolCopyTo(bool[] Array, bool[] Output, int StartIndex = 0, int EndIndex = -1) global
; 	; Debug.Trace("-- sslUtility.BoolCopyTo SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
; 	PapyrusUtil.BoolCopyTo(Array, Output, StartIndex, Endindex)
; endFunction
; function StringCopyTo(string[] Array, string[] Output, int StartIndex = 0, int EndIndex = -1, bool AllowEmpty = true) global
; 	; Debug.Trace("-- sslUtility.StringCopyTo SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
; 	PapyrusUtil.StringCopyTo(Array, Output, StartIndex, Endindex, !AllowEmpty)
; endFunction
; function FloatCopyTo(float[] Array, float[] Output, int StartIndex = 0, int EndIndex = -1) global
; 	; Debug.Trace("-- sslUtility.FloatCopyTo SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
; 	PapyrusUtil.FloatCopyTo(Array, Output, StartIndex, Endindex)
; endFunction
; function IntCopyTo(int[] Array, int[] Output, int StartIndex = 0, int EndIndex = -1) global
	; Debug.Trace("SEXLAB -- sslUtility.IntCopyTo -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
; 	PapyrusUtil.IntCopyTo(Array, Output, StartIndex, Endindex)
; endFunction

int[] function SliceIntArray(int[] Array, int startindex = 0, int endindex = -1) global
	; Debug.Trace("SEXLAB -- sslUtility.SliceIntArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.SliceIntArray(Array, startindex, endindex)
endFunction

float function AddFloatValues(float[] Array) global
	; Debug.Trace("-- sslUtility.AddFloatValues SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.AddFloatValues(Array)
endFunction
int function AddIntValues(int[] Array) global
	; Debug.Trace("-- sslUtility.AddIntValues SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.AddIntValues(Array)
endFunction

int[] function IncreaseInt(int by, int[] Array) global
	; Debug.Trace("-- sslUtility.IncreaseInt SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.ResizeIntArray(Array, (Array.Length + by))
endFunction

int[] function TrimIntArray(int[] Array, int len) global
	; Debug.Trace("-- sslUtility.TrimIntArray SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.ResizeIntArray(Array, len)
endFunction

int[] function PushInt(int var, int[] Array) global
	; Debug.Trace("-- sslUtility.PushInt SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.PushInt(Array, var)
endFunction

int[] function MergeIntArray(int[] Push, int[] Array) global
	; Debug.Trace("-- sslUtility.MergeIntArray SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.MergeIntArray(Array, Push)
endFunction

int function ClampInt(int value, int min, int max) global
	; Debug.Trace("-- sslUtility.ClampInt SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.ClampInt(value, min, max)
endFunction

; int function SignInt(bool sign, int value) global
; 	; Debug.Trace("-- sslUtility.ignInt SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
; 	return PapyrusUtil.SignInt(sign, value)
; endFunction

int[] function EmptyIntArray() global
	; Debug.Trace("-- sslUtility.EmptyIntArray SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return Utility.CreateIntArray(0)
endFunction

int function WrapIndex(int index, int len) global
	; Debug.Trace("-- sslUtility.WrapIndex SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.WrapInt(index, len, 0)
endFunction

float[] function IncreaseFloat(int by, float[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.IncreaseFloat -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.ResizeFloatArray(Array, (Array.Length + by))
endFunction

float[] function TrimFloatArray(float[] Array, int len) global
	; Debug.Trace("SEXLAB -- sslUtility.TrimFloatArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.ResizeFloatArray(Array, len)
endFunction

float[] function PushFloat(float var, float[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.PushFloat -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.PushFloat(Array, var)
endFunction

float[] function MergeFloatArray(float[] Push, float[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.MergeFloatArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.MergeFloatArray(Array, Push)
endFunction

float function ClampFloat(float value, float min, float max) global
	; Debug.Trace("-- sslUtility.ClampFloat SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.ClampFloat(value, min, max)
endFunction

; float function SignFloat(bool sign, float value) global
; 	; Debug.Trace("-- sslUtility.SignFloat SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
; 	return PapyrusUtil.SignFloat(sign, value)
; endFunction

float[] function EmptyFloatArray() global
	; Debug.Trace("SEXLAB -- sslUtility.EmptyFloatArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return Utility.CreateFloatArray(0)
endFunction

string[] function IncreaseString(int by, string[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.IncreaseString -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.ResizeStringArray(Array, (Array.Length + by))
endFunction
string[] function TrimStringArray(string[] Array, int len) global
	; Debug.Trace("SEXLAB -- sslUtility.TrimStringArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.ResizeStringArray(Array, len)
endFunction
string[] function PushString(string var, string[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.PushString -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.PushString(Array, var)
endFunction
string[] function MergeStringArray(string[] Push, string[] Array) global
	return PapyrusUtil.MergeStringArray(Array, Push)
	; Debug.Trace("-- sslUtility.PapyrusUtil SEXLAB -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
endFunction
string[] function ClearEmpty(string[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.ClearEmpty -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.RemoveString(Array, "")
endFunction
string[] function EmptyStringArray() global
	; Debug.Trace("SEXLAB -- sslUtility.EmptyStringArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return Utility.CreateStringArray(0)
endFunction

bool[] function IncreaseBool(int by, bool[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.IncreaseBool -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.ResizeBoolArray(Array, (Array.Length + by))
endFunction

bool[] function TrimBoolArray(bool[] Array, int len) global
	; Debug.Trace("SEXLAB -- sslUtility.TrimBoolArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.ResizeBoolArray(Array, len)
endFunction

bool[] function PushBool(bool var, bool[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.PushBool -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.PushBool(Array, var)
endFunction

bool[] function MergeBoolArray(bool[] Push, bool[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.MergeBoolArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.MergeBoolArray(Array, Push)
endFunction

bool[] function EmptyBoolArray() global
	; Debug.Trace("SEXLAB -- sslUtility.EmptyBoolArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return Utility.CreateBoolArray(0)
endFunction

form[] function IncreaseForm(int by, form[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.IncreaseForm -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.ResizeFormArray(Array, (Array.Length + by))
endFunction

form[] function PushForm(form var, form[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.PushForm -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.PushForm(Array, var)
endFunction

form[] function MergeFormArray(form[] Push, form[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.MergeFormArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.MergeFormArray(Array, Push)
endFunction

Form[] function ClearNone(Form[] Array) global
	; Debug.Trace("SEXLAB -- sslUtility.ClearNone -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return PapyrusUtil.RemoveForm(Array, none)
endFunction

form[] function EmptyFormArray() global
	; Debug.Trace("SEXLAB -- sslUtility.EmptyFormArray -- DEVELOPMENT DEPRECATION, MOTHER FUCKER - Check PapyrusUtil.psc alternative.")
	return Utility.CreateFormArray(0)
endFunction

;/-----------------------------------------------\;
;|	SexLab Object Contstructors
;\-----------------------------------------------/;

sslBaseAnimation[] function AnimationArray(int size) global
	if size < 8
		if size <= 0
			sslBaseAnimation[] Empty
			return Empty
		elseIf size == 1
			return new sslBaseAnimation[1]
		elseIf size == 2
			return new sslBaseAnimation[2]
		elseIf size == 3
			return new sslBaseAnimation[3]
		elseIf size == 4
			return new sslBaseAnimation[4]
		elseIf size == 5
			return new sslBaseAnimation[5]
		elseIf size == 6
			return new sslBaseAnimation[6]
		else
			return new sslBaseAnimation[7]
		endIf
	elseIf size < 16
		if size == 8
			return new sslBaseAnimation[8]
		elseIf size == 9
			return new sslBaseAnimation[9]
		elseIf size == 10
			return new sslBaseAnimation[10]
		elseIf size == 11
			return new sslBaseAnimation[11]
		elseIf size == 12
			return new sslBaseAnimation[12]
		elseIf size == 13
			return new sslBaseAnimation[13]
		elseIf size == 14
			return new sslBaseAnimation[14]
		else
			return new sslBaseAnimation[15]
		endIf
	elseIf size < 24
		if size == 16
			return new sslBaseAnimation[16]
		elseIf size == 17
			return new sslBaseAnimation[17]
		elseIf size == 18
			return new sslBaseAnimation[18]
		elseIf size == 19
			return new sslBaseAnimation[19]
		elseIf size == 20
			return new sslBaseAnimation[20]
		elseIf size == 21
			return new sslBaseAnimation[21]
		elseIf size == 22
			return new sslBaseAnimation[22]
		else
			return new sslBaseAnimation[23]
		endIf
	elseIf size < 32
		if size == 24
			return new sslBaseAnimation[24]
		elseIf size == 25
			return new sslBaseAnimation[25]
		elseIf size == 26
			return new sslBaseAnimation[26]
		elseIf size == 27
			return new sslBaseAnimation[27]
		elseIf size == 28
			return new sslBaseAnimation[28]
		elseIf size == 29
			return new sslBaseAnimation[29]
		elseIf size == 30
			return new sslBaseAnimation[30]
		else
			return new sslBaseAnimation[31]
		endIf
	elseIf size < 40
		if size == 32
			return new sslBaseAnimation[32]
		elseIf size == 33
			return new sslBaseAnimation[33]
		elseIf size == 34
			return new sslBaseAnimation[34]
		elseIf size == 35
			return new sslBaseAnimation[35]
		elseIf size == 36
			return new sslBaseAnimation[36]
		elseIf size == 37
			return new sslBaseAnimation[37]
		elseIf size == 38
			return new sslBaseAnimation[38]
		else
			return new sslBaseAnimation[39]
		endIf
	elseIf size < 48
		if size == 40
			return new sslBaseAnimation[40]
		elseIf size == 41
			return new sslBaseAnimation[41]
		elseIf size == 42
			return new sslBaseAnimation[42]
		elseIf size == 43
			return new sslBaseAnimation[43]
		elseIf size == 44
			return new sslBaseAnimation[44]
		elseIf size == 45
			return new sslBaseAnimation[45]
		elseIf size == 46
			return new sslBaseAnimation[46]
		else
			return new sslBaseAnimation[47]
		endIf
	elseIf size < 56
		if size == 48
			return new sslBaseAnimation[48]
		elseIf size == 49
			return new sslBaseAnimation[49]
		elseIf size == 50
			return new sslBaseAnimation[50]
		elseIf size == 51
			return new sslBaseAnimation[51]
		elseIf size == 52
			return new sslBaseAnimation[52]
		elseIf size == 53
			return new sslBaseAnimation[53]
		elseIf size == 54
			return new sslBaseAnimation[54]
		else
			return new sslBaseAnimation[55]
		endif
	elseIf size < 64
		if size == 56
			return new sslBaseAnimation[56]
		elseIf size == 57
			return new sslBaseAnimation[57]
		elseIf size == 58
			return new sslBaseAnimation[58]
		elseIf size == 59
			return new sslBaseAnimation[59]
		elseIf size == 60
			return new sslBaseAnimation[60]
		elseIf size == 61
			return new sslBaseAnimation[61]
		elseIf size == 62
			return new sslBaseAnimation[62]
		else
			return new sslBaseAnimation[63]
		endIf
	elseIf size < 72
		if size == 64
			return new sslBaseAnimation[64]
		elseIf size == 65
			return new sslBaseAnimation[65]
		elseIf size == 66
			return new sslBaseAnimation[66]
		elseIf size == 67
			return new sslBaseAnimation[67]
		elseIf size == 68
			return new sslBaseAnimation[68]
		elseIf size == 69
			return new sslBaseAnimation[69]
		elseIf size == 70
			return new sslBaseAnimation[70]
		else
			return new sslBaseAnimation[71]
		endif
	elseIf size < 80
		if size == 72
			return new sslBaseAnimation[72]
		elseIf size == 73
			return new sslBaseAnimation[73]
		elseIf size == 74
			return new sslBaseAnimation[74]
		elseIf size == 75
			return new sslBaseAnimation[75]
		elseIf size == 76
			return new sslBaseAnimation[76]
		elseIf size == 77
			return new sslBaseAnimation[77]
		elseIf size == 78
			return new sslBaseAnimation[78]
		else
			return new sslBaseAnimation[79]
		endIf
	elseIf size < 88
		if size == 80
			return new sslBaseAnimation[80]
		elseIf size == 81
			return new sslBaseAnimation[81]
		elseIf size == 82
			return new sslBaseAnimation[82]
		elseIf size == 83
			return new sslBaseAnimation[83]
		elseIf size == 84
			return new sslBaseAnimation[84]
		elseIf size == 85
			return new sslBaseAnimation[85]
		elseIf size == 86
			return new sslBaseAnimation[86]
		else
			return new sslBaseAnimation[87]
		endif
	elseIf size < 96
		if size == 88
			return new sslBaseAnimation[88]
		elseIf size == 89
			return new sslBaseAnimation[89]
		elseIf size == 90
			return new sslBaseAnimation[90]
		elseIf size == 91
			return new sslBaseAnimation[91]
		elseIf size == 92
			return new sslBaseAnimation[92]
		elseIf size == 93
			return new sslBaseAnimation[93]
		elseIf size == 94
			return new sslBaseAnimation[94]
		else
			return new sslBaseAnimation[95]
		endIf
	elseIf size < 104
		if size == 96
			return new sslBaseAnimation[96]
		elseIf size == 97
			return new sslBaseAnimation[97]
		elseIf size == 98
			return new sslBaseAnimation[98]
		elseIf size == 99
			return new sslBaseAnimation[99]
		elseIf size == 100
			return new sslBaseAnimation[100]
		elseIf size == 101
			return new sslBaseAnimation[101]
		elseIf size == 102
			return new sslBaseAnimation[102]
		else
			return new sslBaseAnimation[103]
		endif
	elseIf size < 112
		if size == 104
			return new sslBaseAnimation[104]
		elseIf size == 105
			return new sslBaseAnimation[105]
		elseIf size == 106
			return new sslBaseAnimation[106]
		elseIf size == 107
			return new sslBaseAnimation[107]
		elseIf size == 108
			return new sslBaseAnimation[108]
		elseIf size == 109
			return new sslBaseAnimation[109]
		elseIf size == 110
			return new sslBaseAnimation[110]
		else
			return new sslBaseAnimation[111]
		endif
	elseIf size < 120
		if size == 112
			return new sslBaseAnimation[112]
		elseIf size == 113
			return new sslBaseAnimation[113]
		elseIf size == 114
			return new sslBaseAnimation[114]
		elseIf size == 115
			return new sslBaseAnimation[115]
		elseIf size == 116
			return new sslBaseAnimation[116]
		elseIf size == 117
			return new sslBaseAnimation[117]
		elseIf size == 118
			return new sslBaseAnimation[118]
		else
			return new sslBaseAnimation[119]
		endif
	else
		if size == 120
			return new sslBaseAnimation[120]
		elseIf size == 121
			return new sslBaseAnimation[121]
		elseIf size == 122
			return new sslBaseAnimation[122]
		elseIf size == 123
			return new sslBaseAnimation[123]
		elseIf size == 124
			return new sslBaseAnimation[124]
		elseIf size == 125
			return new sslBaseAnimation[125]
		elseIf size == 126
			return new sslBaseAnimation[126]
		elseIf size == 127
			return new sslBaseAnimation[127]
		else
			return new sslBaseAnimation[128]
		endIf
	endIf
endFunction
sslBaseVoice[] function VoiceArray(int size) global
	if size < 8
		if size <= 0
			sslBaseVoice[] Empty
			return Empty
		elseIf size == 1
			return new sslBaseVoice[1]
		elseIf size == 2
			return new sslBaseVoice[2]
		elseIf size == 3
			return new sslBaseVoice[3]
		elseIf size == 4
			return new sslBaseVoice[4]
		elseIf size == 5
			return new sslBaseVoice[5]
		elseIf size == 6
			return new sslBaseVoice[6]
		else
			return new sslBaseVoice[7]
		endIf
	elseIf size < 16
		if size == 8
			return new sslBaseVoice[8]
		elseIf size == 9
			return new sslBaseVoice[9]
		elseIf size == 10
			return new sslBaseVoice[10]
		elseIf size == 11
			return new sslBaseVoice[11]
		elseIf size == 12
			return new sslBaseVoice[12]
		elseIf size == 13
			return new sslBaseVoice[13]
		elseIf size == 14
			return new sslBaseVoice[14]
		else
			return new sslBaseVoice[15]
		endIf
	elseIf size < 24
		if size == 16
			return new sslBaseVoice[16]
		elseIf size == 17
			return new sslBaseVoice[17]
		elseIf size == 18
			return new sslBaseVoice[18]
		elseIf size == 19
			return new sslBaseVoice[19]
		elseIf size == 20
			return new sslBaseVoice[20]
		elseIf size == 21
			return new sslBaseVoice[21]
		elseIf size == 22
			return new sslBaseVoice[22]
		else
			return new sslBaseVoice[23]
		endIf
	elseIf size < 32
		if size == 24
			return new sslBaseVoice[24]
		elseIf size == 25
			return new sslBaseVoice[25]
		elseIf size == 26
			return new sslBaseVoice[26]
		elseIf size == 27
			return new sslBaseVoice[27]
		elseIf size == 28
			return new sslBaseVoice[28]
		elseIf size == 29
			return new sslBaseVoice[29]
		elseIf size == 30
			return new sslBaseVoice[30]
		else
			return new sslBaseVoice[31]
		endIf
	elseIf size < 40
		if size == 32
			return new sslBaseVoice[32]
		elseIf size == 33
			return new sslBaseVoice[33]
		elseIf size == 34
			return new sslBaseVoice[34]
		elseIf size == 35
			return new sslBaseVoice[35]
		elseIf size == 36
			return new sslBaseVoice[36]
		elseIf size == 37
			return new sslBaseVoice[37]
		elseIf size == 38
			return new sslBaseVoice[38]
		else
			return new sslBaseVoice[39]
		endIf
	elseIf size < 48
		if size == 40
			return new sslBaseVoice[40]
		elseIf size == 41
			return new sslBaseVoice[41]
		elseIf size == 42
			return new sslBaseVoice[42]
		elseIf size == 43
			return new sslBaseVoice[43]
		elseIf size == 44
			return new sslBaseVoice[44]
		elseIf size == 45
			return new sslBaseVoice[45]
		elseIf size == 46
			return new sslBaseVoice[46]
		else
			return new sslBaseVoice[47]
		endIf
	elseIf size < 56
		if size == 48
			return new sslBaseVoice[48]
		elseIf size == 49
			return new sslBaseVoice[49]
		elseIf size == 50
			return new sslBaseVoice[50]
		elseIf size == 51
			return new sslBaseVoice[51]
		elseIf size == 52
			return new sslBaseVoice[52]
		elseIf size == 53
			return new sslBaseVoice[53]
		elseIf size == 54
			return new sslBaseVoice[54]
		else
			return new sslBaseVoice[55]
		endif
	elseIf size < 64
		if size == 56
			return new sslBaseVoice[56]
		elseIf size == 57
			return new sslBaseVoice[57]
		elseIf size == 58
			return new sslBaseVoice[58]
		elseIf size == 59
			return new sslBaseVoice[59]
		elseIf size == 60
			return new sslBaseVoice[60]
		elseIf size == 61
			return new sslBaseVoice[61]
		elseIf size == 62
			return new sslBaseVoice[62]
		else
			return new sslBaseVoice[63]
		endIf
	elseIf size < 72
		if size == 64
			return new sslBaseVoice[64]
		elseIf size == 65
			return new sslBaseVoice[65]
		elseIf size == 66
			return new sslBaseVoice[66]
		elseIf size == 67
			return new sslBaseVoice[67]
		elseIf size == 68
			return new sslBaseVoice[68]
		elseIf size == 69
			return new sslBaseVoice[69]
		elseIf size == 70
			return new sslBaseVoice[70]
		else
			return new sslBaseVoice[71]
		endif
	elseIf size < 80
		if size == 72
			return new sslBaseVoice[72]
		elseIf size == 73
			return new sslBaseVoice[73]
		elseIf size == 74
			return new sslBaseVoice[74]
		elseIf size == 75
			return new sslBaseVoice[75]
		elseIf size == 76
			return new sslBaseVoice[76]
		elseIf size == 77
			return new sslBaseVoice[77]
		elseIf size == 78
			return new sslBaseVoice[78]
		else
			return new sslBaseVoice[79]
		endIf
	elseIf size < 88
		if size == 80
			return new sslBaseVoice[80]
		elseIf size == 81
			return new sslBaseVoice[81]
		elseIf size == 82
			return new sslBaseVoice[82]
		elseIf size == 83
			return new sslBaseVoice[83]
		elseIf size == 84
			return new sslBaseVoice[84]
		elseIf size == 85
			return new sslBaseVoice[85]
		elseIf size == 86
			return new sslBaseVoice[86]
		else
			return new sslBaseVoice[87]
		endif
	elseIf size < 96
		if size == 88
			return new sslBaseVoice[88]
		elseIf size == 89
			return new sslBaseVoice[89]
		elseIf size == 90
			return new sslBaseVoice[90]
		elseIf size == 91
			return new sslBaseVoice[91]
		elseIf size == 92
			return new sslBaseVoice[92]
		elseIf size == 93
			return new sslBaseVoice[93]
		elseIf size == 94
			return new sslBaseVoice[94]
		else
			return new sslBaseVoice[95]
		endIf
	elseIf size < 104
		if size == 96
			return new sslBaseVoice[96]
		elseIf size == 97
			return new sslBaseVoice[97]
		elseIf size == 98
			return new sslBaseVoice[98]
		elseIf size == 99
			return new sslBaseVoice[99]
		elseIf size == 100
			return new sslBaseVoice[100]
		elseIf size == 101
			return new sslBaseVoice[101]
		elseIf size == 102
			return new sslBaseVoice[102]
		else
			return new sslBaseVoice[103]
		endif
	elseIf size < 112
		if size == 104
			return new sslBaseVoice[104]
		elseIf size == 105
			return new sslBaseVoice[105]
		elseIf size == 106
			return new sslBaseVoice[106]
		elseIf size == 107
			return new sslBaseVoice[107]
		elseIf size == 108
			return new sslBaseVoice[108]
		elseIf size == 109
			return new sslBaseVoice[109]
		elseIf size == 110
			return new sslBaseVoice[110]
		else
			return new sslBaseVoice[111]
		endif
	elseIf size < 120
		if size == 112
			return new sslBaseVoice[112]
		elseIf size == 113
			return new sslBaseVoice[113]
		elseIf size == 114
			return new sslBaseVoice[114]
		elseIf size == 115
			return new sslBaseVoice[115]
		elseIf size == 116
			return new sslBaseVoice[116]
		elseIf size == 117
			return new sslBaseVoice[117]
		elseIf size == 118
			return new sslBaseVoice[118]
		else
			return new sslBaseVoice[119]
		endif
	else
		if size == 120
			return new sslBaseVoice[120]
		elseIf size == 121
			return new sslBaseVoice[121]
		elseIf size == 122
			return new sslBaseVoice[122]
		elseIf size == 123
			return new sslBaseVoice[123]
		elseIf size == 124
			return new sslBaseVoice[124]
		elseIf size == 125
			return new sslBaseVoice[125]
		elseIf size == 126
			return new sslBaseVoice[126]
		elseIf size == 127
			return new sslBaseVoice[127]
		else
			return new sslBaseVoice[128]
		endIf
	endIf
endFunction
sslBaseExpression[] function ExpressionArray(int size) global
	if size < 8
		if size <= 0
			sslBaseExpression[] Empty
			return Empty
		elseIf size == 1
			return new sslBaseExpression[1]
		elseIf size == 2
			return new sslBaseExpression[2]
		elseIf size == 3
			return new sslBaseExpression[3]
		elseIf size == 4
			return new sslBaseExpression[4]
		elseIf size == 5
			return new sslBaseExpression[5]
		elseIf size == 6
			return new sslBaseExpression[6]
		else
			return new sslBaseExpression[7]
		endIf
	elseIf size < 16
		if size == 8
			return new sslBaseExpression[8]
		elseIf size == 9
			return new sslBaseExpression[9]
		elseIf size == 10
			return new sslBaseExpression[10]
		elseIf size == 11
			return new sslBaseExpression[11]
		elseIf size == 12
			return new sslBaseExpression[12]
		elseIf size == 13
			return new sslBaseExpression[13]
		elseIf size == 14
			return new sslBaseExpression[14]
		else
			return new sslBaseExpression[15]
		endIf
	elseIf size < 24
		if size == 16
			return new sslBaseExpression[16]
		elseIf size == 17
			return new sslBaseExpression[17]
		elseIf size == 18
			return new sslBaseExpression[18]
		elseIf size == 19
			return new sslBaseExpression[19]
		elseIf size == 20
			return new sslBaseExpression[20]
		elseIf size == 21
			return new sslBaseExpression[21]
		elseIf size == 22
			return new sslBaseExpression[22]
		else
			return new sslBaseExpression[23]
		endIf
	elseIf size < 32
		if size == 24
			return new sslBaseExpression[24]
		elseIf size == 25
			return new sslBaseExpression[25]
		elseIf size == 26
			return new sslBaseExpression[26]
		elseIf size == 27
			return new sslBaseExpression[27]
		elseIf size == 28
			return new sslBaseExpression[28]
		elseIf size == 29
			return new sslBaseExpression[29]
		elseIf size == 30
			return new sslBaseExpression[30]
		else
			return new sslBaseExpression[31]
		endIf
	elseIf size < 40
		if size == 32
			return new sslBaseExpression[32]
		elseIf size == 33
			return new sslBaseExpression[33]
		elseIf size == 34
			return new sslBaseExpression[34]
		elseIf size == 35
			return new sslBaseExpression[35]
		elseIf size == 36
			return new sslBaseExpression[36]
		elseIf size == 37
			return new sslBaseExpression[37]
		elseIf size == 38
			return new sslBaseExpression[38]
		else
			return new sslBaseExpression[39]
		endIf
	elseIf size < 48
		if size == 40
			return new sslBaseExpression[40]
		elseIf size == 41
			return new sslBaseExpression[41]
		elseIf size == 42
			return new sslBaseExpression[42]
		elseIf size == 43
			return new sslBaseExpression[43]
		elseIf size == 44
			return new sslBaseExpression[44]
		elseIf size == 45
			return new sslBaseExpression[45]
		elseIf size == 46
			return new sslBaseExpression[46]
		else
			return new sslBaseExpression[47]
		endIf
	elseIf size < 56
		if size == 48
			return new sslBaseExpression[48]
		elseIf size == 49
			return new sslBaseExpression[49]
		elseIf size == 50
			return new sslBaseExpression[50]
		elseIf size == 51
			return new sslBaseExpression[51]
		elseIf size == 52
			return new sslBaseExpression[52]
		elseIf size == 53
			return new sslBaseExpression[53]
		elseIf size == 54
			return new sslBaseExpression[54]
		else
			return new sslBaseExpression[55]
		endif
	elseIf size < 64
		if size == 56
			return new sslBaseExpression[56]
		elseIf size == 57
			return new sslBaseExpression[57]
		elseIf size == 58
			return new sslBaseExpression[58]
		elseIf size == 59
			return new sslBaseExpression[59]
		elseIf size == 60
			return new sslBaseExpression[60]
		elseIf size == 61
			return new sslBaseExpression[61]
		elseIf size == 62
			return new sslBaseExpression[62]
		else
			return new sslBaseExpression[63]
		endIf
	elseIf size < 72
		if size == 64
			return new sslBaseExpression[64]
		elseIf size == 65
			return new sslBaseExpression[65]
		elseIf size == 66
			return new sslBaseExpression[66]
		elseIf size == 67
			return new sslBaseExpression[67]
		elseIf size == 68
			return new sslBaseExpression[68]
		elseIf size == 69
			return new sslBaseExpression[69]
		elseIf size == 70
			return new sslBaseExpression[70]
		else
			return new sslBaseExpression[71]
		endif
	elseIf size < 80
		if size == 72
			return new sslBaseExpression[72]
		elseIf size == 73
			return new sslBaseExpression[73]
		elseIf size == 74
			return new sslBaseExpression[74]
		elseIf size == 75
			return new sslBaseExpression[75]
		elseIf size == 76
			return new sslBaseExpression[76]
		elseIf size == 77
			return new sslBaseExpression[77]
		elseIf size == 78
			return new sslBaseExpression[78]
		else
			return new sslBaseExpression[79]
		endIf
	elseIf size < 88
		if size == 80
			return new sslBaseExpression[80]
		elseIf size == 81
			return new sslBaseExpression[81]
		elseIf size == 82
			return new sslBaseExpression[82]
		elseIf size == 83
			return new sslBaseExpression[83]
		elseIf size == 84
			return new sslBaseExpression[84]
		elseIf size == 85
			return new sslBaseExpression[85]
		elseIf size == 86
			return new sslBaseExpression[86]
		else
			return new sslBaseExpression[87]
		endif
	elseIf size < 96
		if size == 88
			return new sslBaseExpression[88]
		elseIf size == 89
			return new sslBaseExpression[89]
		elseIf size == 90
			return new sslBaseExpression[90]
		elseIf size == 91
			return new sslBaseExpression[91]
		elseIf size == 92
			return new sslBaseExpression[92]
		elseIf size == 93
			return new sslBaseExpression[93]
		elseIf size == 94
			return new sslBaseExpression[94]
		else
			return new sslBaseExpression[95]
		endIf
	elseIf size < 104
		if size == 96
			return new sslBaseExpression[96]
		elseIf size == 97
			return new sslBaseExpression[97]
		elseIf size == 98
			return new sslBaseExpression[98]
		elseIf size == 99
			return new sslBaseExpression[99]
		elseIf size == 100
			return new sslBaseExpression[100]
		elseIf size == 101
			return new sslBaseExpression[101]
		elseIf size == 102
			return new sslBaseExpression[102]
		else
			return new sslBaseExpression[103]
		endif
	elseIf size < 112
		if size == 104
			return new sslBaseExpression[104]
		elseIf size == 105
			return new sslBaseExpression[105]
		elseIf size == 106
			return new sslBaseExpression[106]
		elseIf size == 107
			return new sslBaseExpression[107]
		elseIf size == 108
			return new sslBaseExpression[108]
		elseIf size == 109
			return new sslBaseExpression[109]
		elseIf size == 110
			return new sslBaseExpression[110]
		else
			return new sslBaseExpression[111]
		endif
	elseIf size < 120
		if size == 112
			return new sslBaseExpression[112]
		elseIf size == 113
			return new sslBaseExpression[113]
		elseIf size == 114
			return new sslBaseExpression[114]
		elseIf size == 115
			return new sslBaseExpression[115]
		elseIf size == 116
			return new sslBaseExpression[116]
		elseIf size == 117
			return new sslBaseExpression[117]
		elseIf size == 118
			return new sslBaseExpression[118]
		else
			return new sslBaseExpression[119]
		endif
	else
		if size == 120
			return new sslBaseExpression[120]
		elseIf size == 121
			return new sslBaseExpression[121]
		elseIf size == 122
			return new sslBaseExpression[122]
		elseIf size == 123
			return new sslBaseExpression[123]
		elseIf size == 124
			return new sslBaseExpression[124]
		elseIf size == 125
			return new sslBaseExpression[125]
		elseIf size == 126
			return new sslBaseExpression[126]
		elseIf size == 127
			return new sslBaseExpression[127]
		else
			return new sslBaseExpression[128]
		endIf
	endIf
endFunction
sslBaseObject[] function BaseObjectArray(int size) global
	if size < 8
		if size <= 0
			sslBaseObject[] Empty
			return Empty
		elseIf size == 1
			return new sslBaseObject[1]
		elseIf size == 2
			return new sslBaseObject[2]
		elseIf size == 3
			return new sslBaseObject[3]
		elseIf size == 4
			return new sslBaseObject[4]
		elseIf size == 5
			return new sslBaseObject[5]
		elseIf size == 6
			return new sslBaseObject[6]
		else
			return new sslBaseObject[7]
		endIf
	elseIf size < 16
		if size == 8
			return new sslBaseObject[8]
		elseIf size == 9
			return new sslBaseObject[9]
		elseIf size == 10
			return new sslBaseObject[10]
		elseIf size == 11
			return new sslBaseObject[11]
		elseIf size == 12
			return new sslBaseObject[12]
		elseIf size == 13
			return new sslBaseObject[13]
		elseIf size == 14
			return new sslBaseObject[14]
		else
			return new sslBaseObject[15]
		endIf
	elseIf size < 24
		if size == 16
			return new sslBaseObject[16]
		elseIf size == 17
			return new sslBaseObject[17]
		elseIf size == 18
			return new sslBaseObject[18]
		elseIf size == 19
			return new sslBaseObject[19]
		elseIf size == 20
			return new sslBaseObject[20]
		elseIf size == 21
			return new sslBaseObject[21]
		elseIf size == 22
			return new sslBaseObject[22]
		else
			return new sslBaseObject[23]
		endIf
	elseIf size < 32
		if size == 24
			return new sslBaseObject[24]
		elseIf size == 25
			return new sslBaseObject[25]
		elseIf size == 26
			return new sslBaseObject[26]
		elseIf size == 27
			return new sslBaseObject[27]
		elseIf size == 28
			return new sslBaseObject[28]
		elseIf size == 29
			return new sslBaseObject[29]
		elseIf size == 30
			return new sslBaseObject[30]
		else
			return new sslBaseObject[31]
		endIf
	elseIf size < 40
		if size == 32
			return new sslBaseObject[32]
		elseIf size == 33
			return new sslBaseObject[33]
		elseIf size == 34
			return new sslBaseObject[34]
		elseIf size == 35
			return new sslBaseObject[35]
		elseIf size == 36
			return new sslBaseObject[36]
		elseIf size == 37
			return new sslBaseObject[37]
		elseIf size == 38
			return new sslBaseObject[38]
		else
			return new sslBaseObject[39]
		endIf
	elseIf size < 48
		if size == 40
			return new sslBaseObject[40]
		elseIf size == 41
			return new sslBaseObject[41]
		elseIf size == 42
			return new sslBaseObject[42]
		elseIf size == 43
			return new sslBaseObject[43]
		elseIf size == 44
			return new sslBaseObject[44]
		elseIf size == 45
			return new sslBaseObject[45]
		elseIf size == 46
			return new sslBaseObject[46]
		else
			return new sslBaseObject[47]
		endIf
	elseIf size < 56
		if size == 48
			return new sslBaseObject[48]
		elseIf size == 49
			return new sslBaseObject[49]
		elseIf size == 50
			return new sslBaseObject[50]
		elseIf size == 51
			return new sslBaseObject[51]
		elseIf size == 52
			return new sslBaseObject[52]
		elseIf size == 53
			return new sslBaseObject[53]
		elseIf size == 54
			return new sslBaseObject[54]
		else
			return new sslBaseObject[55]
		endif
	elseIf size < 64
		if size == 56
			return new sslBaseObject[56]
		elseIf size == 57
			return new sslBaseObject[57]
		elseIf size == 58
			return new sslBaseObject[58]
		elseIf size == 59
			return new sslBaseObject[59]
		elseIf size == 60
			return new sslBaseObject[60]
		elseIf size == 61
			return new sslBaseObject[61]
		elseIf size == 62
			return new sslBaseObject[62]
		else
			return new sslBaseObject[63]
		endIf
	elseIf size < 72
		if size == 64
			return new sslBaseObject[64]
		elseIf size == 65
			return new sslBaseObject[65]
		elseIf size == 66
			return new sslBaseObject[66]
		elseIf size == 67
			return new sslBaseObject[67]
		elseIf size == 68
			return new sslBaseObject[68]
		elseIf size == 69
			return new sslBaseObject[69]
		elseIf size == 70
			return new sslBaseObject[70]
		else
			return new sslBaseObject[71]
		endif
	elseIf size < 80
		if size == 72
			return new sslBaseObject[72]
		elseIf size == 73
			return new sslBaseObject[73]
		elseIf size == 74
			return new sslBaseObject[74]
		elseIf size == 75
			return new sslBaseObject[75]
		elseIf size == 76
			return new sslBaseObject[76]
		elseIf size == 77
			return new sslBaseObject[77]
		elseIf size == 78
			return new sslBaseObject[78]
		else
			return new sslBaseObject[79]
		endIf
	elseIf size < 88
		if size == 80
			return new sslBaseObject[80]
		elseIf size == 81
			return new sslBaseObject[81]
		elseIf size == 82
			return new sslBaseObject[82]
		elseIf size == 83
			return new sslBaseObject[83]
		elseIf size == 84
			return new sslBaseObject[84]
		elseIf size == 85
			return new sslBaseObject[85]
		elseIf size == 86
			return new sslBaseObject[86]
		else
			return new sslBaseObject[87]
		endif
	elseIf size < 96
		if size == 88
			return new sslBaseObject[88]
		elseIf size == 89
			return new sslBaseObject[89]
		elseIf size == 90
			return new sslBaseObject[90]
		elseIf size == 91
			return new sslBaseObject[91]
		elseIf size == 92
			return new sslBaseObject[92]
		elseIf size == 93
			return new sslBaseObject[93]
		elseIf size == 94
			return new sslBaseObject[94]
		else
			return new sslBaseObject[95]
		endIf
	elseIf size < 104
		if size == 96
			return new sslBaseObject[96]
		elseIf size == 97
			return new sslBaseObject[97]
		elseIf size == 98
			return new sslBaseObject[98]
		elseIf size == 99
			return new sslBaseObject[99]
		elseIf size == 100
			return new sslBaseObject[100]
		elseIf size == 101
			return new sslBaseObject[101]
		elseIf size == 102
			return new sslBaseObject[102]
		else
			return new sslBaseObject[103]
		endif
	elseIf size < 112
		if size == 104
			return new sslBaseObject[104]
		elseIf size == 105
			return new sslBaseObject[105]
		elseIf size == 106
			return new sslBaseObject[106]
		elseIf size == 107
			return new sslBaseObject[107]
		elseIf size == 108
			return new sslBaseObject[108]
		elseIf size == 109
			return new sslBaseObject[109]
		elseIf size == 110
			return new sslBaseObject[110]
		else
			return new sslBaseObject[111]
		endif
	elseIf size < 120
		if size == 112
			return new sslBaseObject[112]
		elseIf size == 113
			return new sslBaseObject[113]
		elseIf size == 114
			return new sslBaseObject[114]
		elseIf size == 115
			return new sslBaseObject[115]
		elseIf size == 116
			return new sslBaseObject[116]
		elseIf size == 117
			return new sslBaseObject[117]
		elseIf size == 118
			return new sslBaseObject[118]
		else
			return new sslBaseObject[119]
		endif
	else
		if size == 120
			return new sslBaseObject[120]
		elseIf size == 121
			return new sslBaseObject[121]
		elseIf size == 122
			return new sslBaseObject[122]
		elseIf size == 123
			return new sslBaseObject[123]
		elseIf size == 124
			return new sslBaseObject[124]
		elseIf size == 125
			return new sslBaseObject[125]
		elseIf size == 126
			return new sslBaseObject[126]
		elseIf size == 127
			return new sslBaseObject[127]
		else
			return new sslBaseObject[128]
		endIf
	endIf
endFunction


; ;/-----------------------------------------------\;
; ;|	Animation Utility Functions
; ;\-----------------------------------------------/;

; function AnimationCopyTo(sslBaseAnimation[] SourceArray, sslBaseAnimation[] ToArray, int StartIndex = 0, int EndIndex = -1, bool SkipEmpty = false) global native
; int function CountAnimation(sslBaseAnimation[] Values, sslBaseAnimation EqualTo = none) global native

sslBaseAnimation[] function ResizeAnimationArray(sslBaseAnimation[] ArrayValues, int ToSize, sslBaseAnimation Filler = none) global
	if ToSize == ArrayValues.Length
		return ArrayValues
	elseIf ToSize < 1
		return AnimationArray(0)
	elseIf ToSize > 128
		ToSize = 128
	endIf
	sslBaseAnimation[] Output = AnimationArray(ToSize)
	;  AnimationCopyTo(ArrayValues, Output)
	If ToSize > ArrayValues.Length
		ToSize = ArrayValues.Length
	EndIf
	while ToSize
		ToSize -= 1
		If ToSize > ArrayValues.Length
			Output[ToSize] = Filler
		Else
			Output[ToSize] = ArrayValues[ToSize]
		EndIf
	endWhile
	return Output
endFunction

sslBaseAnimation[] function PushAnimationToArray(sslBaseAnimation[] ArrayValues, sslBaseAnimation ToPush) global
	int len = ArrayValues.Length
	if len >= 128
		return ArrayValues
	endIf
	sslBaseAnimation[] Pushed = AnimationArray(len+1)
; 	AnimationCopyTo(ArrayValues, Pushed)
	Pushed[len] = ToPush
	while len
		len -=1
		Pushed[len] = ArrayValues[len]
	endWhile
	return Pushed
endFunction

sslBaseAnimation[] function RemoveAnimationFromArray(sslBaseAnimation[] ArrayValues, sslBaseAnimation ToRemove) global
	if !ArrayValues
		return AnimationArray(0)
	ElseIf ArrayValues.Find(ToRemove) == -1
		return ArrayValues
	;	return CopyAnimationArray(ArrayValues)
	endIf
	sslBaseAnimation[] Output = AnimationArray(ArrayValues.Length)
	int i = 0
	int n = 0
	while i < ArrayValues.Length && n < Output.Length
		If ArrayValues[i] != ToRemove
			Output[n] = ArrayValues[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return ResizeAnimationArray(Output, n)
	EndIf
	return Output
endFunction

; ## Removes all duplicate elements from the given array and returns the shortened array with only a single instance of all element values.
sslBaseAnimation[] function RemoveDupeAnimation(sslBaseAnimation[] ArrayValues) global
	sslBaseAnimation[] Output = AnimationArray(ArrayValues.Length)
	int n = 0
	int i = 0
	while i < ArrayValues.Length && n < Output.Length
		If Output.Find(ArrayValues[i]) == -1 ; Also remove None
			Output[n] = ArrayValues[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return ResizeAnimationArray(Output, n)
	EndIf
	return Output
endFunction

sslBaseAnimation[] function GetDiffAnimation(sslBaseAnimation[] ArrayValues1, sslBaseAnimation[] ArrayValues2, bool CompareBoth = false, bool IncludeDupes = false) global
	sslBaseAnimation[] output
	if !ArrayValues1 && !ArrayValues2
		Return output
	elseIf !ArrayValues1
		If CompareBoth
			If !IncludeDupes
				Return RemoveDupeAnimation(ArrayValues2)
			Else
				Return ArrayValues2
			;	return CopyAnimationArray(ArrayValues2)
			endIf
		Else
			Return output
		endIf
	elseIf !ArrayValues2
		If !IncludeDupes
			Return RemoveDupeAnimation(ArrayValues1)
		Else
			Return ArrayValues1
		;	return CopyAnimationArray(ArrayValues1)
		endIf
	endIf
	Output = AnimationArray(ArrayValues1.Length + (CompareBoth as int * ArrayValues2.Length))
	int n = 0
	int i = 0
	While i < ArrayValues1.Length && n < Output.Length ; the ArrayValues1.Length can change while this function is executed and the output is limited anyway.
		if (ArrayValues2.Find(ArrayValues1[i]) == -1) && (IncludeDupes || output.Find(ArrayValues2[i]) == -1)
			output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	EndWhile

	if (CompareBoth) ; Will merge both arrays
		i = 0
		While i < ArrayValues2.Length && n < Output.Length ; the ArrayValues1.Length can change while this function is executed and the output is limited anyway.
			if (ArrayValues1.Find(ArrayValues2[i]) == -1) && (IncludeDupes || output.Find(ArrayValues1[i]) == -1)
				output[n] = ArrayValues2[i]
				n += 1
			EndIf
			i += 1
		EndWhile
	endIf
	If n < Output.Length
		return ResizeAnimationArray(Output, n)
	EndIf
	Return Output
endFunction

; ## Get an array of values that are present in both ArrayValues1 and ArrayValues2.
sslBaseAnimation[] function GetMatchingAnimation(sslBaseAnimation[] ArrayValues1, sslBaseAnimation[] ArrayValues2) global
	sslBaseAnimation[] Output
	if !ArrayValues1 || !ArrayValues2
		Return Output
	endIf
	int n = 0
	int i = 0
	Output = AnimationArray(ArrayValues1.Length)
	while i < ArrayValues1.Length && n < Output.Length ; In theory the ArrayValues1.Length can change while this function is executed.
		If ArrayValues2.Find(ArrayValues1[i]) != -1 && output.Find(ArrayValues1[i]) == -1 ; Also remove Dupes and None
			output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	EndWhile
	If n < Output.Length
		return ResizeAnimationArray(Output, n)
	EndIf
	return Output
endFunction

; ## Returns two arrays combined into one, optionally also removing any duplicate occurrences of a value.
sslBaseAnimation[] function MergeAnimationArray(sslBaseAnimation[] ArrayValues1, sslBaseAnimation[] ArrayValues2, bool RemoveDupes = false) global
	if !ArrayValues1 && !ArrayValues2
		return AnimationArray(0)
	elseIf !RemoveDupes && !ArrayValues1
		return ArrayValues2
	;	return CopyAnimationArray(ArrayValues2)
	elseIf !RemoveDupes && !ArrayValues2
		return ArrayValues1
	;	return CopyAnimationArray(ArrayValues1)
	endIf
	sslBaseAnimation[] Output = AnimationArray(ArrayValues1.Length + ArrayValues2.Length)
	int n = 0
	int i = 0
	while i < ArrayValues1.Length && n < Output.Length
		If !RemoveDupes || Output.Find(ArrayValues1[i]) == -1 ; Also remove None
			Output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	endWhile
	i = 0
	while i < ArrayValues2.Length && n < Output.Length
		If !RemoveDupes || Output.Find(ArrayValues2[i]) == -1 ; Also remove None
			Output[n] = ArrayValues2[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return ResizeAnimationArray(Output, n)
	EndIf
	return Output
endFunction

; ## Returns a sub section of an array indicated by a starting and ending index.
; ## The default argument "int EndIndex = -1" clamps the to the end of the array. Equivalent of setting EndIndex = (ArrayValues.Length - 1)
sslBaseAnimation[] function SliceAnimationArray(sslBaseAnimation[] ArrayValues, int StartIndex, int EndIndex = -1) global
	If EndIndex == -1 || EndIndex >= ArrayValues.Length
		EndIndex = ArrayValues.Length - 1
	endIf
	If StartIndex >= EndIndex
		return AnimationArray(0)
	endIf

	int ToSize = EndIndex - StartIndex
	If ToSize < 1
		return AnimationArray(0)
	elseIf ToSize == ArrayValues.Length
		return ArrayValues
	endIf
	
	sslBaseAnimation[] Output = AnimationArray(ToSize)
	;  AnimationCopyTo(ArrayValues, Output)
	int i = StartIndex
	int n = 0
	while i <= EndIndex
		Output[n] = ArrayValues[i]
		n += 1
		i += 1
	endWhile
	return Output
endFunction

sslBaseAnimation[] function FilterTaggedAnimations(sslBaseAnimation[] Anims, string[] Tags, bool HasTag = true) global
	if !Anims || Anims.Length < 1
		return Anims
	elseIf !Tags || Tags.Length < 1
		if HasTag
			return AnimationArray(0)
		endIf
		return Anims
	endIf
	int i = Anims.Length
	bool[] Valid = Utility.CreateBoolArray(i)
	while i
		i -= 1
		Valid[i] = Anims[i].HasOneTag(Tags) == HasTag
	endWhile
	; Check results
	if Valid.Find(true) == -1
		return AnimationArray(0) ; No valid animations
	elseIf Valid.Find(false) == -1
		return Anims ; All valid animations
	endIf
	; Filter output
	i = Anims.Length
	int n = PapyrusUtil.CountBool(Valid, true)
	sslBaseAnimation[] Output = AnimationArray(n)
	while i && n
		i -= 1
		if Valid[i]
			n -= 1
			Output[n] = Anims[i]
		endIf
	endWhile
	return Output
endFunction

sslBaseAnimation[] function ShuffleAnimations(sslBaseAnimation[] Anims) global
	if !Anims || Anims.Length < 3
		return Anims
	endIf
	sslBaseAnimation[] Output = AnimationArray(Anims.Length)
	int n = Anims.Length
	int max = n - 1
	while n > 0
		n -= 1
		int i = Utility.RandomInt(0, max)
		if Output[i]
			if i != max
				i = Output.Find(none, i)
				if i == -1
					i = Output.Find(none)
				endIf
			else
				i = Output.RFind(none)
			endIf
		endIf
		if i == -1 || Output[i] != none
			debug.trace("SHUFFLE ANIMATIONS GOT -1 "+Output)
			debug.traceuser("SexLabDebug", "SHUFFLE ANIMATIONS GOT -1 "+Output)
			i = Output.Find(none)
		endIf
		Output[i] = Anims[n]
	endWhile
	return Output
endFunction

bool[] function FindTaggedAnimations(sslBaseAnimation[] Anims, string[] Tags) global
	if Anims.Length < 1 || Tags.Length < 0
		return Utility.CreateBoolArray(0)
	endIf
	int i = Anims.Length
	bool[] Output = Utility.CreateBoolArray(i)
	while i
		i -= 1
		Output[i] = Anims[i].HasOneTag(Tags)
	endWhile
	return Output
endFunction

string[] function GetAnimationNames(sslBaseAnimation[] List) global
	int i = List.Length 
	string[] Names = Utility.CreateStringArray(i)
	while i
		i -= 1
		if List[i]
			Names[i] = List[i].Name
		else
			Names[i] = "<empty>"
		endIf
	endWhile
	return Names
endFunction

string[] function GetAllAnimationTagsInArray(sslBaseAnimation[] List) global
	string[] Output
	if !List
		return Output
	endIf
	int i = List.Length
	while i
		i -= 1
		if List[i]
			Output = PapyrusUtil.MergeStringArray(Output, List[i].GetRawTags(), true)
		endIf
	endwhile
	PapyrusUtil.SortStringArray(Output)
	return PapyrusUtil.RemoveString(Output, "")
endFunction

sslBaseAnimation function AnimationIfElse(bool isTrue, sslBaseAnimation returnTrue, sslBaseAnimation returnFalse) global
	if isTrue
		return returnTrue
	endIf
	return returnFalse
endfunction

sslBaseAnimation[] function AnimationArrayIfElse(bool isTrue, sslBaseAnimation[] returnTrue, sslBaseAnimation[] returnFalse) global
	if isTrue
		return returnTrue
	endIf
	return returnFalse
endfunction

; ;/-----------------------------------------------\;
; ;|	Expression Utility Functions
; ;\-----------------------------------------------/;

; function ExpressionCopyTo(sslBaseExpression[] SourceArray, sslBaseExpression[] ToArray, int StartIndex = 0, int EndIndex = -1, bool SkipEmpty = false) global native
; int function CountExpression(sslBaseExpression[] Values, sslBaseExpression EqualTo = none) global native

sslBaseExpression[] function ResizeExpressionArray(sslBaseExpression[] ArrayValues, int ToSize, sslBaseExpression Filler = none) global
	if ToSize == ArrayValues.Length
		return ArrayValues
	elseIf ToSize < 1
		return ExpressionArray(0)
	elseIf ToSize > 128
		ToSize = 128
	endIf
	sslBaseExpression[] Output = ExpressionArray(ToSize)
	;  ExpressionCopyTo(ArrayValues, Output)
	If ToSize > ArrayValues.Length
		ToSize = ArrayValues.Length
	EndIf
	while ToSize
		ToSize -= 1
		If ToSize > ArrayValues.Length
			Output[ToSize] = Filler
		Else
			Output[ToSize] = ArrayValues[ToSize]
		EndIf
	endWhile
	return Output
endFunction

sslBaseExpression[] function PushExpressionToArray(sslBaseExpression[] ArrayValues, sslBaseExpression ToPush) global
	int len = ArrayValues.Length
	if len >= 128
		return ArrayValues
	endIf
	sslBaseExpression[] Pushed = ExpressionArray(len+1)
; 	ExpressionCopyTo(ArrayValues, Pushed)
	Pushed[len] = ToPush
	while len
		len -=1
		Pushed[len] = ArrayValues[len]
	endWhile
	return Pushed
endFunction

sslBaseExpression[] function RemoveExpressionFromArray(sslBaseExpression[] ArrayValues, sslBaseExpression ToRemove) global
	if !ArrayValues
		return ExpressionArray(0)
	ElseIf ArrayValues.Find(ToRemove) == -1
		return ArrayValues
	;	return CopyExpressionArray(ArrayValues)
	endIf
	sslBaseExpression[] Output = ExpressionArray(ArrayValues.Length)
	int i = 0
	int n = 0
	while i < ArrayValues.Length && n < Output.Length
		If ArrayValues[i] != ToRemove
			Output[n] = ArrayValues[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return ResizeExpressionArray(Output, n)
	EndIf
	return Output
endFunction

; ## Removes all duplicate elements from the given array and returns the shortened array with only a single instance of all element values.
sslBaseExpression[] function RemoveDupeExpression(sslBaseExpression[] ArrayValues) global
	sslBaseExpression[] Output = ExpressionArray(ArrayValues.Length)
	int n = 0
	int i = 0
	while i < ArrayValues.Length && n < Output.Length
		If Output.Find(ArrayValues[i]) == -1 ; Also remove None
			Output[n] = ArrayValues[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return ResizeExpressionArray(Output, n)
	EndIf
	return Output
endFunction

sslBaseExpression[] function GetDiffExpression(sslBaseExpression[] ArrayValues1, sslBaseExpression[] ArrayValues2, bool CompareBoth = false, bool IncludeDupes = false) global
	sslBaseExpression[] output
	if !ArrayValues1 && !ArrayValues2
		Return output
	elseIf !ArrayValues1
		If CompareBoth
			If !IncludeDupes
				Return RemoveDupeExpression(ArrayValues2)
			Else
				Return ArrayValues2
			;	return CopyExpressionArray(ArrayValues2)
			endIf
		Else
			Return output
		endIf
	elseIf !ArrayValues2
		If !IncludeDupes
			Return RemoveDupeExpression(ArrayValues1)
		Else
			Return ArrayValues1
		;	return CopyExpressionArray(ArrayValues1)
		endIf
	endIf
	Output = ExpressionArray(ArrayValues1.Length + (CompareBoth as int * ArrayValues2.Length))
	int n = 0
	int i = 0
	While i < ArrayValues1.Length && n < Output.Length ; the ArrayValues1.Length can change while this function is executed and the output is limited anyway.
		if (ArrayValues2.Find(ArrayValues1[i]) == -1) && (IncludeDupes || output.Find(ArrayValues2[i]) == -1)
			output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	EndWhile

	if (CompareBoth) ; Will merge both arrays
		i = 0
		While i < ArrayValues2.Length && n < Output.Length ; the ArrayValues1.Length can change while this function is executed and the output is limited anyway.
			if (ArrayValues1.Find(ArrayValues2[i]) == -1) && (IncludeDupes || output.Find(ArrayValues1[i]) == -1)
				output[n] = ArrayValues2[i]
				n += 1
			EndIf
			i += 1
		EndWhile
	endIf
	If n < Output.Length
		return ResizeExpressionArray(Output, n)
	EndIf
	Return Output
endFunction

; ## Get an array of values that are present in both ArrayValues1 and ArrayValues2.
sslBaseExpression[] function GetMatchingExpression(sslBaseExpression[] ArrayValues1, sslBaseExpression[] ArrayValues2) global
	sslBaseExpression[] Output
	if !ArrayValues1 || !ArrayValues2
		Return Output
	endIf
	int n = 0
	int i = 0
	Output = ExpressionArray(ArrayValues1.Length)
	while i < ArrayValues1.Length && n < Output.Length ; In theory the ArrayValues1.Length can change while this function is executed.
		If ArrayValues2.Find(ArrayValues1[i]) != -1 && output.Find(ArrayValues1[i]) == -1 ; Also remove Dupes and None
			output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	EndWhile
	If n < Output.Length
		return ResizeExpressionArray(Output, n)
	EndIf
	return Output
endFunction

; ## Returns two arrays combined into one, optionally also removing any duplicate occurrences of a value.
sslBaseExpression[] function MergeExpressionArray(sslBaseExpression[] ArrayValues1, sslBaseExpression[] ArrayValues2, bool RemoveDupes = false) global
	if !ArrayValues1 && !ArrayValues2
		return ExpressionArray(0)
	elseIf !RemoveDupes && !ArrayValues1
		return ArrayValues2
	;	return CopyExpressionArray(ArrayValues2)
	elseIf !RemoveDupes && !ArrayValues2
		return ArrayValues1
	;	return CopyExpressionArray(ArrayValues1)
	endIf
	sslBaseExpression[] Output = ExpressionArray(ArrayValues1.Length + ArrayValues2.Length)
	int n = 0
	int i = 0
	while i < ArrayValues1.Length && n < Output.Length
		If !RemoveDupes || Output.Find(ArrayValues1[i]) == -1 ; Also remove None
			Output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	endWhile
	i = 0
	while i < ArrayValues2.Length && n < Output.Length
		If !RemoveDupes || Output.Find(ArrayValues2[i]) == -1 ; Also remove None
			Output[n] = ArrayValues2[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return ResizeExpressionArray(Output, n)
	EndIf
	return Output
endFunction

; ## Returns a sub section of an array indicated by a starting and ending index.
; ## The default argument "int EndIndex = -1" clamps the to the end of the array. Equivalent of setting EndIndex = (ArrayValues.Length - 1)
sslBaseExpression[] function SliceExpressionArray(sslBaseExpression[] ArrayValues, int StartIndex, int EndIndex = -1) global
	If EndIndex == -1 || EndIndex >= ArrayValues.Length
		EndIndex = ArrayValues.Length - 1
	endIf
	If StartIndex >= EndIndex
		return ExpressionArray(0)
	endIf

	int ToSize = EndIndex - StartIndex
	If ToSize < 1
		return ExpressionArray(0)
	elseIf ToSize == ArrayValues.Length
		return ArrayValues
	endIf
	
	sslBaseExpression[] Output = ExpressionArray(ToSize)
	;  ExpressionCopyTo(ArrayValues, Output)
	int i = StartIndex
	int n = 0
	while i <= EndIndex
		Output[n] = ArrayValues[i]
		n += 1
		i += 1
	endWhile
	return Output
endFunction

sslBaseExpression[] function FilterTaggedExpressions(sslBaseExpression[] Expressions, string[] Tags, bool HasTag = true) global
	if !Expressions || Expressions.Length < 1
		return Expressions
	elseIf !Tags || Tags.Length < 1
		if HasTag
			return ExpressionArray(0)
		endIf
		return Expressions
	endIf
	int i = Expressions.Length
	bool[] Valid = Utility.CreateBoolArray(i)
	while i
		i -= 1
		Valid[i] = Expressions[i].HasOneTag(Tags) == HasTag
	endWhile
	; Check results
	if Valid.Find(true) == -1
		return ExpressionArray(0) ; No valid Expressions
	elseIf Valid.Find(false) == -1
		return Expressions ; All valid Expressions
	endIf
	; Filter output
	i = Expressions.Length
	int n = PapyrusUtil.CountBool(Valid, true)
	sslBaseExpression[] Output = ExpressionArray(n)
	while i && n
		i -= 1
		if Valid[i]
			n -= 1
			Output[n] = Expressions[i]
		endIf
	endWhile
	return Output
endFunction

sslBaseExpression[] function ShuffleExpressions(sslBaseExpression[] Expressions) global
	if !Expressions || Expressions.Length < 3
		return Expressions
	endIf
	sslBaseExpression[] Output = ExpressionArray(Expressions.Length)
	int n = Expressions.Length
	int max = n - 1
	while n > 0
		n -= 1
		int i = Utility.RandomInt(0, max)
		if Output[i]
			if i != max
				i = Output.Find(none, i)
				if i == -1
					i = Output.Find(none)
				endIf
			else
				i = Output.RFind(none)
			endIf
		endIf
		if i == -1 || Output[i] != none
			debug.trace("SHUFFLE EXPRESSIONS GOT -1 "+Output)
			debug.traceuser("SexLabDebug", "SHUFFLE EXPRESSIONS GOT -1 "+Output)
			i = Output.Find(none)
		endIf
		Output[i] = Expressions[n]
	endWhile
	return Output
endFunction

bool[] function FindTaggedExpressions(sslBaseExpression[] Expressions, string[] Tags) global
	if Expressions.Length < 1 || Tags.Length < 0
		return Utility.CreateBoolArray(0)
	endIf
	int i = Expressions.Length
	bool[] Output = Utility.CreateBoolArray(i)
	while i
		i -= 1
		Output[i] = Expressions[i].HasOneTag(Tags)
	endWhile
	return Output
endFunction

string[] function GetExpressionNames(sslBaseExpression[] List) global
	int i = List.Length 
	string[] Names = Utility.CreateStringArray(i)
	while i
		i -= 1
		if List[i]
			Names[i] = List[i].Name
		else
			Names[i] = "<empty>"
		endIf
	endWhile
	return Names
endFunction

string[] function GetAllExpressionTagsInArray(sslBaseExpression[] List) global
	string[] Output
	if !List
		return Output
	endIf
	int i = List.Length
	while i
		i -= 1
		if List[i]
			Output = PapyrusUtil.MergeStringArray(Output, List[i].GetRawTags(), true)
		endIf
	endwhile
	PapyrusUtil.SortStringArray(Output)
	return PapyrusUtil.RemoveString(Output, "")
endFunction

sslBaseExpression function ExpressionIfElse(bool isTrue, sslBaseExpression returnTrue, sslBaseExpression returnFalse) global
	if isTrue
		return returnTrue
	endIf
	return returnFalse
endfunction

sslBaseExpression[] function ExpressionArrayIfElse(bool isTrue, sslBaseExpression[] returnTrue, sslBaseExpression[] returnFalse) global
	if isTrue
		return returnTrue
	endIf
	return returnFalse
endfunction

; ;/-----------------------------------------------\;
; ;|	Voice Utility Functions
; ;\-----------------------------------------------/;

; function VoiceCopyTo(sslBaseVoice[] SourceArray, sslBaseVoice[] ToArray, int StartIndex = 0, int EndIndex = -1, bool SkipEmpty = false) global native
; int function CountVoice(sslBaseVoice[] Values, sslBaseVoice EqualTo = none) global native

sslBaseVoice[] function ResizeVoiceArray(sslBaseVoice[] ArrayValues, int ToSize, sslBaseVoice Filler = none) global
	if ToSize == ArrayValues.Length
		return ArrayValues
	elseIf ToSize < 1
		return VoiceArray(0)
	elseIf ToSize > 128
		ToSize = 128
	endIf
	sslBaseVoice[] Output = VoiceArray(ToSize)
	;  VoiceCopyTo(ArrayValues, Output)
	If ToSize > ArrayValues.Length
		ToSize = ArrayValues.Length
	EndIf
	while ToSize
		ToSize -= 1
		If ToSize > ArrayValues.Length
			Output[ToSize] = Filler
		Else
			Output[ToSize] = ArrayValues[ToSize]
		EndIf
	endWhile
	return Output
endFunction

sslBaseVoice[] function PushVoiceToArray(sslBaseVoice[] ArrayValues, sslBaseVoice ToPush) global
	int len = ArrayValues.Length
	if len >= 128
		return ArrayValues
	endIf
	sslBaseVoice[] Pushed = VoiceArray(len+1)
; 	VoiceCopyTo(ArrayValues, Pushed)
	Pushed[len] = ToPush
	while len
		len -=1
		Pushed[len] = ArrayValues[len]
	endWhile
	return Pushed
endFunction

sslBaseVoice[] function RemoveVoiceFromArray(sslBaseVoice[] ArrayValues, sslBaseVoice ToRemove) global
	if !ArrayValues
		return VoiceArray(0)
	ElseIf ArrayValues.Find(ToRemove) == -1
		return ArrayValues
	;	return CopyVoiceArray(ArrayValues)
	endIf
	sslBaseVoice[] Output = VoiceArray(ArrayValues.Length)
	int i = 0
	int n = 0
	while i < ArrayValues.Length && n < Output.Length
		If ArrayValues[i] != ToRemove
			Output[n] = ArrayValues[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return ResizeVoiceArray(Output, n)
	EndIf
	return Output
endFunction

; ## Removes all duplicate elements from the given array and returns the shortened array with only a single instance of all element values.
sslBaseVoice[] function RemoveDupeVoice(sslBaseVoice[] ArrayValues) global
	sslBaseVoice[] Output = VoiceArray(ArrayValues.Length)
	int n = 0
	int i = 0
	while i < ArrayValues.Length && n < Output.Length
		If Output.Find(ArrayValues[i]) == -1 ; Also remove None
			Output[n] = ArrayValues[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return ResizeVoiceArray(Output, n)
	EndIf
	return Output
endFunction

sslBaseVoice[] function GetDiffVoice(sslBaseVoice[] ArrayValues1, sslBaseVoice[] ArrayValues2, bool CompareBoth = false, bool IncludeDupes = false) global
	sslBaseVoice[] output
	if !ArrayValues1 && !ArrayValues2
		Return output
	elseIf !ArrayValues1
		If CompareBoth
			If !IncludeDupes
				Return RemoveDupeVoice(ArrayValues2)
			Else
				Return ArrayValues2
			;	return CopyVoiceArray(ArrayValues2)
			endIf
		Else
			Return output
		endIf
	elseIf !ArrayValues2
		If !IncludeDupes
			Return RemoveDupeVoice(ArrayValues1)
		Else
			Return ArrayValues1
		;	return CopyVoiceArray(ArrayValues1)
		endIf
	endIf
	Output = VoiceArray(ArrayValues1.Length + (CompareBoth as int * ArrayValues2.Length))
	int n = 0
	int i = 0
	While i < ArrayValues1.Length && n < Output.Length ; the ArrayValues1.Length can change while this function is executed and the output is limited anyway.
		if (ArrayValues2.Find(ArrayValues1[i]) == -1) && (IncludeDupes || output.Find(ArrayValues2[i]) == -1)
			output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	EndWhile

	if (CompareBoth) ; Will merge both arrays
		i = 0
		While i < ArrayValues2.Length && n < Output.Length ; the ArrayValues1.Length can change while this function is executed and the output is limited anyway.
			if (ArrayValues1.Find(ArrayValues2[i]) == -1) && (IncludeDupes || output.Find(ArrayValues1[i]) == -1)
				output[n] = ArrayValues2[i]
				n += 1
			EndIf
			i += 1
		EndWhile
	endIf
	If n < Output.Length
		return ResizeVoiceArray(Output, n)
	EndIf
	Return Output
endFunction

; ## Get an array of values that are present in both ArrayValues1 and ArrayValues2.
sslBaseVoice[] function GetMatchingVoice(sslBaseVoice[] ArrayValues1, sslBaseVoice[] ArrayValues2) global
	sslBaseVoice[] Output
	if !ArrayValues1 || !ArrayValues2
		Return Output
	endIf
	int n = 0
	int i = 0
	Output = VoiceArray(ArrayValues1.Length)
	while i < ArrayValues1.Length && n < Output.Length ; In theory the ArrayValues1.Length can change while this function is executed.
		If ArrayValues2.Find(ArrayValues1[i]) != -1 && output.Find(ArrayValues1[i]) == -1 ; Also remove Dupes and None
			output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	EndWhile
	If n < Output.Length
		return ResizeVoiceArray(Output, n)
	EndIf
	return Output
endFunction

; ## Returns two arrays combined into one, optionally also removing any duplicate occurrences of a value.
sslBaseVoice[] function MergeVoiceArray(sslBaseVoice[] ArrayValues1, sslBaseVoice[] ArrayValues2, bool RemoveDupes = false) global
	if !ArrayValues1 && !ArrayValues2
		return VoiceArray(0)
	elseIf !RemoveDupes && !ArrayValues1
		return ArrayValues2
	;	return CopyVoiceArray(ArrayValues2)
	elseIf !RemoveDupes && !ArrayValues2
		return ArrayValues1
	;	return CopyVoiceArray(ArrayValues1)
	endIf
	sslBaseVoice[] Output = VoiceArray(ArrayValues1.Length + ArrayValues2.Length)
	int n = 0
	int i = 0
	while i < ArrayValues1.Length && n < Output.Length
		If !RemoveDupes || Output.Find(ArrayValues1[i]) == -1 ; Also remove None
			Output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	endWhile
	i = 0
	while i < ArrayValues2.Length && n < Output.Length
		If !RemoveDupes || Output.Find(ArrayValues2[i]) == -1 ; Also remove None
			Output[n] = ArrayValues2[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return ResizeVoiceArray(Output, n)
	EndIf
	return Output
endFunction

; ## Returns a sub section of an array indicated by a starting and ending index.
; ## The default argument "int EndIndex = -1" clamps the to the end of the array. Equivalent of setting EndIndex = (ArrayValues.Length - 1)
sslBaseVoice[] function SliceVoiceArray(sslBaseVoice[] ArrayValues, int StartIndex, int EndIndex = -1) global
	If EndIndex == -1 || EndIndex >= ArrayValues.Length
		EndIndex = ArrayValues.Length - 1
	endIf
	If StartIndex >= EndIndex
		return VoiceArray(0)
	endIf

	int ToSize = EndIndex - StartIndex
	If ToSize < 1
		return VoiceArray(0)
	elseIf ToSize == ArrayValues.Length
		return ArrayValues
	endIf
	
	sslBaseVoice[] Output = VoiceArray(ToSize)
	;  VoiceCopyTo(ArrayValues, Output)
	int i = StartIndex
	int n = 0
	while i <= EndIndex
		Output[n] = ArrayValues[i]
		n += 1
		i += 1
	endWhile
	return Output
endFunction

sslBaseVoice[] function FilterTaggedVoices(sslBaseVoice[] Voices, string[] Tags, bool HasTag = true) global
	if !Voices || Voices.Length < 1
		return Voices
	elseIf !Tags || Tags.Length < 1
		if HasTag
			return VoiceArray(0)
		endIf
		return Voices
	endIf
	int i = Voices.Length
	bool[] Valid = Utility.CreateBoolArray(i)
	while i
		i -= 1
		Valid[i] = Voices[i].HasOneTag(Tags) == HasTag
	endWhile
	; Check results
	if Valid.Find(true) == -1
		return VoiceArray(0) ; No valid Voices
	elseIf Valid.Find(false) == -1
		return Voices ; All valid Voices
	endIf
	; Filter output
	i = Voices.Length
	int n = PapyrusUtil.CountBool(Valid, true)
	sslBaseVoice[] Output = VoiceArray(n)
	while i && n
		i -= 1
		if Valid[i]
			n -= 1
			Output[n] = Voices[i]
		endIf
	endWhile
	return Output
endFunction

sslBaseVoice[] function ShuffleVoices(sslBaseVoice[] Voices) global
	if !Voices || Voices.Length < 3
		return Voices
	endIf
	sslBaseVoice[] Output = VoiceArray(Voices.Length)
	int n = Voices.Length
	int max = n - 1
	while n > 0
		n -= 1
		int i = Utility.RandomInt(0, max)
		if Output[i]
			if i != max
				i = Output.Find(none, i)
				if i == -1
					i = Output.Find(none)
				endIf
			else
				i = Output.RFind(none)
			endIf
		endIf
		if i == -1 || Output[i] != none
			debug.trace("SHUFFLE VOICES GOT -1 "+Output)
			debug.traceuser("SexLabDebug", "SHUFFLE VOICES GOT -1 "+Output)
			i = Output.Find(none)
		endIf
		Output[i] = Voices[n]
	endWhile
	return Output
endFunction

bool[] function FindTaggedVoices(sslBaseVoice[] Voices, string[] Tags) global
	if Voices.Length < 1 || Tags.Length < 0
		return Utility.CreateBoolArray(0)
	endIf
	int i = Voices.Length
	bool[] Output = Utility.CreateBoolArray(i)
	while i
		i -= 1
		Output[i] = Voices[i].HasOneTag(Tags)
	endWhile
	return Output
endFunction

string[] function GetVoiceNames(sslBaseVoice[] List) global
	int i = List.Length 
	string[] Names = Utility.CreateStringArray(i)
	while i
		i -= 1
		if List[i]
			Names[i] = List[i].Name
		else
			Names[i] = "<empty>"
		endIf
	endWhile
	return Names
endFunction

string[] function GetAllVoiceTagsInArray(sslBaseVoice[] List) global
	string[] Output
	if !List
		return Output
	endIf
	int i = List.Length
	while i
		i -= 1
		if List[i]
			Output = PapyrusUtil.MergeStringArray(Output, List[i].GetRawTags(), true)
		endIf
	endwhile
	PapyrusUtil.SortStringArray(Output)
	return PapyrusUtil.RemoveString(Output, "")
endFunction

sslBaseVoice function VoiceIfElse(bool isTrue, sslBaseVoice returnTrue, sslBaseVoice returnFalse) global
	if isTrue
		return returnTrue
	endIf
	return returnFalse
endfunction

sslBaseVoice[] function VoiceArrayIfElse(bool isTrue, sslBaseVoice[] returnTrue, sslBaseVoice[] returnFalse) global
	if isTrue
		return returnTrue
	endIf
	return returnFalse
endfunction

; ;/-----------------------------------------------\;
; ;|	Object Utility Functions
; ;\-----------------------------------------------/;

; function BaseObjectCopyTo(sslBaseObject[] SourceArray, sslBaseObject[] ToArray, int StartIndex = 0, int EndIndex = -1, bool SkipEmpty = false) global native
; int function CountBaseObject(sslBaseObject[] Values, sslBaseObject EqualTo = none) global native

sslBaseObject[] function ResizeBaseObjectArray(sslBaseObject[] ArrayValues, int ToSize, sslBaseObject Filler = none) global
	if ToSize == ArrayValues.Length
		return ArrayValues
	elseIf ToSize < 1
		return BaseObjectArray(0)
	elseIf ToSize > 128
		ToSize = 128
	endIf
	sslBaseObject[] Output = BaseObjectArray(ToSize)
	;  BaseObjectCopyTo(ArrayValues, Output)
	If ToSize > ArrayValues.Length
		ToSize = ArrayValues.Length
	EndIf
	while ToSize
		ToSize -= 1
		If ToSize > ArrayValues.Length
			Output[ToSize] = Filler
		Else
			Output[ToSize] = ArrayValues[ToSize]
		EndIf
	endWhile
	return Output
endFunction

sslBaseObject[] function PushBaseObjectToArray(sslBaseObject[] ArrayValues, sslBaseObject ToPush) global
	int len = ArrayValues.Length
	if len >= 128
		return ArrayValues
	endIf
	sslBaseObject[] Pushed = BaseObjectArray(len+1)
; 	BaseObjectCopyTo(ArrayValues, Pushed)
	Pushed[len] = ToPush
	while len
		len -=1
		Pushed[len] = ArrayValues[len]
	endWhile
	return Pushed
endFunction

sslBaseObject[] function RemoveBaseObjectFromArray(sslBaseObject[] ArrayValues, sslBaseObject ToRemove) global
	if !ArrayValues
		return BaseObjectArray(0)
	ElseIf ArrayValues.Find(ToRemove) == -1
		return ArrayValues
	;	return CopyBaseObjectArray(ArrayValues)
	endIf
	sslBaseObject[] Output = BaseObjectArray(ArrayValues.Length)
	int i = 0
	int n = 0
	while i < ArrayValues.Length && n < Output.Length
		If ArrayValues[i] != ToRemove
			Output[n] = ArrayValues[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return ResizeBaseObjectArray(Output, n)
	EndIf
	return Output
endFunction

; ## Removes all duplicate elements from the given array and returns the shortened array with only a single instance of all element values.
sslBaseObject[] function RemoveDupeBaseObject(sslBaseObject[] ArrayValues) global
	sslBaseObject[] Output = BaseObjectArray(ArrayValues.Length)
	int n = 0
	int i = 0
	while i < ArrayValues.Length && n < Output.Length
		If Output.Find(ArrayValues[i]) == -1 ; Also remove None
			Output[n] = ArrayValues[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return ResizeBaseObjectArray(Output, n)
	EndIf
	return Output
endFunction

sslBaseObject[] function GetDiffBaseObject(sslBaseObject[] ArrayValues1, sslBaseObject[] ArrayValues2, bool CompareBoth = false, bool IncludeDupes = false) global
	sslBaseObject[] output
	if !ArrayValues1 && !ArrayValues2
		Return output
	elseIf !ArrayValues1
		If CompareBoth
			If !IncludeDupes
				Return RemoveDupeBaseObject(ArrayValues2)
			Else
				Return ArrayValues2
			;	return CopyBaseObjectArray(ArrayValues2)
			endIf
		Else
			Return output
		endIf
	elseIf !ArrayValues2
		If !IncludeDupes
			Return RemoveDupeBaseObject(ArrayValues1)
		Else
			Return ArrayValues1
		;	return CopyBaseObjectArray(ArrayValues1)
		endIf
	endIf
	Output = BaseObjectArray(ArrayValues1.Length + (CompareBoth as int * ArrayValues2.Length))
	int n = 0
	int i = 0
	While i < ArrayValues1.Length && n < Output.Length ; the ArrayValues1.Length can change while this function is executed and the output is limited anyway.
		if (ArrayValues2.Find(ArrayValues1[i]) == -1) && (IncludeDupes || output.Find(ArrayValues2[i]) == -1)
			output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	EndWhile

	if (CompareBoth) ; Will merge both arrays
		i = 0
		While i < ArrayValues2.Length && n < Output.Length ; the ArrayValues1.Length can change while this function is executed and the output is limited anyway.
			if (ArrayValues1.Find(ArrayValues2[i]) == -1) && (IncludeDupes || output.Find(ArrayValues1[i]) == -1)
				output[n] = ArrayValues2[i]
				n += 1
			EndIf
			i += 1
		EndWhile
	endIf
	If n < Output.Length
		return ResizeBaseObjectArray(Output, n)
	EndIf
	Return Output
endFunction

; ## Get an array of values that are present in both ArrayValues1 and ArrayValues2.
sslBaseObject[] function GetMatchingBaseObject(sslBaseObject[] ArrayValues1, sslBaseObject[] ArrayValues2) global
	sslBaseObject[] Output
	if !ArrayValues1 || !ArrayValues2
		Return Output
	endIf
	int n = 0
	int i = 0
	Output = BaseObjectArray(ArrayValues1.Length)
	while i < ArrayValues1.Length && n < Output.Length ; In theory the ArrayValues1.Length can change while this function is executed.
		If ArrayValues2.Find(ArrayValues1[i]) != -1 && output.Find(ArrayValues1[i]) == -1 ; Also remove Dupes and None
			output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	EndWhile
	If n < Output.Length
		return ResizeBaseObjectArray(Output, n)
	EndIf
	return Output
endFunction

; ## Returns two arrays combined into one, optionally also removing any duplicate occurrences of a value.
sslBaseObject[] function MergeBaseObjectArray(sslBaseObject[] ArrayValues1, sslBaseObject[] ArrayValues2, bool RemoveDupes = false) global
	if !ArrayValues1 && !ArrayValues2
		return BaseObjectArray(0)
	elseIf !RemoveDupes && !ArrayValues1
		return ArrayValues2
	;	return CopyBaseObjectArray(ArrayValues2)
	elseIf !RemoveDupes && !ArrayValues2
		return ArrayValues1
	;	return CopyBaseObjectArray(ArrayValues1)
	endIf
	sslBaseObject[] Output = BaseObjectArray(ArrayValues1.Length + ArrayValues2.Length)
	int n = 0
	int i = 0
	while i < ArrayValues1.Length && n < Output.Length
		If !RemoveDupes || Output.Find(ArrayValues1[i]) == -1 ; Also remove None
			Output[n] = ArrayValues1[i]
			n += 1
		EndIf
		i += 1
	endWhile
	i = 0
	while i < ArrayValues2.Length && n < Output.Length
		If !RemoveDupes || Output.Find(ArrayValues2[i]) == -1 ; Also remove None
			Output[n] = ArrayValues2[i]
			n += 1
		EndIf
		i += 1
	endWhile
	If n < Output.Length
		return ResizeBaseObjectArray(Output, n)
	EndIf
	return Output
endFunction

; ## Returns a sub section of an array indicated by a starting and ending index.
; ## The default argument "int EndIndex = -1" clamps the to the end of the array. Equivalent of setting EndIndex = (ArrayValues.Length - 1)
sslBaseObject[] function SliceBaseObjectArray(sslBaseObject[] ArrayValues, int StartIndex, int EndIndex = -1) global
	If EndIndex == -1 || EndIndex >= ArrayValues.Length
		EndIndex = ArrayValues.Length - 1
	endIf
	If StartIndex >= EndIndex
		return BaseObjectArray(0)
	endIf

	int ToSize = EndIndex - StartIndex
	If ToSize < 1
		return BaseObjectArray(0)
	elseIf ToSize == ArrayValues.Length
		return ArrayValues
	endIf
	
	sslBaseObject[] Output = BaseObjectArray(ToSize)
	;  BaseObjectCopyTo(ArrayValues, Output)
	int i = StartIndex
	int n = 0
	while i <= EndIndex
		Output[n] = ArrayValues[i]
		n += 1
		i += 1
	endWhile
	return Output
endFunction

sslBaseObject[] function FilterTaggedBaseObjects(sslBaseObject[] BaseObjects, string[] Tags, bool HasTag = true) global
	if !BaseObjects || BaseObjects.Length < 1
		return BaseObjects
	elseIf !Tags || Tags.Length < 1
		if HasTag
			return BaseObjectArray(0)
		endIf
		return BaseObjects
	endIf
	int i = BaseObjects.Length
	bool[] Valid = Utility.CreateBoolArray(i)
	while i
		i -= 1
		Valid[i] = BaseObjects[i].HasOneTag(Tags) == HasTag
	endWhile
	; Check results
	if Valid.Find(true) == -1
		return BaseObjectArray(0) ; No valid BaseObjects
	elseIf Valid.Find(false) == -1
		return BaseObjects ; All valid BaseObjects
	endIf
	; Filter output
	i = BaseObjects.Length
	int n = PapyrusUtil.CountBool(Valid, true)
	sslBaseObject[] Output = BaseObjectArray(n)
	while i && n
		i -= 1
		if Valid[i]
			n -= 1
			Output[n] = BaseObjects[i]
		endIf
	endWhile
	return Output
endFunction

sslBaseObject[] function ShuffleBaseObjects(sslBaseObject[] BaseObjects) global
	if !BaseObjects || BaseObjects.Length < 3
		return BaseObjects
	endIf
	sslBaseObject[] Output = BaseObjectArray(BaseObjects.Length)
	int n = BaseObjects.Length
	int max = n - 1
	while n > 0
		n -= 1
		int i = Utility.RandomInt(0, max)
		if Output[i]
			if i != max
				i = Output.Find(none, i)
				if i == -1
					i = Output.Find(none)
				endIf
			else
				i = Output.RFind(none)
			endIf
		endIf
		if i == -1 || Output[i] != none
			debug.trace("SHUFFLE BASE OBJECT  GOT -1 "+Output)
			debug.traceuser("SexLabDebug", "SHUFFLE BASE OBJECT GOT -1 "+Output)
			i = Output.Find(none)
		endIf
		Output[i] = BaseObjects[n]
	endWhile
	return Output
endFunction

bool[] function FindTaggedBaseObjects(sslBaseObject[] BaseObjects, string[] Tags) global
	if BaseObjects.Length < 1 || Tags.Length < 0
		return Utility.CreateBoolArray(0)
	endIf
	int i = BaseObjects.Length
	bool[] Output = Utility.CreateBoolArray(i)
	while i
		i -= 1
		Output[i] = BaseObjects[i].HasOneTag(Tags)
	endWhile
	return Output
endFunction

string[] function GetBaseObjectNames(sslBaseObject[] List) global
	int i = List.Length 
	string[] Names = Utility.CreateStringArray(i)
	while i
		i -= 1
		if List[i]
			Names[i] = List[i].Name
		else
			Names[i] = "<empty>"
		endIf
	endWhile
	return Names
endFunction

string[] function GetAllBaseObjectTagsInArray(sslBaseObject[] List) global
	string[] Output
	if !List
		return Output
	endIf
	int i = List.Length
	while i
		i -= 1
		if List[i]
			Output = PapyrusUtil.MergeStringArray(Output, List[i].GetRawTags(), true)
		endIf
	endwhile
	PapyrusUtil.SortStringArray(Output)
	return PapyrusUtil.RemoveString(Output, "")
endFunction

sslBaseObject function BaseObjectIfElse(bool isTrue, sslBaseObject returnTrue, sslBaseObject returnFalse) global
	if isTrue
		return returnTrue
	endIf
	return returnFalse
endfunction

sslBaseObject[] function BaseObjectArrayIfElse(bool isTrue, sslBaseObject[] returnTrue, sslBaseObject[] returnFalse) global
	if isTrue
		return returnTrue
	endIf
	return returnFalse
endfunction


; #####################
; ## Debug Functions ##
; #####################

function Log(string asMsg, string asSrc = "") Global
		asMsg = "Utility: "+asSrc+" - "+asMsg
		Debug.TraceUser("SexLabDebug", asMsg)
endFunction
