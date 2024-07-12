;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat45 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(GetOwningQuest().getStage())
GetOwningQuest().SetStage(4000)

myScripts.SLV_enslavementFull(false)
myScripts.SLV_enslavementChains(Game.getPlayer())

ActorUtil.ClearPackageOverride(SLV_Bellamy.getactorref())
SLV_Bellamy.getactorref().evaluatePackage()

if MCMMenu.SlaveShaving
	shaveScripts.Shave(Game.GetPlayer())
	shaveScripts.ShaveBodyHair()
endif

if MCMMenu.SlaveTatoos
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slutmarks", "Cunt (right cheek)", silent = true)
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left cheek)", silent = true)
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (forehead)", silent = true)
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left hand)", silent = true)
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (right hand)", silent = true)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Bellamy Auto
SLV_MCMMenu Property MCMMenu Auto

SLV_HeadShaving Property shaveScripts auto 