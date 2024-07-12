;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 32
Scriptname SLV_CelebrateSlaveryRoastScene Extends Scene Hidden

;BEGIN FRAGMENT Fragment_31
Function Fragment_31()
;BEGIN CODE
Debug.notification("Start 10")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
Int PSQSkinColor = -16777216
Game.SetTintMaskColor(PSQSkinColor, 6, 0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
Debug.notification("Start 8")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
Debug.notification("Start 4")
String haircut = "HairFemaleRedguard03" 
HeadPart shavedHair = HeadPart.GetHeadPart(haircut) 

Game.GetPlayer().ChangeHeadPart(shavedHair)
Game.GetPlayer().RegenerateHead()

Int PSQSkinColor = -3407821
Game.SetTintMaskColor(PSQSkinColor, 6, 0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN CODE
Debug.notification("Start 9")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
Debug.notification("Start 2")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
Int PSQSkinColor = -10729418
Game.SetTintMaskColor(PSQSkinColor, 6, 0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
Int PSQSkinColor = -8372979
Game.SetTintMaskColor(PSQSkinColor, 6, 0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN CODE
Debug.notification("Start 7")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
Debug.notification("Start 5")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
Debug.notification("Start 6")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
Debug.notification("Start 3")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SendModEvent("dhlp-Resume")
Game.getplayer().kill()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
Int PSQSkinColor = -4370663
Game.SetTintMaskColor(PSQSkinColor, 6, 0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
Debug.notification("Start 1")
Game.ForceThirdPerson()
Game.EnablePlayerControls(0, 0, 1, 1, 1, 0, 0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
