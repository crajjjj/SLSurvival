;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining2_7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)

if Game.GetModByName("WerewolfMastery.esp")!= 255
	Game.GetPlayer().AddSpell(Game.GetFormFromFile(0x04003F, "WerewolfMastery.esp") as Spell, false)
endif
if Game.GetModByName("Brevi_MoonlightTales.esp")!= 255
	Game.GetPlayer().AddSpell(Game.GetFormFromFile(0x09D8CE, "Brevi_MoonlightTales.esp") as Spell, false)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
