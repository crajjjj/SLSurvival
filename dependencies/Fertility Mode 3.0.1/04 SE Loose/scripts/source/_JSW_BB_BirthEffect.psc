Scriptname _JSW_BB_BirthEffect extends ActiveMagicEffect

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
			Storage.LastConception[index] = 0.0
			Storage.LastBirth[index] = Utility.GetCurrentGameTime()
			Storage.LastFather[index] = Storage.CurrentFather[index]
			Storage.CurrentFather[index] = ""
			
			Util.SendTrackingEvent("FertilityModeLabor", akTarget, index)
		else
			Debug.MessageBox("Target is not tracked or not currently pregnant")
		endIf
	endIf
endEvent