;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MenuSoftEvents Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if Game.GetModByName("Simpleslavery.esp")!= 255
	mainquest.simpleslavery = true
else
	mainquest.simpleslavery = false
endif

if Game.GetModByName("BrandingDeviceOfDoom.esp")!= 255
	mainquest.brandingDevice = true
else
	mainquest.brandingDevice = false
endif

if Game.GetModByName("SlaveTats.esp")!= 255
	mainquest.slaveTatoos = true
else
	mainquest.slaveTatoos = false  
endif

if Game.GetModByName("MilkModNEW.esp")!= 255
	Faction milkmaid = Game.GetFormFromFile(0x04d53b, "MilkModNEW.esp") as Faction
	Faction milkslave= Game.GetFormFromFile(0x056707, "MilkModNEW.esp") as Faction
	if Game.GetPlayer().IsInFaction(milkmaid) || Game.GetPlayer().IsInFaction(milkslave) 
		mainquest.milkmod = false
		mainquest.milkfeeding = true
	else
		mainquest.milkmod = true
		mainquest.milkfeeding = false
	endif
else
	mainquest.milkmod = false  
	mainquest.milkfeeding = false
endif

if myUtilities.IsPlayerShaved(Game.Getplayer())
	mainquest.hairshaveble = false
else
	mainquest.hairshaveble = true
endif

if Game.GetModByName("Deviously Cursed Loot.esp")!= 255
	mainquest.cursedloot = true
else
	mainquest.cursedloot = false  
endif

if Game.GetModByName("SexLabSkoomaWhore.esp")!= 255
	mainquest.skoomawhore = true
else
	mainquest.skoomawhore = false  
endif

if Game.GetModByName("yps-ImmersivePiercing.esp")!= 255
	mainquest.immersiveFashion = true
else
	mainquest.immersiveFashion = false
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_SoftDependency Property mainquest auto
SLV_MCMMenu Property ThisMenu auto
SLV_HeadShaving Property myUtilities auto