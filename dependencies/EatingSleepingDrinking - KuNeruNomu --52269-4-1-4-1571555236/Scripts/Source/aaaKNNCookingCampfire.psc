Scriptname aaaKNNCookingCampfire extends ObjectReference

bool Property IsDisabledRef auto

Event OnCellDetach()
	;Debug.Trace(self + " OnCellDetach")
	if IsDisabledRef
		Disable()
		Delete()
	else
		MoveToMyEditorLocation()
	endIf
EndEvent