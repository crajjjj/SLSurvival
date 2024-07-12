Scriptname _SLS_FashionRape extends Quest  

Event OnInit()
	If Self.IsRunning()
		If StorageUtil.GetFloatValue(None, "yps_TweakVersion", Missing = -1.0) >= 1.0
			RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
			;RegisterForKey(35)
		Else
			Self.Stop() ; Restarted in Main if yps_IF is later installed
		EndIf
	EndIf
EndEvent

Event OnKeyDown(Int KeyCode) ; Debugging only
	If !Utility.IsInMenuMode()
		CutHair()
		;DyeHair()
		;SmudgeLipstick()
		;SmudgeEyeshadow()
		;ShavePussy()
		
		;OnAnimationEnd(tid = 0, HasPlayer = true)
		
		;Debug.Messagebox("FashionAddictionBuffLevel: " + StorageUtil.GetIntValue(None, "yps_FashionAddictionLevel"))
	EndIf
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer && Sexlab.IsVictim(tid, PlayerRef)
		Actor[] SexActors = SexLab.HookActors(tid as string)
		If SexActors.Length > 1 && Sexlab.CreatureCount(SexActors) == 0
			If !HasFashionRapeExclusion(SexActors)
				If ShouldCutHair()
					CutHair()
				EndIf
				If ShouldDyeHair()
					DyeHair()
				EndIf
				If ShouldSmudgeLipstick()
					SmudgeLipstick()
				EndIf
				If ShouldSmudgeEyeshadow()
					SmudgeEyeshadow()
				EndIf
				If ShouldShavePussy()
					ShavePussy()
				EndIf
			EndIf
		EndIf
	EndIf
EndEvent

Bool Function ShouldCutHair()
	;Debug.Messagebox("YpsCurrentHairLengthStage: " + StorageUtil.GetIntValue(None, "YpsCurrentHairLengthStage", Missing = -1) + "\nHaircutFloor: " + HaircutFloor)
	If StorageUtil.GetIntValue(None, "YpsCurrentHairLengthStage", Missing = -1) > HaircutFloor && HaircutChance > Utility.RandomFloat(0.0, 100.0)
		Return true
	EndIf
	Return false
EndFunction

Bool Function ShouldShavePussy()
	If Sos.HasPubicHair(PlayerRef) && ShavePussyChance > Utility.RandomFloat(0.0, 100.0)
		Return true
	EndIf
	Return false
EndFunction

Bool Function ShouldSmudgeLipstick()
	If !StorageUtil.GetIntValue(None, "yps_LipstickSmudged") == 1 && SmudgeLipstickChance > Utility.RandomFloat(0.0, 100.0)
		Return true
	EndIf
	Return false
EndFunction

Bool Function ShouldSmudgeEyeshadow()
	If !StorageUtil.GetIntValue(None, "yps_EyeShadowSmudged") == 1 && SmudgeEyeshadowChance > Utility.RandomFloat(0.0, 100.0)
		Return true
	EndIf
	Return false
EndFunction

Bool Function ShouldDyeHair()
	If DyeHairChance > Utility.RandomFloat(0.0, 100.0)
		Return true
	EndIf
	Return false
EndFunction

Function SmudgeLipstick()
	Int i = Utility.RandomInt(0, JsonUtil.IntListCount("SL Survival/ImmersiveFashion.json", "lipstickcolors") - 1)
	;String ColorString = JsonUtil.StringListGet("SL Survival/ImmersiveFashion.json", "lipstickcolors", i)
	;Int ColorInt = JsonUtil.IntListGet("SL Survival/ImmersiveFashion.json", "lipstickcolors", i)
	Int Lipstick = ModEvent.Create("yps-LipstickTweakedEvent")
    If (Lipstick)
		ModEvent.PushString(Lipstick, JsonUtil.StringListGet("SL Survival/ImmersiveFashion.json", "lipstickcolors", i))
        ModEvent.PushInt(Lipstick, JsonUtil.IntListGet("SL Survival/ImmersiveFashion.json", "lipstickcolors", i))       
		ModEvent.PushString(Lipstick, "Smudged")
        ModEvent.Send(Lipstick)
    EndIf
	Debug.Notification("Laughing & jeering they smear my lips with " + JsonUtil.StringListGet("SL Survival/ImmersiveFashion.json", "lipstickcolors", i) + " lipstick")
