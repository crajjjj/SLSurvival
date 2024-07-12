;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 27
Scriptname SLV_MainquestSpecial4SceneRape Extends Scene Hidden

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
;Debug.notification("End Phase 4.")
MiscUtil.PrintConsole("End Phase 4.")
SLV_StopForceGreet.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

;Debug.notification("Phase 4.")
MiscUtil.PrintConsole("Phase 4.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
;Debug.notification("Phase 1.")
MiscUtil.PrintConsole("Phase 1.")
SLV_StopForceGreet.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
;Debug.notification("End Phase 3.")
MiscUtil.PrintConsole("End Phase 3.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
;Debug.notification("End Phase 1.")
MiscUtil.PrintConsole("End Phase 1.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
;Debug.notification("Phase 2.")
MiscUtil.PrintConsole("Phase 2.")
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SLV_Sexisrunning.setvalue(1)
;Debug.notification("End Phase 2.")
MiscUtil.PrintConsole("End Phase 2.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
;Debug.notification("Phase 3.")
MiscUtil.PrintConsole("Phase 3.")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_StopForceGreet Auto  
GlobalVariable Property SLV_SexIsRunning Auto  
