Scriptname _DF_SlutDeal extends _DDeal Conditional

zadLibs Property libs Auto

Function Cleanup()
    Parent.Cleanup()
    int stage = GetStage()
    if stage == 3
        LDC.RemoveAndDestroyDeviceByKeyword(libs.zad_DeviousArmbinder)
    endIf
EndFunction
