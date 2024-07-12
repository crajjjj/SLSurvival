;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 113
Scriptname SLV_CelebrateSlaveryPartyScene Extends Scene Hidden

;BEGIN FRAGMENT Fragment_39
Function Fragment_39()
;BEGIN CODE
MiscUtil.PrintConsole("Begin 14")

Int PSQSkinColor = -10729418
Game.SetTintMaskColor(PSQSkinColor, 6, 0)
Game.GetPlayer().QueueNiNodeUpdate()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
game.DisablePlayerControls(true, true, false, false, true, true, true, true)
game.EnablePlayerControls(false, false, true, true, false, false, false, false)
Game.ForceThirdPerson()
game.DisablePlayerControls(true, true, false, false, true, true, true, true)
;Debug.notification("End 9")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
MiscUtil.PrintConsole("Begin 6")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_107
Function Fragment_107()
;BEGIN CODE
if !ThisMenu.DieOnBadEnd
	Debug.messagebox("As you die, you feel your soul being dragged away and you hear a known voice laughing.")
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
;Debug.notification("Begin 2")
MiscUtil.PrintConsole("Begin 2")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
MiscUtil.PrintConsole("Begin 15")

Int PSQSkinColor = -16777216
Game.SetTintMaskColor(PSQSkinColor, 6, 0)
Game.GetPlayer().QueueNiNodeUpdate()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_98
Function Fragment_98()
;BEGIN CODE
if !ThisMenu.DieOnBadEnd
	ActorUtil.ClearPackageOverride(Game.GetPlayer())
	Game.GetPlayer().evaluatePackage()

	Game.EnablePlayerControls()
	game.SetPlayerAIDriven(false)
	SendModEvent("dhlp-Resume")


	SLV_EnforcerIgnorePC.setValue(0)

	sendModEvent("SlaverunReloaded_FreeSkyrim")

	GetOwningQuest().SetObjectiveCompleted(7000)
	GetOwningQuest().SetStage(10000)
	GetOwningQuest().stop()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN CODE
MiscUtil.PrintConsole("Begin 1")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
;Debug.notification("End 6")
SecondPole.disable()
FirstPole.disable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_37
Function Fragment_37()
;BEGIN CODE
MiscUtil.PrintConsole("Begin 12")

sendModEvent("SlaverunReloaded_OrgasmSound")

Int PSQSkinColor = -4370663
Game.SetTintMaskColor(PSQSkinColor, 6, 0)
Game.GetPlayer().QueueNiNodeUpdate()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_33
Function Fragment_33()
;BEGIN CODE
MiscUtil.PrintConsole("Begin 7")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_58
Function Fragment_58()
;BEGIN CODE
if ThisMenu.DieOnBadEnd
	Game.EnablePlayerControls()
	game.SetPlayerAIDriven(false)
	SendModEvent("dhlp-Resume")

	GetOwningQuest().SetObjectiveCompleted(7000)
	GetOwningQuest().SetStage(10000)

    	Game.GetPlayer().Kill()

	GetOwningQuest().stop()
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
;Debug.notification("End 8")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34()
;BEGIN CODE
MiscUtil.PrintConsole("Begin 8")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_38
Function Fragment_38()
;BEGIN CODE
MiscUtil.PrintConsole("Begin 13")

Int PSQSkinColor = -8372979
Game.SetTintMaskColor(PSQSkinColor, 6, 0)
Game.GetPlayer().QueueNiNodeUpdate()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
MiscUtil.PrintConsole("Begin 11")

if ThisMenu.ypsFashionShaving
	shaveScripts.Shave(Game.GetPlayer())
else
	String haircut = "HairFemaleRedguard03" 
	HeadPart shavedHair = HeadPart.GetHeadPart(haircut)

	Game.GetPlayer().ChangeHeadPart(shavedHair)
	Game.GetPlayer().RegenerateHead()
endif


Int PSQSkinColor = -3407821
Game.SetTintMaskColor(PSQSkinColor, 6, 0)
Game.GetPlayer().QueueNiNodeUpdate()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_63
Function Fragment_63()
;BEGIN CODE
FirstPole.Enable()
;SecondPole.disable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_60
Function Fragment_60()
;BEGIN CODE
Game.ForceThirdPerson()
game.EnablePlayerControls(false, false, false, true, false, false, false, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18()
;BEGIN CODE
Game.ForceThirdPerson()
;Debug.notification("End 7")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.ForceThirdPerson()
;Game.EnablePlayerControls(0, 0, 1, 1, 1, 0, 0)
;Debug.notification("End 15") 


SLV_SlaveryMainquest.SetObjectiveCompleted(12000)
SLV_SlaveryMainquest.SetStage(20000)

Debug.messagebox("This is the bad end of Slaverun Reloaded. Thank you for playing.")
SLV_EnforcerIgnorePC.setValue(1)
SLV_StopEnforcer.setValue(0)

SendModEvent("dhlp-Resume")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_31
Function Fragment_31()
;BEGIN CODE
MiscUtil.PrintConsole("Begin 5")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
;Debug.notification("Begin 4")
MiscUtil.PrintConsole("Begin 4")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
;Debug.notification("End 12")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
;Debug.notification("End 11")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
;Debug.notification("Begin 3")
MiscUtil.PrintConsole("Begin 3")
SecondPole.enable()
Game.ForceThirdPerson()
game.EnablePlayerControls(false, false, false, true, false, false, false, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_35
Function Fragment_35()
;BEGIN CODE
MiscUtil.PrintConsole("Begin 9")
Game.ForceThirdPerson()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
;Game.ForceFirstPerson()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_36
Function Fragment_36()
;BEGIN CODE
MiscUtil.PrintConsole("Begin 10")
sendModEvent("SlaverunReloaded_OrgasmSound")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
;Debug.notification("End 10")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property NextScene  Auto  
ObjectReference Property FirstPole Auto
ObjectReference Property SecondPole Auto
GlobalVariable Property SLV_EnforcerIgnorePC  Auto  
GlobalVariable Property SLV_StopEnforcer  Auto 

SlV_MCMMenu Property ThisMenu auto
Quest Property SLV_SlaveryMainquest Auto
Sound Property Scream  Auto
SLV_HeadShaving Property shaveScripts auto



