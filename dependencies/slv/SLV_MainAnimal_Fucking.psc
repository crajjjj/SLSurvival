;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname SLV_MainAnimal_Fucking Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SLV_You.getActorRef().moveto(Game.getPlayer())
SLV_SexIsRunning.setValue(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_You Auto


