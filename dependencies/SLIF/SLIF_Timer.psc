Scriptname SLIF_Timer extends Quest

Function initializeTimer(float time)
	RegisterForModEvent("HookOrgasmStart", "OnOrgasmStart")
	RegisterForModEvent("SexLabOrgasmSeparate", "OnOrgasmSeparate")
	RegisterForSingleUpdateGameTime(time)
EndFunction

Function uninstallTimer()
	UnregisterForModEvent("HookOrgasmStart")
	UnregisterForModEvent("SexLabOrgasmSeparate")
	UnregisterForUpdateGameTime()
endFunction

Event OnUpdateGameTime()
	if (StorageUtil.GetIntValue(none, "slif_timer_active") as bool)
		UpdateScrotum()
		RegisterForSingleUpdateGameTime(0.1)
	else
		ResetScrotum()
	endIf
EndEvent

Event OnOrgasmStart(int thread, bool hasPlayer)
	if (hasPlayer)
		DeflateScrotum()
	endIf
EndEvent

Event OnOrgasmSeparate(Form ActorRef, Int thread)
	Actor kActor = ActorRef as Actor
	if (kActor == Game.GetPlayer())
		DeflateScrotum()
	endIf
EndEvent

Function UpdateScrotum()
	; Get the current game time
	float time = Utility.GetCurrentGameTime()
	int day = (time as int)
	time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
	time *= 24 ; Convert from fraction of a day to number of hours
	int hour = (time as int)
	float minutes = time - (hour)
	minutes *= 60
	int minute = (minutes as int)
	float seconds = minutes - (minute)
	seconds *= 60
	int second = (seconds as int)
	InflateScrotum(day, hour)
EndFunction

