Scriptname _SLS_IntDevious Hidden 

Function DoMoan(Quest libsQuest, Actor akTarget) Global
	(libsQuest as zadlibs).Moan(akTarget)
EndFunction

Function EquipDevice(Actor akActor, Armor deviceInventory, Quest libsQuest) Global
	zadlibs libs = libsQuest as zadlibs
	libs.EquipDevice(akActor, deviceInventory, libs.GetRenderedDevice(deviceInventory), libs.GetDeviceKeyword(deviceInventory))
	;EquipDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool skipEvents=false, bool skipMutex=false)
EndFunction

Function RemoveDevice(Actor akActor, Armor deviceInventory, Quest libsQuest) Global
	zadlibs libs = libsQuest as zadlibs
	libs.RemoveDevice(akActor, deviceInventory, libs.GetRenderedDevice(deviceInventory), libs.GetDeviceKeyword(deviceInventory), true)
	;RemoveDevice(actor akActor, armor deviceInventory, armor deviceRendered, keyword zad_DeviousDevice, bool destroyDevice=false, bool skipEvents=false, bool skipMutex=false)
EndFunction

Armor Function GetWornDeviceByKeyword(Actor akActor, Keyword kw, Quest libsQuest) Global
	Return (libsQuest as zadlibs).GetWornDeviceFuzzyMatch(akActor, kw)
EndFunction

Keyword Function GetDeviceKeyword(armor Device, Quest libsQuest) Global
	Return (libsQuest as zadlibs).GetDeviceKeyword(Device)
EndFunction

Armor Function GetRenderedDevice(Armor Device, Quest libsQuest) Global
	Return (libsQuest as zadlibs).GetRenderedDevice(Device)
EndFunction

Key Function GetDeviceKey(Quest libsQuest, Armor Device) Global
	Return (libsQuest as zadlibs).GetDeviceKey(Device)
EndFunction

Function CatchBreath(Actor akTarget, Quest libsQuest) Global
	(libsQuest as zadlibs).CatchBreath(akTarget)
EndFunction

Function PlayThirdPersonAnimation(Actor akActor, String Animation, Int Duration, Bool PermitRestrictive = false, Quest libsQuest) Global
	(libsQuest as zadlibs).PlayThirdPersonAnimation(akActor, Animation, Duration, PermitRestrictive = false)
EndFunction

Int Function VibrateEffect(Quest libsQuest, actor akActor, int vibStrength, int duration, bool teaseOnly = false, bool silent = false) Global
	Return (libsQuest as zadlibs).VibrateEffect(akActor, vibStrength, duration, teaseOnly, silent)
EndFunction
