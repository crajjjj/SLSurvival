;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 25
Scriptname SLV_MainquestSpecial4_GetFree Extends Scene Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
;Debug.notification("End Phase 2.")
MiscUtil.PrintConsole("End Phase 2.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
;Debug.notification("Phase 3.")
MiscUtil.PrintConsole("Phase 3.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
;Debug.notification("Phase 2.")
MiscUtil.PrintConsole("Phase 2.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
GetOwningQuest().SetStage(4500)
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
;Debug.notification("End Phase 4.")
SLV_StopForceGreet.setvalue(0)
MiscUtil.PrintConsole("End Phase 4.")
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
;Debug.notification("Phase 3.")
MiscUtil.PrintConsole("Phase 3.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
;Debug.notification("End Phase 3.")
MiscUtil.PrintConsole("End Phase 3.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
;Debug.notification("Phase 1.")
MiscUtil.PrintConsole("Phase 1.")
SLV_StopForceGreet.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
slv_sexisrunning.setvalue(1)

;Debug.notification("End Phase 1.")
MiscUtil.PrintConsole("End Phase 1.")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_StopForceGreet Auto  
GlobalVariable Property SLV_SexIsRunning Auto  
