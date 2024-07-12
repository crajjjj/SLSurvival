;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_MainAnimal_Sex Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if MCMMenu.skipCreatureSex
	Game.FadeOutGame(false, true, 5.0, 10.0)
	debug.messagebox("When you regain consciousness, you body hurts as hell and you a drenched in cum.")
	SLV_SexIsRunning.setvalue(0)
	return
endif

myScripts.SLV_PlaySex2Synchron(Game.GetPlayer(),akSpeaker,"Doggystyle, Sex", true)
SLV_SexIsRunning.setvalue(0)

if Attacker== Werwolf
	if Game.GetModByName("WerewolfMastery.esp")!= 255
		Game.GetPlayer().AddSpell(Game.GetFormFromFile(0x04003F, "WerewolfMastery.esp") as Spell, false)
	endif
	if Game.GetModByName("Brevi_MoonlightTales.esp")!= 255
		Game.GetPlayer().AddSpell(Game.GetFormFromFile(0x09D8CE, "Brevi_MoonlightTales.esp") as Spell, false)
	endif
else 
	MiscUtil.PrintConsole("No Werwolf")
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property Attacker Auto  
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_MCMMenu Property MCMMenu Auto
SLV_Utilities Property myScripts auto
Actor Property Werwolf Auto  



