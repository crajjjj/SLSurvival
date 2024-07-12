Scriptname _JSW_BB_AbortEffect extends ActiveMagicEffect

_JSW_BB_Utility Property Util  Auto               ; Independent helper functions
_JSW_BB_Storage Property Storage  Auto            ; Storage data helper

GlobalVariable Property Enabled  Auto             ; Whether the mod is actively running or not

event OnEffectStart(Actor akTarget, Actor akCaster)
	if (!Enabled.GetValueInt())
		return
	else
		Util.AddActor(akTarget)
		
		int index = Storage.TrackedActors.Find(akTarget)
		
		if (index != -1 && Storage.LastConception[index] != 0.0)
			; Remove all pregnancy metrics for an abortion/miscarriage
			Storage.LastConception[index] = 0.0
			Storage.LastBirth[index] = 0.0
			Storage.LastFather[index] = ""
			Storage.CurrentFather[index] = ""
			Storage.BabyHealth = 100
		else
			Debug.MessageBox("Target is not tracked or not currently pregnant")
		endIf
	endIf
endEvent