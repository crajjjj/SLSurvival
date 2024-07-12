Scriptname MME_CheckForSpriggan extends ReferenceAlias Hidden

Event OnObjectEquipped( Form akBaseObject, ObjectReference akReference)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Actor akActor = GetActorRef()
	String akArmorName = akBaseObject.getname()
	if (StringUtil.Find(akArmorName, "Spriggan Armor" ) >= 0\
	|| 	StringUtil.Find(akArmorName, "Spriggan Host" ) >= 0\
	|| 	StringUtil.Find(akArmorName, "Living Arm" ) >= 0\
	|| 	StringUtil.Find(akArmorName, "Hermaeus Mora" ) >= 0\
	|| 	StringUtil.Find(akArmorName, "HM Priestess" ) >= 0\
	|| 	StringUtil.Find(akArmorName, "Tentacle Parasite" ) >= 0\
	|| 	StringUtil.Find(akArmorName, "Tentacle Armor" ) >= 0\
	|| 	StringUtil.Find(akArmorName, "Dwemer milking device" ) >= 0\
	|| 	StringUtil.Find(akArmorName, "Cow Harness" ) >= 0\
	|| 	StringUtil.Find(akArmorName, "Milking Cuirass" ) >= 0\
	|| 	StringUtil.Find(akArmorName, "Milker" ) >= 0\
	|| 	MilkQ.MilkingEquipment.find(akArmorName) >= 0\
	|| 	MilkQ.BasicLivingArmor.find(akArmorName) >= 0\
	|| 	MilkQ.ParasiteLivingArmor.find(akArmorName) >= 0)

		If MilkQ.MILKmaid.find(akActor) == -1
			MilkQ.AssignSlotMaid(akActor)
		EndIf

		if (akActor.GetLeveledActorBase().GetSex() == 1 || (akActor.GetLeveledActorBase().GetSex() == 0 && MilkQ.MaleMaids)) && MilkQ.MILKmaid.find(akActor) != -1
			If (StringUtil.Find(akArmorName, "Spriggan Armor" ) >= 0\
			|| StringUtil.Find(akArmorName, "Spriggan Host" ) >= 0\
			|| StringUtil.Find(akArmorName, "Living Arm" ) >= 0\
			|| StringUtil.Find(akArmorName, "Hermaeus Mora" ) >= 0\
			|| StringUtil.Find(akArmorName, "HM Priestess" ) >= 0\
			|| StringUtil.Find(akArmorName, "Tentacle Parasite" ) >= 0\
			|| StringUtil.Find(akArmorName, "Tentacle Armor" ) >= 0\
			|| MilkQ.BasicLivingArmor.find(akArmorName) >= 0)\
			|| MilkQ.ParasiteLivingArmor.find(akArmorName) >= 0
				if akActor == MilkQ.PlayerREf && MME_Storage.getBreastRows(akActor) > 1 && akActor.GetWornForm(Armor.GetMaskForSlot(32)) == akBaseObject
					Debug.Notification(akArmorName + " attaches to your breasts, absorbing your additional breast rows")
					MME_Storage.setBreastRows(akActor, 1)
				endif
				if akActor == MilkQ.PlayerREf
					Debug.Notification(akArmorName + " attaches to your breasts")
				endif
				akActor.AddSpell( MilkQ.MilkForSprigganPassive, false )
				If MME_Storage.getLactacidCurrent(akActor) < 1
					MME_Storage.setLactacidCurrent(akActor, 1)
				EndIf
			Else
				if akActor == MilkQ.PlayerREf
					Debug.Notification( "The milking cups attach to your breasts, ready to milk you" )
				endif
			EndIf
		EndIf
		
	elseif akActor.GetWornForm(Armor.GetMaskForSlot(32)) == akBaseObject && !MilkQ.ArmorStrippingDisabled && MilkQ.Sexlab.IsStrippable(akBaseObject)
		Float MilkCnt = MME_Storage.getMilkCurrent(akActor)
		Float MilkMax = MME_Storage.getMilkMaximum(akActor)
		if !(akBaseObject == MilkQ.TITS4 || akBaseObject == MilkQ.TITS6 || akBaseObject == MilkQ.TITS8 || MilkQ.DDi.IsMilkingBlocked_Suit(akActor))
			;heavy armor	
			if MilkCnt > 4 && akBaseObject.HasKeyword(Game.GetFormFromFile(0x6BBD2, "Skyrim.esm") as keyword) 
				Debug.Notification("Your breasts are too big to fit into your heavy armor")
				akActor.UnEquipItem(akBaseObject)
			endif
			;light armor	
			if MilkCnt > 8 && akBaseObject.HasKeyword(Game.GetFormFromFile(0x6BBD3, "Skyrim.esm") as keyword)
				Debug.Notification("Your breasts are too big to fit into your light armor")
				akActor.UnEquipItem(akBaseObject)
			endif
			;clothes
			if MilkCnt > 12
				Debug.Notification("Your breasts are too big to fit into your clothes")
				akActor.UnEquipItem(akBaseObject)
			endif
		endif
	EndIf
	
	if akActor.GetWornForm(Armor.GetMaskForSlot(32)) != None && MilkQ.MilkLeakWearArm == False && akActor.HasSpell(MilkQ.MilkLeak)
		akActor.RemoveSpell(MilkQ.MilkLeak)
	endif
EndEvent

Event OnObjectUnequipped( Form akBaseObject, ObjectReference akReference )
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Actor akActor = GetActorRef()
	String akArmorName = akBaseObject.getname()
	if MilkQ.MILKmaid.find(akActor) != -1
		if StringUtil.Find(akArmorName, "Spriggan Armor" ) >= 0\
		|| StringUtil.Find(akArmorName, "Spriggan Host" ) >= 0\
		|| StringUtil.Find(akArmorName, "Living Arm" ) >= 0\
		|| StringUtil.Find(akArmorName, "Hermaeus Mora" ) >= 0\
		|| StringUtil.Find(akArmorName, "HM Priestess" ) >= 0\
		|| StringUtil.Find(akArmorName, "Tentacle Parasite" ) >= 0\
		|| StringUtil.Find(akArmorName, "Tentacle Armor" ) >= 0\
		|| MilkQ.BasicLivingArmor.find(akArmorName) >= 0\
		|| MilkQ.ParasiteLivingArmor.find(akArmorName) >= 0
			if akActor == MilkQ.PlayerREf
				Debug.Notification( "You are free from " + akArmorName )
			endif
			akActor.RemoveSpell( MilkQ.MilkForSprigganPassive )
		ElseIf (akActor.GetLeveledActorBase().GetSex() == 1 || (akActor.GetLeveledActorBase().GetSex() == 0 && MilkQ.MaleMaids)) && StringUtil.Find(akArmorName, "Dwemer milking device" ) >= 0\
			|| StringUtil.Find(akArmorName, "Cow Harness" ) >= 0\
			|| StringUtil.Find(akArmorName, "Milking Cuirass" ) >= 0\
			|| StringUtil.Find(akArmorName, "Milker" ) >= 0\
			|| MilkQ.MilkingEquipment.find(akArmorName) >= 0
			if akActor == MilkQ.PlayerREf
				Debug.Notification( "The milking cups detach from your breasts" )
			endif
		EndIf
	EndIf
EndEvent