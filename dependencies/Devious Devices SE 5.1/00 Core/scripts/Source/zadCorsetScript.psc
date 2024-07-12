Scriptname zadCorsetScript extends zadEquipScript  

Function OnEquippedPre(actor akActor, bool silent=false)
	if !silent
		libs.NotifyActor("You pull the corset around "+GetMessageName(akActor)+" waist, and lock it in the back.", akActor, true)
	EndIf	
	Parent.OnEquippedPre(akActor, silent)
EndFunction


int Function OnEquippedFilter(actor akActor, bool silent=false)
	if akActor == none
		akActor == libs.PlayerRef
	EndIf
	if ! akActor.IsEquipped(deviceRendered)		
		if akActor.WornHasKeyword(libs.zad_DeviousHarness)
			MultipleItemFailMessage("Harness")
			return 2
		Endif
	Endif
	return 0
EndFunction

Function OnEquippedPost(actor akActor)
	libs.Log("RestraintScript OnEquippedPost Corset")
EndFunction
