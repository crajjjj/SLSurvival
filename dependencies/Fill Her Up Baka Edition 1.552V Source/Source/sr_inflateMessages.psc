Scriptname sr_inflateMessages extends Quest

sr_inflateQuest Property inflater auto

int chanceMod = 0
String file = "../FillHerUp/statuses"
float msgInterval = 1.0

float Property msgChance = 0.0 auto hidden

GlobalVariable Property _sr_messageConsolePrint auto
bool property printConsole hidden
	bool Function Get()
		return _sr_messageConsolePrint.GetValueInt() > 0
	EndFunction 
EndProperty

GlobalVariable Property sr_messageLength auto
int property msgLength
	int Function Get()
		return sr_messageLength.GetValueInt()
	EndFunction
EndProperty

Function DoRegister()
	RegisterForSingleUpdateGameTime(msgInterval)
	inflater.log("Starting messages")
EndFunction

Function StopMessages()
	UnregisterForUpdateGameTime()
EndFunction

Function modMod(int amount)
	chanceMod += amount
EndFunction

Function setMod(int to)
	chanceMod = to
EndFunction

int function getMod()
	return chanceMod
EndFunction

Event OnUpdateGameTime()
	If inflater.player.GetFactionRank(inflater.inflateFaction) >= 20 && Utility.RandomInt(0, 99) < (msgChance + chanceMod)
		If chanceMod > 0
			chanceMod = 0
		EndIf
		ProcessMessage()
	EndIf
	RegisterForSingleUpdateGameTime(msgInterval)
EndEvent

Function ProcessMessage()
	Actor pl = inflater.player
	int sex = inflater.sexlab.GetGender(pl)
	bool vag = inflater.GetVaginalCum(pl) > 0
	bool an = inflater.GetAnalCum(pl) > 0
	int pluggedType = inflater.IsPlugged(pl)
	
	bool plugged = false
	If pluggedType > 0
		If ( vag && ( pluggedType == 1 || pluggedType == 3) ) || ( an && ( pluggedType == 2 || pluggedType == 3) )
			plugged = true
		EndIf 
	EndIf
	
	int type = 0
	If (vag || sex == 0) && an
		type = 3
	ElseIf vag && sex == 1
		type = 1
	Else 
		type = 2
	EndIf
	
	int percent = pl.GetFactionRank(inflater.inflateFaction)
	If (( percent >= 30 && !plugged ) || ( percent >= 80 && plugged )) && Utility.RandomInt(0,99) < 50
		percent -= 10
	EndIf

	String msg = GetMessage(GetPercentage(percent), plugged, type, sex)
	msg = ReplaceTokens(msg, sex)
	If StringUtil.GetLength(msg) >= 4
		display(msg)
	EndIf
EndFunction

String Function GetMessage(int percent, bool plugged, int type, int sex = 1)
	String skey = percent +"."
	If plugged && percent >= 70 && Utility.RandomInt(0, 99) < 40
		skey += "plugged."
	EndIf
	
	
	String keyEither = skey + "either"
	int count = JsonUtil.StringListCount(file, keyEither)
	String[] all = sslUtility.StringArray(count)
	JsonUtil.StringListSlice(file, keyEither, all)
	
	If type == 1 || (type == 3 && sex == 1) ; If it's Vaginal, or it's both AND they have a Vagina
		String keyVag = skey + "vaginal"
		count = JsonUtil.StringListCount(file, keyVag)
		If count > 0
			String[] vagMsg = sslUtility.StringArray(count)
			JsonUtil.StringListSlice(file, keyVag, vagMsg)
			all = sslUtility.MergeStringArray(vagMsg, all)
		EndIf
	EndIf
	
	If type == 2 || type == 3
		String keyAn = skey + "anal"
		count = JsonUtil.StringListCount(file, keyAn)
		If count > 0 
			String[] anMsg = sslUtility.StringArray(count)
			JsonUtil.StringListSlice(file, keyAn, anMsg)
			all = sslUtility.MergeStringArray(anMsg, all)
		EndIf 
	EndIf

	return all[Utility.RandomInt(0, all.length - 1)]
EndFunction

Function display(String msg)
	Int ln = self.msgLength
	Int stringLength = stringutil.GetLength(msg)
	Int parts = math.ceiling(stringLength as Float / ln as Float)
	String[] split = sslutility.StringArray(parts)
	Int n = 0
	if stringutil.Find(msg, " ", 0) == -1
		while n < parts
			split[n] = stringutil.Substring(msg, n * ln, ln)
			n += 1
		endWhile
	else
		Int startIdx = 0
		Int i = ln
		Int lnToUse = ln
		while i < stringLength
			while stringutil.GetNthChar(msg, i) != " " && i < startIdx + ln + 10
				i += 1
			endWhile
			lnToUse = i - startIdx
			split[n] = stringutil.Substring(msg, startIdx, lnToUse)
			startIdx = i + 1
			i += ln
			n += 1
		endWhile
		split[n] = stringutil.Substring(msg, startIdx, 0)
	endIf
	n = parts
	while n > 0
		n -= 1
		debug.Notification(split[n])
		if self.printConsole
			miscutil.printConsole("[FillHerUp] " + split[n])
		endIf
	endWhile
EndFunction

int Function GetPercentage(int original)
	If Original >= 100
		return 100
	ElseIf original >= 80
		return 80
	ElseIf original >= 70
		return 70
	ElseIf original >= 60
		return 60
	ElseIf original >= 50
		return 50
	ElseIf original >= 40
		return 40
	ElseIf original >= 30
		return 30
	ElseIf original >= 20
		return 20
	Else
		return 0
	EndIf
EndFunction

String Function ReplaceTokens(String raw, int sex = 1)
	String result = raw
	int left = StringUtil.Find(result, "[")
	while left > -1
	;	inflater.log("Replacing tokens for: " + raw)
		int right = StringUtil.Find(result, "]", left + 1)
		if right > -1
			String token = StringUtil.Substring(result, left + 1, right - left - 1)
		;	inflater.log("Token: " + token)
			If token == "race"
				token = inflater.player.GetLeveledActorBase().GetRace().GetName()
		;		inflater.log("	" + token)
			ElseIf token == "holes"
				If sex == 0 ; If male
					token = "hole" ; They have one asshole
				EndIf
			ElseIf token == "plugs"
				If sex == 0 ; If male
					token = "plug" ; Only one plug fits
				EndIf
			ElseIf token == "is"
				If sex == 1 ; If female
					token == "are" ; Refer to both holes
				EndIf
			ElseIf token == "s"
				If sex == 1 ; If female
					token == "" ; The verb is plural
				EndIf
			EndIf
			result = StringUtil.Substring(result, 0, left) + token + StringUtil.Substring(result, right + 1, StringUtil.GetLength(result) - right)
		;	inflater.log("Current msg: " + result)
			left = StringUtil.Find(result, "[")
		else
			left = -1
		EndIf
	endWhile
	return result
EndFunction
