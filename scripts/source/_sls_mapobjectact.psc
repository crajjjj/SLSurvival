Scriptname _SLS_MapObjectAct extends ObjectReference  

Event OnActivate(ObjectReference akActionRef)
	Map.BeginTempAccess()
	Input.TapKey(Input.GetMappedKey("Quick Map", DeviceType = 0xFF))
EndEvent

_SLS_MapAndCompassAlias Property Map Auto
