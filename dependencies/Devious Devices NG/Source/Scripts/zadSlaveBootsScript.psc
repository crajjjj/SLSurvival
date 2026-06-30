Scriptname zadSlaveBootsScript extends zadEquipScript  

Function OnEquippedPre(actor akActor, bool silent=false)
	if !silent
		libs.NotifyActor("You place the "+deviceName+" onto "+GetMessageName(akActor)+" feet, and they lock in place with a soft click.", akActor, true)
	EndIf
	Parent.OnEquippedPre(akActor, silent)
EndFunction


int Function OnEquippedFilter(actor akActor, bool silent=false)
	if SKSE.GetPluginVersion("NiOverride") < 5 && SKSE.GetPluginVersion("skee") < 1 || NiOverride.GetScriptVersion() < 5
    		libs.NotifyPlayer("This device ("+deviceName+") requires NetImmerse Override, which you do not have installed.", true)
		return 2
	EndIf
	return 0
EndFunction
