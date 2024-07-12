Scriptname MME_zbf extends Quest Hidden

Event OnInit()
	StorageUtil.SetIntValue(none,"MME.PluginsCheck.zbf",2)
EndEvent

bool Function IsIntegraged ()
	Return True
EndFunction

bool Function IsWearingZaZGag_Open (Actor akActor)	;oral permitted
	zbfBondageShell zbf = Quest.GetQuest("zbf") as zbfBondageShell
	Return akActor.WornHasKeyword(zbf.zbfWornPermitOral)
EndFunction

bool Function IsWearingZaZGag (Actor akActor)
	zbfBondageShell zbf = Quest.GetQuest("zbf") as zbfBondageShell
	Return akActor.WornHasKeyword(zbf.zbfWornGag)
EndFunction