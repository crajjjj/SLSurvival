ScriptName iDDeResMittensScr Extends zadx_BondageMittensScript 

iDDeMain Property iDDe Auto

Event OnEquipped(Actor akActor)
	Parent.OnEquipped(akActor)
		If (iDDe.iDDeBlockActMit)
			akActor.AddPerk(iDDe.iDDe_PerkHeavyBondage)
		EndIf
EndEvent
Function OnEquippedPost(actor akActor)
	akActor.UnequipItemSlot(36) ; Unequip ring to avoid clipping
	Parent.OnEquippedPost(akActor)
EndFunction

Event OnUnequipped(Actor akActor)
	Parent.OnUnequipped(akActor)
		If (!akActor.WornHasKeyword(libs.zad_DeviousBondageMittens) && !akActor.WornHasKeyword(libs.zad_DeviousHeavyBondage) && akActor.HasPerk(iDDe.iDDe_PerkHeavyBondage))
			akActor.RemovePerk(iDDe.iDDe_PerkHeavyBondage)	
		EndIf  
EndEvent