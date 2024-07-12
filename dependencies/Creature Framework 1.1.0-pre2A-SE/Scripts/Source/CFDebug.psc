Scriptname CFDebug
{Debugging methods | Creature Framework}

; Send a debug message to the Papyrus log and the console if debugging is enabled
function Log(string _message) global
	CFConfigMenu config = CreatureFrameworkUtil.GetConfig()
	if config.DbgOutputLog
		Debug.Trace("[CF]" + _message)
	endIf
	if config.DbgOutputConsole
		MiscUtil.PrintConsole("[CF]" + _message)
	endIf
endFunction
