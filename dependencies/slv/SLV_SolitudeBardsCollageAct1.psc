;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 17
Scriptname SLV_SolitudeBardsCollageAct1 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
sendModEvent("SlaverunReloaded_WhippingScream")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SendModEvent("dhlp-Resume")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
myScripts.SLV_DeviousEquipActorColor(Game.GetPlayer(),",white","",false,false,false,false,false,false,false,false,false,false,false,false,true,false,false)
;Utility.wait(2.0)
myScripts.SLV_DeviousEquipActorColor(Ildi.getActorRef(),",red","",false,false,false,false,false,false,false,false,false,false,false,false,true,false,false)
;Utility.wait(2.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
;myScripts.SLV_DeviousUnEquipActor(Game.GetPlayer(),true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
;myScripts.SLV_DeviousUnEquipActor(Ildi.getActorRef(),true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
;Utility.wait(2.0)

myScripts.SLV_DeviousEquipActorColor(Game.GetPlayer(),",white","",false,false,false,false,false,true,false,false,false,false,false,false,false,false,true)
;Utility.wait(2.0)
myScripts.SLV_DeviousEquipActorColor(Ildi.getActorRef(),",red","",false,false,false,false,false,true,false,false,false,false,false,false,false,false,true)
;Utility.wait(2.0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Ildi Auto 
