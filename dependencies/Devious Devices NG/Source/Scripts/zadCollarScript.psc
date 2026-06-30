Scriptname zadCollarScript extends zadRestraintScript  

Function OnEquippedPre(actor akActor, bool silent=false)
	if !silent
		libs.NotifyActor("You slip the collar around "+GetMessageName(akActor)+" neck, and it locks in place with a soft click.", akActor, true)
	EndIf
	Parent.OnEquippedPre(akActor, silent)
EndFunction

