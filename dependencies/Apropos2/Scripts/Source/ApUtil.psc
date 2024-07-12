ScriptName ApUtil Hidden

slaUtilScr Function GetSLA() Global
    SlaUtilScr sla = Game.GetFormFromFile(0x4290F, "SexLabAroused.esm") As slaUtilScr
    If !sla
        Error("Unable to find SexLabAroused.esm for formId 0x4290F", "GetSLA")
    EndIf
    Return sla
EndFunction

; Get a more detailed name of an Actor
String Function GetDetailedActorName(Actor actorForm) Global
    If actorForm != None
        Return "[" + actorForm.GetDisplayName() + " \\ " + actorForm + "]"
    Else
        Return "[None]"
    EndIf
EndFunction

SexLabFramework Function GetSexLab() Global
    SexLabFramework sl = Game.GetFormFromFile(0xD62, "SexLab.esm") As SexLabFramework
    If !sl
        Debug.Notification("Could not file SexLab.esm for formId: 0xD62")
    EndIf    
    Return sl
EndFunction

Function SendModEvent(String eventName) Global
    ModEvent.Send(ModEvent.Create(eventName))
EndFunction

Function SendModEventWithForm(String eventName, Form arg) Global
    Int eid = ModEvent.Create(eventName)
    ModEvent.PushForm(eid, arg)
    ModEvent.Send(eid)
EndFunction

Function SendModEventWithBool(String eventName, Bool arg) Global
    Int eid = ModEvent.Create(eventName)
    ModEvent.PushBool(eid, arg)
    ModEvent.Send(eid)
EndFunction

Function SendModEventWithInt(String eventName, Int arg) Global
    Int eid = ModEvent.Create(eventName)
    ModEvent.PushInt(eid, arg)
    ModEvent.Send(eid)
EndFunction

Function SendModEventWithString(String eventName, String arg) Global
    Int eid = ModEvent.Create(eventName)
    ModEvent.PushString(eid, arg)
    ModEvent.Send(eid)
EndFunction

Function Error(String msg, String source = "") Global
    If source
        msg = "Error (" + source + "): " + msg
    Else
	   msg = "Error: " + msg
    EndIf
    Debug.TraceStack(msg)		
	Debug.Notification(msg)
	MiscUtil.PrintConsole(msg)
EndFunction

Int Function RetainedMap() Global
    Int map = JMap.object()
    JValue.retain(map)
    Return map
EndFunction

Int Function RetainedMap1Pair(String key1, String value1) Global
    Int map = RetainedMap()
    JMap.setStr(map, key1, value1)
    return map
EndFunction

Int Function RetainedMap2Pair(String key1, String value1, String key2, String value2) Global
    Int map = RetainedMap1Pair(key1, value1)
    JMap.setStr(map, key2, value2)
    return map
EndFunction

Int Function RetainedMap3Pair(String key1, String value1, String key2, String value2, String key3, String value3) Global
    Int map = RetainedMap2Pair(key1, value1, key2, value2)
    JMap.setStr(map, key3, value3)
    return map
EndFunction

Int Function RetainedMap4Pair(String key1, String value1, String key2, String value2, String key3, String value3, String key4, String value4) Global
    Int map = RetainedMap3Pair(key1, value1, key2, value2, key3, value3)
    JMap.setStr(map, key4, value4)
    return map
EndFunction

Bool Function IsGroupSex(sslBaseAnimation animation) Global
    Return IsMMF(animation) || IsFFM(animation)
EndFunction

Bool Function IsMMF(sslBaseAnimation animation) Global
    Return animation.HasTag("MMF") || animation.HasTag("FMM")
EndFunction

Bool Function IsFFM(sslBaseAnimation animation) Global
    Return animation.HasTag("MFF") || animation.HasTag("FFM")
EndFunction

Bool Function IsCreatureGangBang(sslBaseAnimation animation) Global
    Return IsThreeWayCreature(animation) || IsFourWayCreature(animation) || IsFiveWayCreature(animation)
EndFunction

Bool Function IsThreeWayCreature(sslBaseAnimation animation) Global
    Return animation.HasTag("CCF") || animation.HasTag("FCC")
EndFunction

Bool Function IsFourWayCreature(sslBaseAnimation animation) Global
    Return animation.HasTag("CCCF") || animation.HasTag("FCCC")
EndFunction

Bool Function IsFiveWayCreature(sslBaseAnimation animation) Global
    Return animation.HasTag("CCCCF") || animation.HasTag("FCCCC")
EndFunction

Float Function Lerp(Float x, Float x0, Float x1, Float y0, Float y1) Global
    Float norm = (x - x0) / (x1 - x0)
    Return y0 + ((y1 - y0) * norm)
EndFunction

; Lerp where x0 and y0 == 0
Float Function Lerp0(Float x, Float x1, Float y1) Global
    Return (y1 * (x / x1))
