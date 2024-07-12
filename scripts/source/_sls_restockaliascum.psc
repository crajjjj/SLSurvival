Scriptname _SLS_RestockAliasCum extends ReferenceAlias  

Event OnInit()
	If Self.GetReference() as Actor
		StorageUtil.SetFloatValue(Self.GetReference(), "_SLS_LastOrgasmTime", -7.0)
	EndIf
EndEvent
