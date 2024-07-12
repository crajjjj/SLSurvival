Scriptname _STA_IntMme Hidden 

Function BoobLeak(Quest MME_MilkQUEST, Actor akTarget) Global
	MilkQUEST MilkQ = MME_MilkQUEST as MilkQUEST 
	If MilkQ.MILKmaid.find(akTarget) > -1 && MilkQ.MilkLeakToggle
		If StorageUtil.GetFloatValue(akTarget, "MME.MilkMaid.MilkCount") >= 1.0
			If akTarget.GetWornForm(0x00000004) == None || MilkQ.MilkLeakWearArm
				MME_Storage.changeMilkCurrent(akTarget, -1, MilkQ.BreastScaleLimit)
				MilkQ.AddMilkFx(akTarget, 1)
				MilkQ.AddLeak(akTarget)
				MilkQ.CurrentSize(akTarget)
				MilkQ.PostMilk(akTarget)
			EndIf
		EndIf
	EndIf
EndFunction
