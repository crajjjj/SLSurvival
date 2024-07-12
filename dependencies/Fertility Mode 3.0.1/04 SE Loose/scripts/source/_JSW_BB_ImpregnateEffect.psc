Scriptname _JSW_BB_ImpregnateEffect extends ActiveMagicEffect

_JSW_BB_Utility Property Util  Auto               ; Independent helper functions
_JSW_BB_Storage Property Storage  Auto            ; Storage data helper

GlobalVariable Property Enabled  Auto             ; Whether the mod is actively running or not

event OnEffectStart(Actor akTarget, Actor akCaster)
	if (!Enabled.GetValueInt())
		return
	else
		Util.AddActor(akTarget)
		
		int index = Storage.TrackedActors.Find(akTarget)
		
		if (index != -1 && Storage.LastConception[index] == 0.0)
			Storage.LastConception[index] = Utility.GetCurrentGameTime()
			Storage.LastBirth[index] = 0.0
			
			if (Storage.TrackedActors.Find(akCaster) == -1)
	        	; The caster is male, force him to be the father
	        	Storage.CurrentFather[index] = akCaster.GetDisplayName()
	        elseIf (Storage.CurrentFather[index] == "")
	        	; The caster is female, use an existing father or set to unknown if there isn't an existing father
	        	Storage.CurrentFather[index] = "Unknown"
	        endIf
		else
			Debug.MessageBox("Target is not tracked or already pregnant")
		endIf
	endIf
endEvent