;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 15
Scriptname SLV_SlaveCertification4_Valentina Extends Scene Hidden

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SLV_SexIsRunning.setValue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
debug.SendAnimationEvent(Game.getplayer(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Diamond.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Ivana.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Julia.getActorRef(), "IdleForceDefaultState")
debug.SendAnimationEvent(SLV_Valentina.getActorRef(), "IdleForceDefaultState")

Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SLV_SexIsRunning.setValue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
SLV_SexIsRunning.setValue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
SLV_SexIsRunning.setValue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SLV_SexIsRunning.setValue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SLV_SexIsRunning.setValue(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 

ReferenceAlias Property SLV_Diamond Auto 
ReferenceAlias Property SLV_Ivana Auto 
ReferenceAlias Property SLV_Julia Auto 
ReferenceAlias Property SLV_Valentina Auto 



