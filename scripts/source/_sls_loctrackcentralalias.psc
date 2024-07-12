Scriptname _SLS_LocTrackCentralAlias extends ReferenceAlias  

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	LocTrack.PlayerLocChange(akOldLoc, akNewLoc)
EndEvent

_SLS_LocTrackCentral Property LocTrack Auto
