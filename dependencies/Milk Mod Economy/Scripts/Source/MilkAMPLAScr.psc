Scriptname MilkAMPLAScr extends activemagiceffect

MilkQUEST Property MilkQ Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Form cuirass = akTarget.GetWornForm(Armor.GetMaskForSlot(32))
	Int i = 0

	If cuirass != None
		If MilkQ.ParasiteLivingArmor.Length < 5
			MilkQ.MME_AM_Purge.cast(MilkQ.PlayerRef)
		EndIf 
		i = MilkQ.ParasiteLivingArmor.find(cuirass.getname()) 
		If i != -1
			MilkQ.ParasiteLivingArmor[i] = "Empty"
			Debug.Notification( cuirass.getname() + " Removed from Parasite Living Armor")
		Else
			i = MilkQ.ParasiteLivingArmor.find("Empty")
			If i != -1
				MilkQ.ParasiteLivingArmor[i] = cuirass.getname()
				Debug.Notification( cuirass.getname() + " Added to Parasite Living Armor")
			Else
				Debug.Notification( "Error: Parasite Living Armor is full")
			EndIf
		EndIf
	EndIf
EndEvent