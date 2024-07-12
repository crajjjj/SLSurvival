Scriptname SLV_BuildingObjectExteriorScript extends SLV_BuildingObjectScript

{script for inventory objects used for miscellaneous EXTERIOR building (not the house itself)}

; override event on parent script
Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If akNewContainer == Game.GetPlayer() && akOldContainer == None
		;debug.trace(self+" akNewContainer = "+akNewContainer+",  akOldContainer = "+akOldContainer)
		; get active house right now (in case player moves between houses quickly...)
		int myActiveHouseLocation = SLV_HouseBuilding.activeHouseLocation
		; tell master script that I've been built
		SLV_HouseBuilding.BuildHouseExteriorPart(myActiveHouseLocation, ID, myself)
	EndIf
EndEvent
