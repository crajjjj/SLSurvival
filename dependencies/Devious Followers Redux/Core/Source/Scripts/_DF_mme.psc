Scriptname _DF_MME

Form Function GetLactacid() Global
    Return Game.GetFormFromFile(0x00343F2, "MilkModNEW.esp")
EndFunction

Keyword Function GetMilkKeyword() Global
    Return Game.GetFormFromFile(0x0006D61F,  "MilkModNEW.esp") As Keyword
EndFunction
