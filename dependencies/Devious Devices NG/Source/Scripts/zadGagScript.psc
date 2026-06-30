Scriptname zadGagScript extends zadEquipScript
Message Property callForHelpMsg Auto
Message Property zad_GagPreEquipMsg Auto
Message Property zad_GagEquipMsg Auto
Message Property zad_GagRemovedMsg Auto
Message Property zad_GagPickLockFailMsg Auto
Message Property zad_GagPickLockSuccessMsg Auto
Message Property zad_GagArmsTiedMsg Auto
Message Property zad_GagBruteForceArmsTiedMsg Auto
Message Property zad_GagBruteForceMsg Auto
import MfgConsoleFunc

Function OnEquippedPre(actor akActor, bool silent=false)
	if !silent
		if akActor == libs.PlayerRef
			zad_GagEquipMsg.Show()
		Else
			libs.NotifyActor("You slip the gag into "+GetMessageName(akActor)+" mouth, and lock it securely in place behind "+GetMessageName(akActor)+" head.", akActor, true)
		EndIf
	EndIf
	Parent.OnEquippedPre(akActor, silent)
EndFunction

Function DeviceMenuExt(int msgChoice)
	if msgChoice == 3
		libs.Moan(libs.PlayerRef)
		callForHelpMsg.Show()
	EndIf
EndFunction

Function OnRemoveDevice(actor akActor)
	libs.RemoveGagEffect(akActor)
	if !libs.IsAnimating(akActor)
		akActor.ClearExpressionOverride()
		ResetPhonemeModifier(akActor)
	EndIf
EndFunction

Function OnEquippedPost(actor akActor)
	libs.ApplyGagEffect(akActor)
EndFunction
