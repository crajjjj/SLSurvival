Scriptname MilkAMPurgeScr extends activemagiceffect

MilkQUEST Property MilkQ Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	int i = 0
	MilkQ.MilkingEquipment = new String[10]
	MilkQ.BasicLivingArmor = new String[10]
	MilkQ.ParasiteLivingArmor = new String[10]

	while ( i < MilkQ.MilkingEquipment.Length )
		MilkQ.MilkingEquipment[i] = "Empty"
		MilkQ.BasicLivingArmor[i] = "Empty"
		MilkQ.ParasiteLivingArmor[i] = "Empty"
		i = i + 1
	endWhile
	Debug.Notification( "MME Armor Management arrays (re)set")
EndEvent