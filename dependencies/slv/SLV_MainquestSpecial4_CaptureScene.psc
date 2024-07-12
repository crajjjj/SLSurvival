;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 49
Scriptname SLV_MainquestSpecial4_CaptureScene Extends Scene Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
Debug.notification("You have reached the Stormcloak camp")
MiscUtil.PrintConsole("You have reached the Stormcloak camp")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
;Debug.notification("Phase 4.")
MiscUtil.PrintConsole("Phase 4.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
MiscUtil.PrintConsole("End Phase 6.")
debug.SendAnimationEvent(game.getplayer(), "ZazAPC018")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SLV_SexIsRunning.setValue(1)
MiscUtil.PrintConsole("End Phase 5.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
;Debug.notification("Phase 6.")
MiscUtil.PrintConsole("Phase 6.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
;Debug.notification("End Phase 4.")
MiscUtil.PrintConsole("End Phase 4.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
Debug.notification("You are forced to kneel down.")
MiscUtil.PrintConsole("You are forced to kneel down.")
debug.SendAnimationEvent(game.getplayer(), "ZazAPC018")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
debug.SendAnimationEvent(game.getplayer(), "IdleForceDefaultState")
Debug.notification("You are forced to walk to a camp.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;Debug.notification("Phase 7.")
MiscUtil.PrintConsole("Phase 7.")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

ActorUtil.ClearPackageOverride(soldier.getActorRef())
soldier.getActorRef().evaluatePackage()
ActorUtil.ClearPackageOverride(campleader.getActorRef())
campleader.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
;Debug.notification("Phase 5.")
MiscUtil.PrintConsole("Phase 5.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
SLV_StopForceGreet.setValue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)
debug.SendAnimationEvent(game.getplayer(), "ZazAPCAO252")
;Debug.notification("End Phase 7.")
MiscUtil.PrintConsole("End Phase 7.")
SLV_StopForceGreet.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Soldier Auto 
ReferenceAlias Property Campleader Auto 
Package Property Forcegreet1 Auto
Package Property Forcegreet2 Auto
GlobalVariable Property SLV_SexIsRunning Auto  
GlobalVariable Property SLV_StopForceGreet Auto  

