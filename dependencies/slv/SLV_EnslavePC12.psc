;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_EnslavePC12 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(3000)

Int TargetModIndex1
TargetModIndex1 = Game.GetModByName("SlaveTats.esp")

if MCMMenu.SlaveShaving
	shaveScripts.Shave(Game.GetPlayer())
	shaveScripts.ShaveBodyHair()
endif

if  TargetModIndex1 != 255 && MCMMenu.SlaveTatoos
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slutmarks", "Cunt (right cheek)", silent = true)
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left cheek)", silent = true)
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (forehead)", silent = true)
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left hand)", silent = true)
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (right hand)", silent = true)
endif

myScripts.SLV_enslavementFull(false)
myScripts.SLV_enslavementChains(Game.getPlayer())
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto
SLV_HeadShaving Property shaveScripts auto 
