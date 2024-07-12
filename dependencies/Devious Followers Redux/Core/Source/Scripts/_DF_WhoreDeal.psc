Scriptname _DF_WhoreDeal extends _DDeal Conditional

zadLibs Property libs Auto
Armor Property Plug Auto

Function CleanUp()
    Parent.CleanUp()
    libs.UnlockDevice(libs.PlayerRef, Plug)
    PlayerRef.RemoveItem(Plug)
EndFunction