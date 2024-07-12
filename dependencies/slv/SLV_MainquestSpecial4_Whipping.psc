;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname SLV_MainquestSpecial4_Whipping Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;Debug.notification("End Phase 1.")
MiscUtil.PrintConsole("End Phase 1.")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
;Debug.notification("Phase 2.")
MiscUtil.PrintConsole("Phase 2.")
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
Soldier.GetActorRef().addItem(Whip)
Campleader.GetActorRef().addItem(Whip)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
;Debug.notification("End Phase 2.")
MiscUtil.PrintConsole("End Phase 2.")
SLV_StopForceGreet.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Weapon Property Whip Auto
ReferenceAlias Property Soldier Auto 
ReferenceAlias Property Campleader Auto 
GlobalVariable Property SLV_StopForceGreet Auto  
