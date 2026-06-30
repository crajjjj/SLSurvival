Scriptname mzinInterfaceFrostfall

Function MakeWet(GlobalVariable FrostfallRunning, Float amount) Global
    if FrostfallRunning && FrostfallRunning.GetValueInt() == 2
        FrostUtil.ModPlayerWetness(amount, limit = -1.0)
    endIf
EndFunction