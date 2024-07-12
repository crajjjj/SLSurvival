Scriptname _dtickPlayerAlias Extends ReferenceAlias

Keyword Property LocTypeDungeon Auto
Keyword Property LocTypeCity Auto
Keyword Property LocTypeTown Auto
Keyword Property LocTypeDwelling Auto

_DflowMCM Property MCM Auto
_DFGoldConQScript Property GoldCont Auto
_DFlowHumliation Property Hum Auto 
_Dtick Property Q Auto
ObjectReference Property CrosshairTarget Auto

String OldType

Event OnPlayerLoadGame()
    ; Re-init _Dtick on game load
	Q.Init()
EndEvent

Function AddEventRegistrations()
	RegisterForCrosshairRef()
EndFunction
 
Event OnCrosshairRefChange(ObjectReference ref)
    CrosshairTarget = ref
EndEvent


Event OnLocationChange(Location OldLocation, Location newLocation)

    If newLocation
        GoldCont.Recalc()

        String newType = "LocW"
        
        If newLocation.HasKeyWord(LocTypeDungeon)
            newType = "LocD"
        Elseif newLocation.HasKeyWord(LocTypeCity) || newLocation.HasKeyWord(LocTypeTown)
            newType = "LocT"
        Elseif newLocation.HasKeyWord(LocTypeDwelling)
            newType = "LocDw"
        EndIf

        If newType != Oldtype
            ; Moved handling of display options to MCM where it belongs.
            MCM.Noti(newType)
            ;Hum.Use(NewType)
        EndIf
        
        OldType = newType
    EndIf
    
EndEvent
