Scriptname _SLS_CumDesperationObjectRefresh extends ReferenceAlias  

Event OnInit()
	ObjectReference ObjRef = Self.GetReference()
	If ObjRef
		ObjRef.Disable()
		ObjRef.Enable(true)
	EndIf
EndEvent
