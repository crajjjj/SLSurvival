Scriptname _DF_BondageDeal extends _DDeal Conditional

zadLibs Property libs Auto 

Function CleanUp()
    Parent.CleanUp()

    int stage = GetStage()
    if stage >= 1
        LDC.RemoveAndDestroyDeviceByKeyword(libs.zad_DeviousCorset)
    endIf
    if stage >= 2
        LDC.RemoveAndDestroyDeviceByKeyword(libs.zad_Deviousgloves)
        LDC.RemoveAndDestroyDeviceByKeyword(libs.zad_Deviousboots)
    endIf
    if stage >= 3
        LDC.RemoveAndDestroyDeviceByKeyword(libs.zad_Deviousgag)
    endIf
EndFunction
