Scriptname zadPiercingVaginalScript extends zadRestraintScript  

string strFailEquipBelt =  "The belt you are wearing prevents you from inserting this piercing."
string strFailEquipHarness =  "The harness you are wearing prevents you from inserting this piercing."


int Function OnEquippedFilter(actor akActor, bool silent=false)
	if akActor == none
		akActor == libs.PlayerRef
	EndIf
	if !akActor.IsEquipped(deviceRendered)
		if akActor!=libs.PlayerRef && ShouldEquipSilently(akActor)
			libs.Log("Avoiding FTM duplication bug (Vaginal Piercings).")
			return 0
		EndIf
		if akActor.WornHasKeyword(libs.zad_DeviousHarness)
			if akActor == libs.PlayerRef && !silent
				libs.NotifyActor(strFailEquipHarness, akActor, true)
			ElseIf  !silent
				libs.NotifyActor("The harness " + akActor.GetLeveledActorBase().GetName() + " is wearing prevents you from inserting this piercing.", akActor, true)
			EndIf
			if !silent
				return 2
			Else
				return 0
			EndIf
		Endif
		if akActor.WornHasKeyword(libs.zad_DeviousBelt)
			if akActor == libs.PlayerRef && !silent
				libs.NotifyActor(strFailEquipBelt, akActor, true)
			ElseIf  !silent
				libs.NotifyActor("The belt " + akActor.GetLeveledActorBase().GetName() + " is wearing prevents you from inserting this piercing.", akActor, true)
			EndIf
			if !silent
				return 2
			Else
				return 0
			EndIf
		Endif

	Endif
	return 0
EndFunction


Function OnEquippedPre(actor akActor, bool silent=false)
	if !akActor.HasPerk(libs.PiercedClit)
		akActor.AddSpell(libs.PiercedClitSpell, true)
	Endif
	if !silent
		libs.NotifyActor("You carefully slip the piercing into "+GetMessageName(akActor)+" clitoris. A quiet 'Click' is heard as the band clicks together, now seemingly seamless. ", akActor, true)
	EndIf
	Parent.OnEquippedPre(akActor, silent)
EndFunction


Function OnEquippedPost(actor akActor)
	libs.Log("RestraintScript OnEquippedPost PiercingVaginal")
	
EndFunction

Function DeviceMenu(Int msgChoice = 0)
    msgChoice = zad_DeviceMsg.Show() ; display menu
	if msgChoice==0 ; put it in
		Debug.Notification("You choose to put the piercings in.")
		libs.EquipDevice(libs.PlayerRef, deviceInventory, deviceRendered, zad_DeviousDevice)
	elseif msgChoice==1 ; remove
		If libs.Playerref.WornHasKeyword(libs.zad_DeviousBelt)
			; display a different message if it's likely a belt harness:
			If libs.Playerref.WornHasKeyword(libs.zad_DeviousHarness)
				NoKeyFailMessageHarness(libs.playerRef)
			else
				NoKeyFailMessageBelt(libs.playerRef)
			EndIf
			return
		EndIf
		DeviceMenuRemoveWithKey()	
	elseif msgChoice == 2 ; Remove device, without key
		If libs.Playerref.WornHasKeyword(libs.zad_DeviousBelt)
			; display a different message if it's likely a belt harness:
			If libs.Playerref.WornHasKeyword(libs.zad_DeviousHarness)
				NoKeyFailMessageHarness(libs.playerRef)
			else
				NoKeyFailMessageBelt(libs.playerRef)
			EndIf
			return
		EndIf
		DeviceMenuRemoveWithoutKey()
	endif		
	DeviceMenuExt(msgChoice)
	;SyncInventory()
EndFunction
		

Function NoKeyFailMessageBelt(Actor akActor)
	if akActor == libs.PlayerRef
		libs.NotifyPlayer("Try as you might, the belt you are wearing prevents you from removing the piercing.", true)
	Else
		libs.NotifyNPC("The belt that "+akActor.GetLeveledActorBase().GetName() + " is wearing is securely locking the piercing in place. You must remove it prior to removing the piercing.", true)
	EndIf
EndFunction

Function NoKeyFailMessageHarness(Actor akActor)
	if akActor == libs.PlayerRef
		libs.NotifyPlayer("Try as you might, the harness you are wearing prevents you from removing the piercing.", true)
	Else
		libs.NotifyNPC("The harness that "+akActor.GetLeveledActorBase().GetName() + " is wearing is securely locking the piercing in place. You must remove it prior to removing the piercing.", true)
	EndIf
EndFunction