EndFunction

String Function GetGangBangSpecifier(sslBaseAnimation animation)  Global
    ; Two Males
    If animation.HasTag("MMF") || animation.HasTag("FMM")
        Return "MMF"
    ; Three Males
    ElseIf animation.HasTag("MMMF") || animation.HasTag("FMMM")
        Return "MMMF"
    ; Four Males
    ElseIf animation.HasTag("MMMMF") || animation.HasTag("FMMMM")
        Return "MMMMF"
    ; Five Males
    ElseIf animation.HasTag("MMMMMF") || animation.HasTag("FMMMMM")
        Return "MMMMMF"
    ; Six Males
    ElseIf animation.HasTag("MMMMMMF") || animation.HasTag("FMMMMMM")
        Return "MMMMMMF"      
    Else
        Return ""  
    EndIf

EndFunction

String Function GetCurrentLocationName(ObjectReference ref) Global
    Location loc = ref.GetCurrentLocation()
    If loc
        Return RemoveAllSpaces(loc.GetName())
    Else
        Return ""
    EndIf
EndFunction

Actor Function GetVictimFromList(SslThreadController thread, Actor[] actorList) Global
    Int i = 0
    While i < actorList.Length
        Actor test = actorList[i]
        If thread.IsVictim(test) 
            Return test
        EndIf
        i += 1
    EndWhile
    Return None
EndFunction

String Function RemoveAllSpaces(String source) Global
    If !source
        return ""
    EndIf
    String result
    Int ch = 0
    While ch < StringUtil.GetLength(source)
        String current = StringUtil.GetNthChar(source, ch)
        If current != " "
            result += current
        EndIf
        ch += 1
    EndWhile
    Return result
EndFunction 

String Function GetTagsAsString(SslBaseAnimation animation) Global
    String[] tags = animation.GetTags()
    Return StringArrayToString(tags)
EndFunction

String Function StringArrayToString(String[] values) Global
    String result = ""
    Int i = 0
    While i < values.Length
        If values[i]
            result = result + values[i]
            If i < values.Length - 1
                result = result + ","
            EndIf
        EndIf
        i=i+1
    EndWhile
    Return result
EndFunction

String Function GetGenderName(Int index) Global
    If index == 0
        Return "Male"
    ElseIf index == 1
        Return "Female"
    Else
        Return "Creature"
    EndIf
EndFunction

String Function StringIfElse(Bool isTrue, String returnTrue, String returnFalse = "") Global
    If isTrue
        Return returnTrue
    Else
        Return returnFalse
    EndIf
EndFunction

Int Function IntIfElse(Bool isTrue, Int returnTrue, Int returnFalse) Global
    If isTrue
        Return returnTrue
    Else
        Return returnFalse
    EndIf
EndFunction

Actor Function GetFirstActor(Actor[] list, Actor excluding) Global
    Int i = 0
    While i < list.Length
        Actor anActor = list[i]
        If anActor != excluding
            Return anActor
        EndIf
        i += 1
    EndWhile
EndFunction

Bool Function IsLesbianSex(SslBaseAnimation animation, Actor[] actorList) Global
    Int i = actorList.Length

    If i == 1
        Return False
    EndIf

    If animation.HasTag("FF")
        Return True
    EndIf    

    While i > 0
        i -= 1
        If GetSexLab().GetGender(actorList[i]) != 1
            Return False
        EndIf
    EndWhile
    
    Return True
EndFunction

Bool Function IsGaySex(SslBaseAnimation animation, Actor[] actorList) Global
    Int i = actorList.Length

    If i == 1
        Return False
    EndIf

    If animation.HasTag("MM")
        Return True
    EndIf

    While (i > 0)
        i -= 1
        If GetSexLab().GetGender(actorList[i]) != 0
            Return False
        EndIf
    EndWhile
    
    Return True
EndFunction

String[] Function ParseStringToArray(string stringList, string delimiter = ";") Global
    String[] result
    int delimiterLen = StringUtil.GetLength(delimiter)   
    int index = 1
    if stringList == ""    ;invalid input
        return result
    EndIf
    
    ;count number of elements in the string
    int offset = 0
    offset = StringUtil.Find(stringList, delimiter)
    While offset != -1
        index += 1
        offset = StringUtil.Find(stringList, delimiter, offset + delimiterLen)
    EndWhile
    ;create the return string array
    result = Utility.CreateStringArray(index)
    
    ;fill the array with values
    index = 0   
    While StringUtil.GetLength(stringList)
        offset = StringUtil.Find(stringList, delimiter)
        if offset == 0 ;a little weirdness here because asking Substring to return 0 length actually returns entire to string end
            result[index] = ""
        Else
            result[index] = StringUtil.Substring(stringList, 0, offset + delimiterLen) 
        EndIf
        If offset == -1
            stringList = ""
        Else
            stringList = StringUtil.Substring(stringList, offset + delimiterLen)
        EndIf
        index += 1
    EndWhile
    
    return result
