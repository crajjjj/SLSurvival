Scriptname SLV_BuildingObjectInteriorScript extends SLV_BuildingObjectScript
{script for inventory objects used for INTERIOR house building}

; override event on parent script
Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If akNewContainer == Game.GetPlayer() && akOldContainer == None
		;debug.trace(self+" akNewContainer = "+akNewContainer+",  akOldContainer = "+akOldContainer)
		; get active house right now (in case player moves between houses quickly...)
		int myActiveHouseLocation = SLV_HouseBuilding.activeHouseLocation
		; get active room right now (in case player moves between workbenches quickly...)
		int myRoomID = SLV_HouseBuilding.activeRoomID

		; tell master script that I've been built
		SLV_HouseBuilding.BuildHouseInteriorPart(myActiveHouseLocation, ID, myself, myRoomID)
	EndIf
EndEvent

