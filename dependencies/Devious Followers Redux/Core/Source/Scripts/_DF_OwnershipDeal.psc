Scriptname _DF_OwnershipDeal extends _DDeal Conditional

zadLibs Property libs Auto

Function Cleanup()
    Parent.Cleanup()
    int stage = GetStage()
    if stage >= 1
        LDC.RemoveAndDestroyDeviceByKeyword(libs.zad_Deviousarmcuffs)
        LDC.RemoveAndDestroyDeviceByKeyword( libs.zad_Deviouslegcuffs)
    endIf

    if stage >= 2
        LDC.RemoveAndDestroyDeviceByKeyword( libs.zad_Deviouscollar)
    endIf

    if stage == 3
        LDC.RemoveAndDestroyDeviceByKeyword( libs.zad_Deviousbelt)
    endIf

    if stage == 4
        libs.RemoveDevice(libs.PlayerRef, item1 , item1R, libs.zad_DeviousBelt, skipevents = false, skipmutex = true)
    endIf
EndFunction
