Scriptname _SLS_DanceThrownObject extends ObjectReference  

Event OnLoad()
	RegisterForSingleUpdate(10.0)
EndEvent

Event OnUpdate()
	Self.Disable(abFadeOut = true)
	Self.Delete()
EndEvent
