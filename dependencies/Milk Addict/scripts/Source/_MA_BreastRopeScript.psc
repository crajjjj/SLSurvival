Scriptname _MA_BreastRopeScript extends activemagiceffect  

Bool MilkLeaking
Bool MilkLeakingArmor
Actor Cow
Float RopeMilkLimit = 1.0

Event OnEffectStart(Actor akTarget, Actor akCaster)
	MilkLeaking = MilkQ.MilkLeakToggle
	MilkLeakingArmor = MilkQ.MilkLeakWearArm
	Cow = akTarget
	If MilkQ.MILKmaid.find(Cow) > -1
		Utility.Wait(1.0) ; Make sure armor doesn't get unequipped - DDs
		If Cow.WornHasKeyword(_MA_BreastRope)
			If Cow == PlayerRef
				Debug.Notification("You tighten the rope around the base of your breasts until they begin leaking")
			EndIf
			ForceLeak()
		EndIf
	EndIf
EndEvent

;MME_Storage.getMilkMaximum(actor akActor)

Function ForceLeak()
	RegisterForModEvent("MME_MilkCycleComplete", "OnMME_MilkCycleComplete")
	RegisterForSingleUpdate(0.1)
EndFunction

Event OnUpdate()
	If Cow.WornHasKeyword(_MA_BreastRope) && StorageUtil.GetFloatValue(Cow, "MME.MilkMaid.MilkCount") >= RopeMilkLimit + 1.0
		MME_Storage.changeMilkCurrent(Cow, -1, MilkQ.BreastScaleLimit)
		MilkQ.AddMilkFx(Cow, 1)
		MilkQ.MilkLeakToggle = true
		MilkQ.MilkLeakWearArm = true
		MilkQ.AddLeak(Cow)
		MilkQ.MilkLeakToggle = MilkLeaking
		MilkQ.MilkLeakWearArm = MilkLeakingArmor
		If !PlayerRef.HasMagicEffect(_MA_LeakyBoobsMgef)
			Main.TryBoobLeakSound()
		EndIF
		MilkQ.CurrentSize(Cow)
		MilkQ.PostMilk(Cow)
		RegisterForSingleUpdate(Main.BreastRopeFreq)
	Else
		UnregisterForUpdate()
	EndIf
EndEvent

Event OnMME_MilkCycleComplete(string eventName, string strArg, float numArg, Form sender)
	RegisterForSingleUpdate(0.1)
EndEvent

Keyword Property _MA_BreastRope Auto

Actor Property PlayerRef Auto

Spell Property _MA_LeakyBoobsSpell Auto

MagicEffect Property _MA_LeakyBoobsMgef Auto

MilkQUEST Property MilkQ Auto
_MA_Main Property Main Auto
_MA_Mcm Property Menu Auto