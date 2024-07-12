Scriptname MME_ineed extends Quest Hidden

Event OnInit()
	StorageUtil.SetIntValue(none,"MME.PluginsCheck.ineed",1)
EndEvent

bool Function IsIntegraged ()
	Return False
EndFunction

Function iNeedfoodlistaddon()
	debug.Trace("MilkModEconomy iNeed options is not installed")
EndFunction