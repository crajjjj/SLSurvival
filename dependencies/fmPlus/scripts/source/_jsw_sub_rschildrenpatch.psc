Scriptname	_JSW_SUB_RSChildrenPatch	extends	Quest

;_JSW_BB_Storage		Property	Storage		Auto	; Storage data helper
;_JSW_BB_Utility		Property	Util		Auto	; Independent helper functions

;form[]	RSActorBase
;form[]	FMActorbase
;bool	updateDone = false
;/
int function DetectAndUpdate()
{detects the FM-RSchildren patch, and updates the Storage.Children array if needed}

	if (Game.GetModByName("Fertility Mode - RSChildren.esp") != 255)
		if !updateDone
			GoToState("RSChildrenFound")
		endIf
		Debug.Trace("FM+ Info: RSChildren detected", 0)
	elseIf updateDone
		GoToState("RSChildrenRemoved")
		Debug.Trace("FM+ Info: RSChildren not detected and support removed", 0)
	endIf
	int returnCode = DoTheUpdate()
	GoToState("")
	return returnCode

endFunction

int function DoTheUpdate()
	return 1
endFunction

State RSChildrenFound

	int function DoTheUpdate()
		if (RSActorBase.Length != 8) || (RSActorBase.Find(none) != -1)
			RSActorBase = Utility.ResizeFormArray(RSActorBase, 8, none)
			RSActorBase[0] = Util.GetMeMyForm(0xD62, "Fertility Mode - RSChildren.esp") as actorbase;RSBretonFemale
			RSActorBase[1] = Util.GetMeMyForm(0xD63, "Fertility Mode - RSChildren.esp") as actorbase;RSBretonMale
			RSActorBase[2] = Util.GetMeMyForm(0xD64, "Fertility Mode - RSChildren.esp") as actorbase;RSImperialFemale
			RSActorBase[3] = Util.GetMeMyForm(0xD65, "Fertility Mode - RSChildren.esp") as actorbase;RSImperialMale
			RSActorBase[4] = Util.GetMeMyForm(0xD66, "Fertility Mode - RSChildren.esp") as actorbase;RSNordFemale
			RSActorBase[5] = Util.GetMeMyForm(0xD67, "Fertility Mode - RSChildren.esp") as actorbase;RSNordMale
			RSActorBase[6] = Util.GetMeMyForm(0xD68, "Fertility Mode - RSChildren.esp") as actorbase;RSRedguardFemale
			RSActorBase[7] = Util.GetMeMyForm(0xD69, "Fertility Mode - RSChildren.esp") as actorbase;RSRedguardMale
		endIf
		if (RSActorBase.Find(none) != -1)
			RSActorBase = Utility.ResizeFormArray(RSActorBase, 0)
			Debug.Trace("FM+: _JSW_SUB_RSChildrenPatch Error: Unable to read from FM-RSChildren.esp")
			return 2
		endIf
		if (FMActorBase.Length != 8) || (FMActorBase.Find(none) != -1)
			FMActorBase = Utility.ResizeFormArray(FMActorBase, 8, none)
			FMActorBase[0] = Util.GetMeMyForm(0x99D1, "Fertility Mode.esm");BretonFemale
			FMActorBase[1] = Util.GetMeMyForm(0x99D2, "Fertility Mode.esm");BretonMale
			FMActorBase[2] = Util.GetMeMyForm(0x99D7, "Fertility Mode.esm");ImperialFemale
			FMActorBase[3] = Util.GetMeMyForm(0x99D8, "Fertility Mode.esm");ImperialMale
			FMActorBase[4] = Util.GetMeMyForm(0x99D9, "Fertility Mode.esm");NordFemale
			FMActorBase[5] = Util.GetMeMyForm(0x99DA, "Fertility Mode.esm");NordMale
			FMActorBase[6] = Util.GetMeMyForm(0x99DD, "Fertility Mode.esm");RedguardFemale
			FMActorBase[7] = Util.GetMeMyForm(0x99DE, "Fertility Mode.esm");RedguardMale
		endIf
		if (FMActorBase.Find(none) != -1)
			FMActorBase = Utility.ResizeFormArray(FMActorBase, 0)
			Debug.Trace("FM+: _JSW_SUB_RSChildrenPatch Error: Unable to read from Fertility Mode.esm")
			return 3
		endIf
		int childrenLength = Math.LogicalAnd(Storage.Children.Length, 0x000000FF)
		int index = childrenLength
		int numToSwap = 8	; there's 8 child models to swap out
		if (index < 4)
			Debug.Trace("FM+: _JSW_SUB_RSChildrenPatch Error: Storage.Children[] reports an invalid length")
			return 4
		endIf
		while (numToSwap > 0)
			numToSwap -= 1
			index = childrenLength
			while (index)
				index -= 1
				if (Storage.Children[index]	==	FMActorBase[numToSwap])
					Storage.Children[index]	=	RSActorBase[numtoSwap]
				endIf
			endWhile
		endWhile
		updatedone = true
		return 1
	endFunction

endState

State RSChildrenRemoved

	int function DoTheUpdate()
		if ((RSActorBase.Find(none) != -1) && (FMActorBase.Find(none) != -1))
			int childrenLength = Math.LogicalAnd(Storage.Children.Length, 0x000000FF)
			int index = childrenLength
			int numToSwap = 8	; there's 8 child models to swap out
			if (index < 4)
				Debug.Trace("FM+: _JSW_SUB_RSChildrenPatch Error: Storage.Children[] reports an invalid length")
				return 4
			endIf
			while (numToSwap > 0)
				numToSwap -= 1
				index = childrenLength
				while (index)
					index -= 1
					if (Storage.Children[index]	==	RSActorBase[numToSwap])
						Storage.Children[index]	=	FMActorBase[numtoSwap]
					endIf
				endWhile
			endWhile
			updatedone = false
			RSActorBase = Utility.ResizeFormArray(RSActorBase, 0)
			FMActorBase = Utility.ResizeFormArray(FMActorBase, 0)
			Debug.Trace("FM+ Info: RSChildren removed")
			return 1
		endIf
		Debug.Trace("FM+: error in either the RSActorBase or FMActorBase arrays.")
		return 5
	endFunction

endState/;
