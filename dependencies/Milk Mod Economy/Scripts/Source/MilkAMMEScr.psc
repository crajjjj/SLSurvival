Scriptname MilkAMMEScr extends activemagiceffect

MilkQUEST Property MilkQ Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Form cuirass = akTarget.GetWornForm(Armor.GetMaskForSlot(32))
	Int i = 0

	If cuirass != None
		If MilkQ.MilkingEquipment.Length < 5
			MilkQ.MME_AM_Purge.cast(MilkQ.PlayerRef)
		EndIf 
		i = MilkQ.MilkingEquipment.find(cuirass.getname()) 
		If i != -1
			MilkQ.MilkingEquipment[i] = "Empty"
			Debug.Notification( cuirass.getname() + " Removed from Milking Equipment")
		Else
			i = MilkQ.MilkingEquipment.find("Empty")
			If i != -1
				MilkQ.MilkingEquipment[i] = cuirass.getname()
				Debug.Notification( cuirass.getname() + " Added to Milking Equipment")
			Else
				Debug.Notification( "Error: Milking Equipment is full")
			EndIf
		EndIf
	EndIf
EndEvent