Function InflateScrotum(int day, int hour)
	Actor kActor            = Game.GetPlayer()
	String name             = SLIF_Util.GetActorName(kActor)
	String aToString        = SLIF_Util.ActorToString(kActor, name)
	int currentHour         = StorageUtil.GetIntValue(kActor, "slif_hour", hour)
	int hoursWithoutCumming = StorageUtil.GetIntValue(kActor, "slif_hours_without_cumming", 0)
	float updates           = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_updates", 0.1)
	float update            = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_update",  1.0)
	bool doit               = false
	if (StorageUtil.HasFloatValue(kActor, "slif_inflate_scrotum_updates"))
		updates += 0.1
	else
		doit = true
	endIf
	StorageUtil.SetFloatValue(kActor, "slif_inflate_scrotum_updates", updates)
	
	if (StorageUtil.HasFloatValue(kActor, "slif_inflate_scrotum_min") == false)
		StorageUtil.SetFloatValue(kActor, "slif_inflate_scrotum_min", 1.0)
	endIf
	if (StorageUtil.HasFloatValue(kActor, "slif_inflate_scrotum_max") == false)
		StorageUtil.SetFloatValue(kActor, "slif_inflate_scrotum_max", 2.0)
	endIf
	if (StorageUtil.HasFloatValue(kActor, "slif_inflate_scrotum_absolute_max") == false)
		StorageUtil.SetFloatValue(kActor, "slif_inflate_scrotum_absolute_max", 10.0)
	endIf
	
	string mod   = "SLIF Scrotum"
	String node  = "NPC GenitalsScrotum [GenScrot]"
	
	float value      = StorageUtil.GetFloatValue(kActor, mod + node,            1.0)
	float minimum    = StorageUtil.GetFloatValue(kActor, mod + node + "_min",   0.0)
	float maximum    = StorageUtil.GetFloatValue(kActor, mod + node + "_max", 100.0)
	
	float scale       = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum",               0.01)
	float scaleMin    = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_min",           1.0)
	float scaleMax    = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_max",           2.0)
	float scaleAbsMax = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_absolute_max", 10.0)
	
	if (updates >= update)
		
		StorageUtil.SetFloatValue(kActor, "slif_inflate_scrotum_updates", 0.0)
		
		hoursWithoutCumming += 1
		StorageUtil.SetIntValue(kActor, "slif_hours_without_cumming", hoursWithoutCumming)
		StorageUtil.SetIntValue(kActor, "slif_hour", hour)
		
		if (minimum > scaleMin)
			SLIF_Util.SetFloatValue(kActor, mod, node, scaleMin, "_min")
			minimum = scaleMin
		endIf
		if (maximum < scaleMax)
			SLIF_Util.SetFloatValue(kActor, mod, node, scaleMax, "_max")
			maximum = scaleMax
		endIf
		
		if (StorageUtil.HasFloatValue(kActor, "slif_current_scrotum") == false)
			StorageUtil.SetFloatValue(kActor, "slif_current_scrotum", scaleMin)
		endIf
		if (StorageUtil.HasFloatValue(kActor, "slif_current_scrotum_new") == false)
			StorageUtil.SetFloatValue(kActor, "slif_current_scrotum_new", scaleMin)
		endIf
					
		if (StorageUtil.HasIntValue(kActor, "slif_day") == false)
			StorageUtil.SetIntValue(kActor, "slif_day", day)
		endIf
		int currentDays = StorageUtil.GetIntValue(kActor, "slif_day")
		if (StorageUtil.HasIntValue(kActor, "slif_days_without_cumming") == false)
			StorageUtil.SetIntValue(kActor, "slif_days_without_cumming", 0)
		endIf
		int daysWithoutCumming = StorageUtil.GetIntValue(kActor, "slif_days_without_cumming")
		if (currentDays != day)
			
			daysWithoutCumming = daysWithoutCumming + 1
			StorageUtil.SetIntValue(kActor, "slif_days_without_cumming", daysWithoutCumming)
			StorageUtil.SetIntValue(kActor, "slif_day", day)
			
			float currentValueNew = StorageUtil.GetFloatValue(kActor, "slif_current_scrotum_new")
			float difference      = (scaleMax - currentValueNew) as float
			float newMaxScale     = (scaleMax + 1.0) as float
			
			if (difference <= 1.0)
				if (newMaxScale <= maximum)
					scaleMax = scaleMax + 1.0
					StorageUtil.SetFloatValue(kActor, "slif_inflate_scrotum_max", scaleMax)
				endIf
			endIf
		endIf
		
		if ((value + scale) < scaleMax)
			value = value + scale
		else
			value = scaleMax
		endIf
		
		StorageUtil.SetFloatValue(kActor, "slif_current_scrotum_new", value)
		
		if (value < scaleMin)
			value = scaleMin
		endIf
		
		doit = true
	endIf
	
	if (doit)
		SLIF_Main.inflate(kActor, mod, node, value)
		SLIF_Debug.Trace("[SLIF_Timer] Inflating Scrotum:   " + aToString + ", value: " + value + ", scale: " + scale + ", min: " + scaleMin + ", max: " + scaleMax + ", day: " + day + ", hour: " + hour)
	endIf
EndFunction

Function DeflateScrotum()
	Actor kActor   = Game.GetPlayer() as Actor
	string mod     = "SLIF Scrotum"
	String node    = "NPC GenitalsScrotum [GenScrot]"
	float value    = StorageUtil.GetFloatValue(kActor, mod + node, 1.0)
	float scale    = StorageUtil.GetFloatValue(kActor, "slif_deflate_scrotum",          0.5)
	float scaleMin = StorageUtil.GetFloatValue(kActor, "slif_inflate_scrotum_min",      1.0)
	if (value > scaleMin)
		float temp = value - scaleMin
		if (temp >= scale)
			value = value - scale
		else
			value = scaleMin
		endIf
		SLIF_Main.inflate(kActor, mod, node, value)
		SLIF_Debug.Trace("[SLIF_Timer] Deflating Scrotum!")
	endIf
EndFunction

Function ResetScrotum()
	Actor kActor = Game.GetPlayer() as Actor
	string mod   = "SLIF Scrotum"
	String node  = "NPC GenitalsScrotum [GenScrot]"
	if (StorageUtil.HasFloatValue(kActor, "slif_current_scrotum"))
		float value  = StorageUtil.GetFloatValue(kActor, "slif_current_scrotum")
		SLIF_Main.inflate(kActor, mod, node, value)
		StorageUtil.UnsetFloatValue(kActor, "slif_current_scrotum")
		SLIF_Debug.Trace("[SLIF_Timer] Resetting Scrotum!")
	endIf
EndFunction
