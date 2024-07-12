;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 21
Scriptname SLV_SuccubusDrainSexScene Extends Scene Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Prisoner.getActorRef().kill()
SendModEvent("dhlp-Resume")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
;SLV_Dremora.getactorRef().moveto(Game.GetPlayer())
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
StorageUtil.SetIntValue(Game.getPlayer(), "PSQ_SpellON", 1)
SendModEvent("SLHisSuccubus")
ModEvent.Send(ModEvent.Create("HoSLDD_GivePlayerPowers"))

Utility.wait(3.0)
Spell succubus = Game.GetFormFromFile(0x001241, "PSQ PlayerSuccubusQuest.esm") as Spell
succubus.cast(Game.getPlayer())
Utility.wait(3.0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto  
ReferenceAlias Property Prisoner Auto  
ReferenceAlias Property SLV_Dremora Auto 



