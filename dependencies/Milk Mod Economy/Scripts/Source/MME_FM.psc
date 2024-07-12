Scriptname MME_FM extends Quest Hidden

Event OnInit()
	StorageUtil.SetIntValue(none,"MME.PluginsCheck.fm",1)
EndEvent

bool Function IsIntegraged ()
	Return False
EndFunction

bool Function IsPregnant (Actor akActor)
	Return False
EndFunction