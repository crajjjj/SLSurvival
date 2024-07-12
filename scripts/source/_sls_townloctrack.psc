Scriptname _SLS_TownLocTrack extends ReferenceAlias  

Event OnCellAttach()
	 LocTrack.TrackingMarkerCellAttach(Self.GetReference())
EndEvent

Event OnCellDetach()
	 LocTrack.TrackingMarkerCellDetatch(Self.GetReference())
EndEvent

_SLS_LocTrackCentral Property LocTrack Auto