EndFunction

Bool Function CheckFileExists(String fullPath) Global
    If !JContainers.fileExistsAtPath(fullPath)
        String msg = "Could not find or read file '" + fullPath + "'"
        MiscUtil.PrintConsole(msg)
        Debug.TraceUser("Apropos2", msg)
        Return False
    EndIf
    Return True
EndFunction

String[] Function Strings(String val1, String val2 = "", String val3 = "", String val4 = "", String val5 = "", String val6 = "", String val7 = "", String val8 = "") Global
    If !val2
        String[] ar = SslUtility.StringArray(1)
        ar[0] = val1
        return ar
    EndIf
    If !val3
        String[] ar = SslUtility.StringArray(2)
        ar[0] = val1
        ar[1] = val2
        return ar
    EndIf
    If !val4
        String[] ar = SslUtility.StringArray(3)
        ar[0] = val1
        ar[1] = val2
        ar[2] = val3
        return ar
    EndIf
    If !val5
        String[] ar = SslUtility.StringArray(4)
        ar[0] = val1
        ar[1] = val2
        ar[2] = val3
        ar[3] = val4
        return ar
    EndIf
    If !val6
        String[] ar = SslUtility.StringArray(5)
        ar[0] = val1
        ar[1] = val2
        ar[2] = val3
        ar[3] = val4
        ar[4] = val5
        return ar
    EndIf
    If !val7
        String[] ar = SslUtility.StringArray(6)
        ar[0] = val1
        ar[1] = val2
        ar[2] = val3
        ar[3] = val4
        ar[4] = val5
        ar[5] = val6
        return ar
    EndIf
    If !val8
        String[] ar = SslUtility.StringArray(7)
        ar[0] = val1
        ar[1] = val2
        ar[2] = val3
        ar[3] = val4
        ar[4] = val5
        ar[5] = val6
        ar[6] = val7
        return ar
    EndIf     
EndFunction

String[] Function CreateStringArray1(String val1) Global
    String[] values = New String[1]
    values[0] = val1
    Return values
EndFunction

String[] Function CreateStringArray2(String val1, String val2) Global
    String[] values = New String[2]
    values[0] = val1
    values[1] = val2
    Return values
EndFunction

String[] Function CreateStringArray3(String val1, String val2, String val3) Global
    String[] values = New String[3]
    values[0] = val1
    values[1] = val2
    values[2] = val3
    Return values
EndFunction

String[] Function CreateStringArray4(String val1, String val2, String val3, String val4) Global
    String[] values = New String[4]
    values[0] = val1
    values[1] = val2
    values[2] = val3
    values[3] = val4
    Return values
EndFunction

String[] Function CreateStringArray5(String val1, String val2, String val3, String val4, String val5) Global
    String[] values = New String[5]
    values[0] = val1
    values[1] = val2
    values[2] = val3
    values[3] = val4
    values[4] = val5
    Return values
EndFunction

String[] Function CreateStringArray6(String val1, String val2, String val3, String val4, String val5, String val6) Global
    String[] values = New String[6]
    values[0] = val1
    values[1] = val2
    values[2] = val3
    values[3] = val4
    values[4] = val5
    values[5] = val6
    Return values
EndFunction

String[] Function CreateStringArray7(String val1, String val2, String val3, String val4, String val5, String val6, String val7) Global
    String[] values = New String[7]
    values[0] = val1
    values[1] = val2
    values[2] = val3
    values[3] = val4
    values[4] = val5
    values[5] = val6
    values[6] = val7
    Return values
EndFunction

String[] Function CreateStringArray8(String val1, String val2, String val3, String val4, String val5, String val6, String val7, String val8) Global
    String[] values = New String[8]
    values[0] = val1
    values[1] = val2
    values[2] = val3
    values[3] = val4
    values[4] = val5
    values[5] = val6
    values[6] = val7
    values[7] = val8
    Return values
EndFunction

