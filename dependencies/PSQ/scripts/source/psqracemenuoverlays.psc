Scriptname PSQRaceMenuOverlays Extends RaceMenuBase

Event OnBodyPaintRequest()
	AddBodyPaint("PSQ Body 0", "PSQ\\Overlays\\Body_0.dds")
EndEvent

Event OnHandPaintRequest()
	AddHandPaint("PSQ Hand 0", "PSQ\\Overlays\\Hand_0.dds")
EndEvent

Event OnFeetPaintRequest()
	AddFeetPaint("PSQ Feet 0", "PSQ\\Overlays\\Feet_0.dds")
EndEvent

Event OnFacePaintRequest()
	AddFacePaint("PSQ Face 0", "PSQ\\Overlays\\Face_0.dds")
	AddFacePaint("PSQ FollowerSuccubusFace", "PSQ\\Overlays\\FollowerSuccubusFace_0.dds")
EndEvent
