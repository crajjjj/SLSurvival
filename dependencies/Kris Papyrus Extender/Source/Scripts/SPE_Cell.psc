ScriptName SPE_Cell Hidden

; Returns all world spaces attached to the given cell
; For exterior cell, this directly returns the world space the cell is in (comparable to 'ObjectRef.GetWorldSpace()')
; For interior cells, this will return any exterior world spaces that are attached to the cell. For example, the attached world space of 'Whiterun Bannered Mare' cell is 'WhiterunWorld', and for 'Bleak Falls Barrow' it would be 'Tamriel'. Interior cells that connect to more than one world space (e.g. 'Riften Jail' which connects to both 'RiftenWorld' and 'Tamriel') will return all attached world spaces.
WorldSpace[] Function GetExteriorWorldSpaces(Cell akCell) global native

; Returns the location of all world spaces attached to the given cell
; Shorthand for GetWorldSpaceLocation(GetExteriorWorldSpaces(akCell)...)
Location[] Function GetExteriorLocations(Cell akCell) global native

; Return the Location of the given world space/cell
Location Function GetWorldSpaceLocation(WorldSpace akWorld) global native
Location Function GetCellLocation(Cell akCell) global native

; Returns all cells attached to the given cell within the specified radius (in units of cells)
; Default loaded cells is 5, therefore a radius of 2 and up will usually return all currently loaded cells
Cell[] Function GetAttachedCells(int aiRadius) global native
