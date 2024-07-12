Scriptname MilkAMBLAScr extends activemagiceffect

MilkQUEST Property MilkQ Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Form cuirass = akTarget.GetWornForm(Armor.GetMaskForSlot(32))
	Int i = 0

	If cuirass != None
		If MilkQ.BasicLivingArmor.Length < 5
			MilkQ.MME_AM_Purge.cast(MilkQ.PlayerRef)
		EndIf 
		i = MilkQ.BasicLivingArmor.find(cuirass.getname()) 
		If i != -1
			MilkQ.BasicLivingArmor[i] = "Empty"
			Debug.Notification( cuirass.getname() + " Removed from Basic Living Armor")
		Else
			i = MilkQ.BasicLivingArmor.find("Empty")
			If i != -1
				MilkQ.BasicLivingArmor[i] = cuirass.getname()
				Debug.Notification( cuirass.getname() + " Added to Basic Living Armor")
			Else
				Debug.Notification( "Error: Basic Living Armor is full")
			EndIf
		EndIf
	EndIf
EndEvent