;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname SLV_EnslavePC5_Shaving Extends Scene Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
debug.SendAnimationEvent(Game.GetPlayer(), "ZazAPC058")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Int TargetModIndex1
TargetModIndex1 = Game.GetModByName("SlaveTats.esp")

if  TargetModIndex1 != 255 && MCMMenu.SlaveTatoos
	NextScene2.Start()
elseif SLV_Hardmode.getValue() == 0
	NextScene3.Start()
else
	NextScene4.Start()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Scene Property NextScene2  Auto  
Scene Property NextScene3  Auto  
Scene Property NextScene4  Auto  
SLV_MCMMenu Property MCMMenu Auto
GlobalVariable Property SLV_Hardmode Auto