String[] Function CreateTestWords() Global
    String[] words = SslUtility.StringArray(50)
    words[0] = "Donec"
    words[1] = "euismod"
    words[2] = "urna"
    words[3] = "at"
    words[4] = "semper"
    words[5] = "aliquam"
    words[6] = "turpis"
    words[7] = "tortor"
    words[8] = "interdum"
    words[9] = "est"

    words[10] = "eu"
    words[11] = "condimentum"
    words[12] = "dui"
    words[13] = "tortor"
    words[14] = "at"
    words[15] = "felis"
    words[16] = "turpis"
    words[17] = "Vivamus"
    words[18] = "ac"
    words[19] = "cursus"

    words[20] = "leo"
    words[21] = "Morbi"
    words[22] = "ut"
    words[23] = "justo"
    words[24] = "ut"
    words[25] = "tortor"
    words[26] = "molestie"
    words[27] = "vestibulum"
    words[28] = "at"
    words[29] = "at"

    words[30] = "mauris"
    words[31] = "Phasellus"
    words[32] = "odio"
    words[33] = "odio"
    words[34] = "placerat"
    words[35] = "sed"
    words[36] = "consequat"
    words[37] = "a"
    words[38] = "sollicitudin"
    words[39] = "ut"

    words[40] = "Fusce"
    words[41] = "purus"
    words[42] = "ante"
    words[43] = "eros"
    words[44] = "scelerisque"
    words[45] = "risus"
    words[46] = "Etiam"
    words[47] = "convallis"
    words[48] = "Proin"
    words[49] = "sodales"    

    return words
EndFunction

String[] Function DummyArray() Global
    String[] result = SslUtility.StringArray(1)
    result[0] = ""
    Return result
EndFunction

Int Function Min(Int val1, Int val2) Global
    If val1 < val2 
        Return val1
    EndIf
    Return val2
EndFunction

Int Function Max(Int val1, Int val2) Global
    If val1 > val2 
        Return val1
    EndIf
    Return val2
EndFunction

Int Function Max3(Int val1, Int val2, Int val3) Global 
    Int max1 = Max(val1, val2)
    Return Max(max1, val3)
EndFunction

Int Function Min3(Int val1, Int val2, Int val3) Global 
    Int min1 = Min(val1, val2)
    Return Min(min1, val3)
EndFunction

Int Function Max4(Int val1, Int val2, Int val3, Int val4) Global 
    Int max1 = Max(val1, val2)
    Int max2 = Max(val3, val4)
    Return Max(max1, max2)
EndFunction

Int Function Min4(Int val1, Int val2, Int val3, Int val4) Global
    Int min1 = Min(val1, val2)
    Int min2 = Min(val3, val4)
    Return Min(min1, min2)
EndFunction

Int Function Average3(Int val1, Int val2, Int val3) Global
    Int average = Math.Ceiling(((val1 As Float) + (val2 As Float) + (val3 As Float)) / 3.0)
    Return average
EndFunction

Int Function Average2(Int val1, Int val2) Global
    Int average = Math.Ceiling(((val1 As Float) + (val2 As Float)) / 2.0)
    Return average
EndFunction

String Function Substring(String source, Int startIndex, Int len) Global
    If len == 0
        Return ""
    Else
        Return StringUtil.Substring(source, startIndex, len)
    EndIf
EndFunction

String Function TrimEnd(String source) Global
    Int len = StringUtil.GetLength(source)
    If (StringUtil.GetNthChar(source, len - 1) == " ")
        Return Substring(source, 0, len  - 1)
    Else
        Return source
    EndIf
EndFunction

Bool Function InMalePosition(SslThreadController thread, Actor anActor) Global
    Int pos = thread.GetPosition(anActor)
    Return thread.Animation.MalePosition(pos)
EndFunction

Int Function GetIndexOfMalePosition(SslThreadController thread, Actor[] actorList) Global
    Int i = 0
    While i < actorList.Length
        Actor anActor = actorList[i]
        If InMalePosition(thread, anActor)
            Return i
        EndIf
        i += 1
    EndWhile
    Return -1
EndFunction

Bool Function IsDremoraOrDaedricCreature(String s) Global
    Return s == "Dremora" || s == "DremoraRace" || s == "Lurker" || s == "Seeker"
EndFunction

Bool Function IsDremora(Actor anActor) Global
    String raceName = GetRaceName(anActor)
    Return StringContains(raceName, "Dremora")
EndFunction

Bool Function IsOrc(Actor anActor) Global
    If anActor
        Race rc = anActor.GetRace()
        If rc
            String raceName = rc.GetName()
            return IsOrcRace(raceName)
        EndIf
    EndIf
    Return False    
EndFunction

Bool Function IsOrcRace(String raceName) Global
    Return StringContains(raceName, "orc") || StringContains(raceName, "Orc")
EndFunction

Int Function d100() Global
    Return Utility.RandomInt(1, 100)
EndFunction

String Function GetRaceName(Actor anActor) Global
    If !anActor
        Return ""
    EndIf
    
    Race rc = anActor.GetRace()
    If rc
        Return rc.GetName()
    EndIf
EndFunction

Bool Function StringContains(String source, String toFind) Global
    Return StringUtil.Find(source, toFind) >= 0
EndFunction

Function UpdateActorArousalExposure(Actor anActor, Float amount = 2.0) Global
    Int eid = ModEvent.Create("slaUpdateExposure")
    ModEvent.PushForm(eid, anActor)
    ModEvent.PushFloat(eid, amount)
    ModEvent.Send(eid)
EndFunction