EndFunction

Function SmudgeEyeshadow()
	Int i = Utility.RandomInt(0, JsonUtil.IntListCount("SL Survival/ImmersiveFashion.json", "eyeshadowcolors") - 1)
	Int Eyeshadow = ModEvent.Create("yps-EyeshadowTweakedEvent")
    If (Eyeshadow)
		ModEvent.PushString(Eyeshadow, JsonUtil.StringListGet("SL Survival/ImmersiveFashion.json", "eyeshadowcolors", i))
        ModEvent.PushInt(Eyeshadow, JsonUtil.IntListGet("SL Survival/ImmersiveFashion.json", "eyeshadowcolors", i))       
		ModEvent.PushString(Eyeshadow, "Smudged")
        ModEvent.Send(Eyeshadow)
    EndIf
	Debug.Notification("Laughing & jeering they smear my eyes with " + JsonUtil.StringListGet("SL Survival/ImmersiveFashion.json", "eyeshadowcolors", i) + " eyeshadow")
EndFunction

Function ShavePussy()
	SendModEvent("yps-SetPubicHairLengthEvent", strArg = "", numArg = 0.0)
	Debug.Notification("Laughing & jeering they shave my little pussy bald")
EndFunction

Function DyeHair()
	Int i = Utility.RandomInt(0, JsonUtil.IntListCount("SL Survival/ImmersiveFashion.json", "haircolors") - 1)
	SendModEvent("yps-HairColorDyeEvent", strArg = JsonUtil.StringListGet("SL Survival/ImmersiveFashion.json", "haircolors", i), numArg =JsonUtil.IntListGet("SL Survival/ImmersiveFashion.json", "haircolors", i))
	Debug.Notification("The bastards carelessly dye my hair " + JsonUtil.StringListGet("SL Survival/ImmersiveFashion.json", "haircolors", i))
EndFunction

Function CutHair()
	Float HairStage = StorageUtil.GetIntValue(none, "YpsCurrentHairLengthStage", Missing = 0) as Float
	If HairStage > 0
		HairStage = HairStage - Utility.RandomInt(HairCutMinLevel, HairCutMaxLevel)
		If HairStage < HaircutFloor
			HairStage = HaircutFloor
		EndIf
		SendModEvent("yps-SetHaircutEvent", strArg = "", numArg = HairStage)
		Debug.Notification("Ow! They hold me down while they roughly cut my beautiful hair")
	EndIf
	;/ Grow hair
	Float HairStage = StorageUtil.GetIntValue(none, "YpsCurrentHairLengthStage", Missing = 0) as Float
	SendModEvent("yps-SetHaircutEvent", strArg = "", numArg = HairStage + 1.0)
	/;
EndFunction

Bool Function HasFashionRapeExclusion(Actor[] SexActors)
	Int i = SexActors.Length
	While i > 0
		i -= 1
		If StorageUtil.FormListFind(None, "_SLS_FashionRapeExclusions", SexActors[i]) > -1
			Return true
		EndIf
	EndWhile
	Return false
EndFunction

;StorageUtil.SetIntValue(none, "YpsCurrentHairLengthStage", NewStage)

Float Property HaircutChance = 4.0 Auto Hidden
Float Property ShavePussyChance = 10.0 Auto Hidden
Float Property SmudgeLipstickChance = 20.0 Auto Hidden
Float Property SmudgeEyeshadowChance = 20.0 Auto Hidden
Float Property DyeHairChance = 2.0 Auto Hidden

Int Property HaircutMinLevel = 1 Auto Hidden
Int Property HaircutMaxLevel = 3 Auto Hidden
Int Property HaircutFloor = 1 Auto Hidden

Actor Property PlayerRef Auto

_SLS_InterfaceSos Property Sos Auto
SexlabFramework Property Sexlab Auto
